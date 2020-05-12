// Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

/**
 * @file aws_conveyor_shadow.c
 *
 * Contains the logic concerning communication with the AWS IoT Device Shadow.
 *
 * Listens for a change in desired state, updates actual state accordingly, and
 * updates the device shadow with reported state.
 */

/* Standard includes. */
#include <stdio.h>
#include <string.h>

/* FreeRTOS includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "queue.h"

/* Conveyor demo includes. */
#include "conveyor_include/aws_conveyor_shared.h"
#include "conveyor_include/aws_conveyor_telemetry.h"
#include "conveyor_include/aws_conveyor_shadow.h"

/* Include LED driver. */
#include "conveyor_include/ws2812.h"

/* Demo configurations. */
#include "aws_demo_config.h"

/* Required to get the broker address and port. */
#include "aws_clientcredential.h"

/* Required for shadow APIs. */
#include "aws_shadow.h"

/* ESP-IDF GPIO include. */
#include "driver/gpio.h"

/* ESP-IDF Timer includes. */
#include "soc/timer_group_struct.h"
#include "driver/periph_ctrl.h"
#include "driver/timer.h"

/* Required for parsing */
#include "jsmn.h"

/* JSON formats used in the Shadow tasks. Note the inclusion of the "clientToken"
 * key, which is REQUIRED by the Shadow API. The "clientToken" may be anything, as
 * long as it's unique. This demo uses "token-" suffixed with the RTOS tick count
 * at the time the JSON document is generated. */
#define REPORT_JSON_TEMPLATE                  \
    "{"                                       \
    "\"state\":{"                             \
    "\"reported\":"                           \
    "%s"                                      \
    "},"                                      \
    "\"clientToken\": \"token-%d\""           \
    "}"

/* Maximum amount of time a Shadow function call may block. */
#define SHADOW_TIMEOUT                       pdMS_TO_TICKS( 30000UL )

/* Name of the thing. */
#define THING_NAME                           clientcredentialIOT_THING_NAME

/* Maximum size of reported state within update JSON documents. */
#define REPORTED_BUFFER_LENGTH               50

/* Maximum size of update JSON documents. */
#define JSON_BUFFER_LENGTH                   128

/* Maximum number of jsmn tokens. */
#define MAX_TOKENS                           100

/* Queue configuration parameters. */
#define SEND_QUEUE_WAIT_TICKS                3000
#define RECV_QUEUE_WAIT_TICKS                500
#define STPR_RECV_QUEUE_WAIT_TICKS           0

/* The maximum amount of time tasks will wait for their updates to process.
 * Tasks should not continue executing until their updates have processed.*/
#define NOTIFY_WAIT_MS                       pdMS_TO_TICKS( ( 100000UL ) )

/* Task names. */
#define CONNECTION_TASK_NAME                 "ConnectionTask"
#define UPDATE_TASK_NAME                     "UpdateTask"
#define STEPPER_TASK_NAME                    "StepperTask"
#define MANAGER_TASK_NAME                    "ManagerTask"

/* Stack size for task that continuously checks shadow connection. */
#define CONNECTION_TASK_STACK_SIZE           ( ( uint16_t ) configMINIMAL_STACK_SIZE * ( uint16_t ) 5 )

/* Stack size for task that handles shadow delta and updates. */
#define UPDATE_TASK_STACK_SIZE               ( ( uint16_t ) configMINIMAL_STACK_SIZE * ( uint16_t ) 5 )

/* Stack size for task that controls the stepper motor. */
#define STEPPER_TASK_STACK_SIZE              ( ( uint16_t ) configMINIMAL_STACK_SIZE * ( uint16_t ) 5 )

/* Stack size for task that manages reported state and actual state. */
#define MANAGER_TASK_STACK_SIZE              ( ( uint16_t ) configMINIMAL_STACK_SIZE * ( uint16_t ) 5 )

/* Length for queue configuration. */
#define QUEUE_LENGTH                         democonfigSHADOW_DEMO_NUM_TASKS * 2

/* Hardware timer definitions. */
#define TIMER_DIVIDER                        80               /* Hardware timer clock divider, 80 to get 1MHz clock to timer */
#define TIMER_GROUP                          TIMER_GROUP_0
#define TIMER_IDX                            TIMER_0
#define ALARM_VALUE_SLOW                     120              /* Alarm will trigger every 120us */
#define ALARM_VALUE_FAST                     25               /* Alarm will trigger every 25us */

/* Motor control definitions. */
#define BACKWARD                             1
#define STOPPED                              2
#define FORWARD                              3
#define SLOW                                 1
#define FAST                                 2
#define HIGH                                 1
#define LOW                                  0

/* Belt jam detection buffer times. */
#define TIME_SINCE_MOVEMENT                  700              /* Will equate to 7000ms */
#define TIME_SINCE_RECONNECT                 300              /* Will equate to 3000ms */

/* Bounds for desired speed and mode. */
#define MIN_DESIRED_SPEED                    1
#define MAX_DESIRED_SPEED                    2
#define MIN_DESIRED_MODE                     1
#define MAX_DESIRED_MODE                     3

/* Shadow connection constants. */
#define CONNECTION_TASK_DELAY                2000             /* Will equate to 2000ms */
#define CONNECTION_TASK_FAIL_LIMIT           3
#define SHADOW_CONNECTION_FAIL_LIMIT         5

/* An element for our queues. Holds generated reported state and requested mode & speed. */
typedef struct
{
    uint32_t ulDataLength;
    char pcUpdateBuffer[ JSON_BUFFER_LENGTH ];
    uint8_t usMode;
    uint8_t usSpeed;
} QueueData_t;

/* The queues' handles, data structures, and memory. */
static QueueHandle_t xUpdateQueue  = NULL;
static QueueHandle_t xStepperQueue = NULL;
static QueueHandle_t xManagerQueue = NULL;
static StaticQueue_t xUpdateStaticQueue;
static StaticQueue_t xStepperStaticQueue;
static StaticQueue_t xManagerStaticQueue;
static uint8_t ucQueueStorageArea[ QUEUE_LENGTH * sizeof( QueueData_t ) ];

/* The handle of the Shadow client shared across all shadow tasks. */
static ShadowClientHandle_t xClientHandle;

/* Task handle for inter-task communication */
static TaskHandle_t xManagerTaskHandle = NULL;

/* Initialize actual state variables. Represent the actual speed and mode of stepper motor. */
static uint8_t usActualMode  = 0;
static uint8_t usActualSpeed = 0;

/* Initialize timer count for interrupt. */
static volatile long vTimerCount = 0;

/* Initialize timestamp used to give buffer time between reconnection to services and reporting of belt jam */
static unsigned long uTimeOfReconnect = 0;

/* Initialize error state flag */
BaseType_t xConveyorErrorFlag = pdFALSE;

/* Initialize Reset Counter */
BaseType_t xConveyorResetCnt  = 0;

/**
 * @brief Generates reported state json document and returns document's length.
 *
 * @param[in] pxQueueData Queue struct whose pcUpdateBuffer value will hold the generated json doc.
 * @param[in] usErrorState Error flag that will be included in reported state document (1 or 0).
 *
 * @return Length of generated reported state json document.
 */
static uint32_t prvGenerateReportedJSON( QueueData_t * const pxQueueData, uint8_t usErrorState );

/**
 * @brief Compares chosen parsed token to pcString to test for equality.
 *
 * @param[in] pcJson The full json document that is being parsed.
 * @param[in] pxTok The jsmn token that we are comparing to pcString.
 * @param[in] pcString The string to test against for equality.
 *
 * @return pdTRUE if equal, pdFALSE otherwise.
 */
static BaseType_t prvIsStringEqual( const char * const pcJson,
                                    const jsmntok_t * const pxTok,
                                    const char * const pcString );

/**
 * @brief Returns true if speed and mode from new desired state are valid; false otherwise.
 *
 * @param[in] usSpeed The speed value received from the desired state document.
 * @param[in] usMode The mode value received from the desired state document.
 * @param[in] xFoundSpeed Flag holding whether or not a speed value was in the desired state document.
 * @param[in] xFoundMode Flag holding whether or not a mode value was in the desired state document.
 *
 * @return pdTRUE if speed and mode are valid, pdFALSE otherwise.
 */
static BaseType_t prvValidDesiredState( uint8_t usSpeed, uint8_t usMode, BaseType_t xFoundSpeed, BaseType_t xFoundMode );

/**
 * @brief Called after belt jam to report an error state.
 *
 * Generates reported json with "error": 1 and calls the updateQueueTask to update the device shadow.
 *
 * @param[in] None.
 *
 * @return void.
 */
static void prvReportError( void );

/**
 * @brief Called during initialization of shadow document and by prvDeltaCallback to
 * take in and process desired state.
 *
 * Parses delta json document for requested speed and mode. If valid, packages up
 * the speed and mode into a QueueData_t struct and sends it along to the manager task
 * so it can control order of flow between actual and reported state.
 *
 * @param[in] pcShadowDocument The json document containing the desired state to respond to.
 * @param[in] ulDocumentLength Length of pcShadowDocument.
 *
 * @return void.
 */
static void prvRespondToDesiredState( const char * const pcShadowDocument, uint32_t ulDocumentLength );

/**
 * @brief Called when desired state differs from reported state, i.e. when desired state is changed.
 *
 * Passes on data to prvRespondToDesiredState function to continue logic flow.
 *
 * @param[in] pvUserData Default callback variable holding user data - ignored.
 * @param[in] pcThingName Default callback variable holding IoT thing name - ignored.
 * @param[in] pcDeltaDocument The delta json document.
 * @param[in] ulDocumentLength Length of pcDeltaDocument.
 * @param[in] xBuffer Default callback variable holding handle to buffer - ignored.
 *
 * @return pdFalse always.
 */
static BaseType_t prvDeltaCallback( void * pvUserData,
                                    const char * const pcThingName,
                                    const char * const pcDeltaDocument,
                                    uint32_t ulDocumentLength,
                                    MQTTBufferHandle_t xBuffer );

/**
 * @brief Raises xDisconnectFlag if we lose connection to shadow client.
 *
 * Calls SHADOW.Get() repeatedly to check shadow client connection.
 * If the call fails three times in a row, the task will raise xDisconnectFlag
 * to alert main.c's watchdog task that a reconnect is needed.
 *
 * @param[in] pvParameters Default task parameters - ignored.
 *
 * @return void.
 */
static void prvCheckShadowConnectionTask( void * pvParameters );

/**
 * @brief Calls SHADOW.Update() to update device shadow's reported state.
 *
 * @param[in] pvParameters Default task parameters - ignored.
 *
 * @return void.
 */
static void prvUpdateQueueTask( void * pvParameters );

/**
 * @brief Steps the stepper motor according to desired speed and mode.
 *
 * Continuously checks to see if a request has come in to update the speed or mode of the conveyor
 * belt. When it receives a request from the manager task containing a new mode and/or speed, it will instruct
 * the stepper motor to perform accordingly. This interaction with the stepper motor consists of
 * toggling GPIO pins and manipulating a hardware timer that pulses the stepper motor via a
 * system of alarms and interrupts. Once this is done, the task will then send a response
 * back to the manager task, letting it know that actual state has been updated. Also checks
 * for belt jams by comparing rpm to reported mode.
 *
 * @param[in] pvParameters Default task parameters - ignored.
 *
 * @return void.
 */
static void prvStepperTask( void * pvParameters );

/**
 * @brief Controls order of flow between changes to actual state and reported state.
 *
 * First sends request to Stepper Task to update actual state. Upon notification that
 * this has been completed, sends request to Update Queue Task to update reported state.
 *
 * @param[in] pvParameters Default task parameters - ignored.
 *
 * @return void.
 */
static void prvManagerTask( void * pvParameters );

/**
 * @brief Interrupt handler for hardware timer.
 *
 * Pulses the stepper motor when triggered.
 *
 * @param[in] pvParameters Default task parameters.
 *
 * @return void.
 */
static void IRAM_ATTR prvTimerInterruptHandler( void * pvParameters );

/**
 * @brief Disconnects Shadow client from MQTT broker.
 *
 * Used externally in main.c during reconnection process.
 *
 * @param[in] None.
 *
 * @return eShadowSuccess if success, error code otherwise.
 */
static ShadowReturnCode_t prvShadowClientDisconnect( void );

/*-----------------------------------------------------------*/

static uint32_t prvGenerateReportedJSON( QueueData_t * const pxQueueData, uint8_t usErrorState )
{
    /* Create sub-string of reported state document by pulling in actual speed and mode. */
    char cReportedState[ REPORTED_BUFFER_LENGTH ];
    ( void ) snprintf( cReportedState,
                       REPORTED_BUFFER_LENGTH,
                       "{\"speed\":%u,\"mode\":%u,\"reset\":%u,\"error\":%u}",
                       usActualSpeed,
                       usActualMode,
                       xConveyorResetCnt,
                       usErrorState );

    /* Create full reported state document, attach it to the queue data struct, and return length of doc */
    return ( uint32_t ) snprintf( ( char * ) ( pxQueueData->pcUpdateBuffer ),
                                  JSON_BUFFER_LENGTH,
                                  REPORT_JSON_TEMPLATE,
                                  cReportedState,
                                  ( int ) xTaskGetTickCount() );
}

/*-----------------------------------------------------------*/

static BaseType_t prvIsStringEqual( const char * const pcJson,
                                    const jsmntok_t * const pxTok,
                                    const char * const pcString )
{
    uint32_t ulStringSize = ( uint32_t ) pxTok->end - ( uint32_t ) pxTok->start;
    BaseType_t xStatus = pdFALSE;

    if( pxTok->type == JSMN_STRING )
    {
        if( ( pcString[ ulStringSize ] == 0 ) &&
            ( strncmp( pcJson + pxTok->start, pcString, ulStringSize ) == 0 ) )
        {
            xStatus = pdTRUE;
        }
    }

    return xStatus;
}

/*-----------------------------------------------------------*/

static BaseType_t prvValidDesiredState( uint8_t usSpeed,
                                        uint8_t usMode,
                                        BaseType_t xFoundSpeed,
                                        BaseType_t xFoundMode)
{
    /* If neither speed, mode is present in desired state, then invalid. */
    if( xFoundSpeed == pdFALSE && xFoundMode == pdFALSE)
    {
        return pdFALSE;
    }
    /* If there is a speed in the json doc that is not within our bounds, then invalid. */
    if( xFoundSpeed == pdTRUE && !( usSpeed >= MIN_DESIRED_SPEED && usSpeed <= MAX_DESIRED_SPEED ) )
    {
        return pdFALSE;
    }
    /* If there is a mode in the json doc that is not within our bounds, then invalid. */
    else if( xFoundMode == pdTRUE && !( usMode >= MIN_DESIRED_MODE && usMode <= MAX_DESIRED_MODE ) )
    {
        return pdFALSE;
    }
    return pdTRUE;
}

/*-----------------------------------------------------------*/

static void prvReportError( void )
{
    QueueData_t xQueueData;

    /* Clear up space in memory for queue data struct */
    memset( &xQueueData, 0x00, sizeof( QueueData_t ) );

    /* Generate a new JSON document with error state and add it to queue data struct. */
    xQueueData.ulDataLength = prvGenerateReportedJSON( &xQueueData, 1 );

    /* Add new ERROR reported state to update queue. */
    if( xQueueSendToBack( xUpdateQueue, &xQueueData, SEND_QUEUE_WAIT_TICKS ) == pdTRUE )
    {
        configPRINTF( ( "Successfully added new ERROR reported state to update queue.\r\n" ) );
    }
    else
    {
        configPRINTF( ( "Update queue full, deferring reported state update.\r\n" ) );
    }
}

/*-----------------------------------------------------------*/

static void prvRespondToDesiredState( const char * const pcShadowDocument, uint32_t ulDocumentLength )
{
    int32_t lNbTokens;
    uint16_t usTokenIndex;
    jsmn_parser xJSMNParser;
    QueueData_t xQueueData;
    jsmntok_t pxJSMNTokens[ MAX_TOKENS ];

    /* Declare and initialize variables used in parsing process */
    BaseType_t xFoundMode  = pdFALSE;
    BaseType_t xFoundSpeed = pdFALSE;
    BaseType_t xFoundReset = pdFALSE;

    /* Initialize json parser */
    jsmn_init( &xJSMNParser );

    /* Clear up space in memory for queue data struct */
    memset( &xQueueData, 0x00, sizeof( QueueData_t ) );

    /* Parse the json document into an array of tokens */
    lNbTokens = ( int32_t ) jsmn_parse( &xJSMNParser,
                                        pcShadowDocument,
                                        ( size_t ) ulDocumentLength,
                                        pxJSMNTokens,
                                        ( unsigned int ) MAX_TOKENS );

    /* If parsing worked correctly and we received tokens */
    if( lNbTokens > 0 )
    {
        /* Loop through the tokens array that jsmn_parse filled */
        for( usTokenIndex = 0; usTokenIndex < ( uint16_t ) lNbTokens; usTokenIndex++ )
        {
            /* If this token is "speed", grab the next token and save it as the desired speed. */
            if( prvIsStringEqual( pcShadowDocument, &pxJSMNTokens[ usTokenIndex ], "speed" ) == pdTRUE && xFoundSpeed == pdFALSE )
            {
                /* Grab this token */
                jsmntok_t speedTok = pxJSMNTokens[ usTokenIndex + 1 ];
                xQueueData.usSpeed = atoi( &pcShadowDocument[ speedTok.start ]);
                xFoundSpeed = pdTRUE;
            }
            /* If this token is "mode", grab the next token and save it as the desired mode. */
            else if( prvIsStringEqual( pcShadowDocument, &pxJSMNTokens[ usTokenIndex ], "mode" ) == pdTRUE && xFoundMode == pdFALSE )
            {
                /* Grab this token */
                jsmntok_t modeTok = pxJSMNTokens[ usTokenIndex + 1 ];
                xQueueData.usMode = atoi( &pcShadowDocument[ modeTok.start ] );
                xFoundMode = pdTRUE;
            }
            /* If this token is "reset", grab the next token and save it as the requested reset count. */
            else if( prvIsStringEqual( pcShadowDocument, &pxJSMNTokens[ usTokenIndex ], "reset" ) == pdTRUE && xFoundReset == pdFALSE )
            {
                /* Grab this token */
                jsmntok_t resetTok = pxJSMNTokens[ usTokenIndex + 1 ];
                BaseType_t tmpResetCnt = atoi( &pcShadowDocument[ resetTok.start ]);

                if(xConveyorResetCnt < tmpResetCnt)
                {
                   xFoundReset       = pdTRUE;
                   xConveyorResetCnt = tmpResetCnt;
                }
            }
            /* If we've found both mode and speed, no need to keep looping
             * (saves some time when both change in desired state) */
            if( xFoundSpeed == pdTRUE && xFoundMode == pdTRUE  && xFoundReset == pdTRUE )
            {
                break;
            }
        }

        /* Don't do any processing if conveyor is in error mode. */
        if( xConveyorErrorFlag == pdTRUE && xFoundReset == pdFALSE)
        {
            configPRINTF( ( "Conveyor is in error mode, no reset request present. Cannot process desired state.\r\n" ) );
            return;
        }
        else if(xFoundReset == pdTRUE)
        {
            configPRINTF( ( "Reset request found. Resetting error state.\r\n" ) );
            xConveyorErrorFlag = pdFALSE;
            xFoundSpeed        = pdTRUE;   // Will make prvValidDesiredState succeed
            xFoundMode         = pdTRUE;
            xQueueData.usSpeed = SLOW;
            xQueueData.usMode  = STOPPED;
        }
        /* If desired speed and/or mode are valid, continue on with change of actual and reported state */
        if( prvValidDesiredState( xQueueData.usSpeed, xQueueData.usMode, xFoundSpeed, xFoundMode ) == pdTRUE )
        {
            /* Send struct to manager task so it can control order of flow between actual and reported state */
            if( xQueueSendToBack( xManagerQueue, &xQueueData, SEND_QUEUE_WAIT_TICKS ) == pdTRUE )
            {
                configPRINTF( ( "Successfully sent request to manager queue.\r\n" ) );
            }
            else
            {
                configPRINTF( ( "Manager queue full, deferring request.\r\n" ) );
            }
        }
        else
        {
            configPRINTF( ( "Invalid desired state.\r\n" ) );
        }
    }
    else
    {
        configPRINTF( ( "Shadow document is too large to parse. Please trim it down or increase MAX_TOKENS.\r\n" ) );
    }
}

/*-----------------------------------------------------------*/

static BaseType_t prvDeltaCallback( void * pvUserData,
                                    const char * const pcThingName,
                                    const char * const pcDeltaDocument,
                                    uint32_t ulDocumentLength,
                                    MQTTBufferHandle_t xBuffer )
{
    /* Silence compiler warnings about unused variables. */
    ( void ) pvUserData;
    ( void ) xBuffer;
    ( void ) pcThingName;

    /* Respond to the new desired state. */
    prvRespondToDesiredState( pcDeltaDocument, ulDocumentLength );

    return pdFALSE;
}
/*-----------------------------------------------------------*/

static void prvUpdateQueueTask( void * pvParameters )
{
    ShadowReturnCode_t xReturn;
    ShadowOperationParams_t xUpdateParams;
    QueueData_t xQueueData;

    ( void ) pvParameters;

    xUpdateParams.pcThingName = THING_NAME;
    xUpdateParams.xQoS = eMQTTQoS0;
    xUpdateParams.pcData = xQueueData.pcUpdateBuffer;
    /* Keep subscriptions across multiple calls to SHADOW_Update. */
    xUpdateParams.ucKeepSubscriptions = pdTRUE;

    for( ; ; )
    {
        if( xQueueReceive( xUpdateQueue, &xQueueData, RECV_QUEUE_WAIT_TICKS ) == pdTRUE )
        {
            xUpdateParams.ulDataLength = xQueueData.ulDataLength;

            /* Update shadow document with new reported state */
            xReturn = SHADOW_Update( xClientHandle, &xUpdateParams, SHADOW_TIMEOUT );

            if( xReturn == eShadowSuccess )
            {
                configPRINTF( ( "Successfully performed shadow update.\r\n" ) );
            }
            else
            {
                configPRINTF( ( "Update failed, returned %d.\r\n", xReturn ) );
            }
        }
    }
}

/*-----------------------------------------------------------*/

static void prvCheckShadowConnectionTask( void * pvParameters )
{
    ( void ) pvParameters;
    ShadowReturnCode_t xReturn;
    ShadowOperationParams_t xOperationParams;
    xOperationParams.pcThingName = THING_NAME;
    xOperationParams.xQoS = eMQTTQoS0;
    xOperationParams.pcData = NULL;
    xOperationParams.ucKeepSubscriptions = pdFALSE;

    /* Holds the number of times SHADOW_Get() has failed in a row. */
    uint8_t usFailCount = 0;

    for( ; ; )
    {
        /* Delay task according to CONNECTION_TASK_DELAY. */
        vTaskDelay( CONNECTION_TASK_DELAY / portTICK_PERIOD_MS );

        /* Don't run this task if the watchdog task is busy reconnecting. */
        if( xDisconnectFlag == pdFALSE )
        {
            xReturn = SHADOW_Get( xClientHandle, &xOperationParams, SHADOW_TIMEOUT );

            /* If we successfully got the shadow... */
            if( xReturn == eShadowSuccess )
            {
                /* Return the MQTT Buffer taken by SHADOW_Get. */
                SHADOW_ReturnMQTTBuffer( xClientHandle, xOperationParams.xBuffer );

                /* Set usFailCount to 0. */
                usFailCount = 0;
            }
            else
            {
                usFailCount++;
            }

            /* If usFailCount reaches CONNECTION_TASK_FAIL_LIMIT, raise xDisconnectFlag. */
            if( usFailCount >= CONNECTION_TASK_FAIL_LIMIT )
            {
                configPRINTF( ( "Shadow Client disconnected. Raising xDisconnectFlag.\r\n" ) );
                xDisconnectFlag = pdTRUE;
                usFailCount = 0;
            }
        }
    }
}

/*-----------------------------------------------------------*/

static void prvStepperTask( void * pvParameters )
{
    QueueData_t xQueueData;
    ( void ) pvParameters;

    BaseType_t xStopped = pdTRUE;

    /* Initialize xLED_red color for belt jam. */
    rgbVal xLED_red = makeRGBVal(255, 0, 0);

    /* ulTimeOfMovement will hold timestamp of change from stopped -> moving */
    unsigned long ulTimeOfMovement = xTaskGetTickCount();

    for( ; ; )
    {
        if( xQueueReceive( xStepperQueue, &xQueueData, STPR_RECV_QUEUE_WAIT_TICKS ) == pdTRUE )
        {
            /* Check for requested change in mode */
            if( xQueueData.usMode == FORWARD )
            {
                configPRINTF( ( "Received request in stepper task. Setting mode to FORWARD.\r\n" ) );
                xStopped = pdFALSE;
                ulTimeOfMovement = xTaskGetTickCount();

                /* Set stepper motor GPIO pins accordingly */
                gpio_set_level( ENA_PIN, LOW );
                gpio_set_level( DIR_PIN, HIGH );

                /* Start hardware timer to step motor */
                timer_start( TIMER_GROUP, TIMER_IDX );

                /* Set usActualMode global for reference when generating reported json */
                usActualMode = 3;
            }
            else if( xQueueData.usMode == BACKWARD )
            {
                configPRINTF( ( "Received request in stepper task. Setting mode to BACKWARD.\r\n" ) );
                xStopped = pdFALSE;
                ulTimeOfMovement = xTaskGetTickCount();

                /* Set stepper motor GPIO pins accordingly */
                gpio_set_level( ENA_PIN, LOW );
                gpio_set_level( DIR_PIN, LOW );

                /* Start hardware timer to step motor */
                timer_start( TIMER_GROUP, TIMER_IDX );

                /* Set usActualMode global for reference when generating reported json */
                usActualMode = 1;
            }
            else if( xQueueData.usMode == STOPPED )
            {
                configPRINTF( ( "Received request in stepper task. Setting mode to STOPPED.\r\n" ) );
                xStopped = pdTRUE;

                /* Set stepper motor GPIO pins accordingly */
                gpio_set_level( ENA_PIN, HIGH );

                /* Stop hardware timer to stop stepping motor */
                timer_pause( TIMER_GROUP, TIMER_IDX );

                /* Set usActualMode global for reference when generating reported json */
                usActualMode = 2;
            }

            /* Check for requested change in speed */
            if( xQueueData.usSpeed == SLOW )
            {
                configPRINTF( ( "Received request in stepper task. Setting speed to SLOW.\r\n" ) );

                /* Set timer's alarm value to slow - this makes the motor step slowly */
                timer_set_alarm_value( TIMER_GROUP, TIMER_IDX, ALARM_VALUE_SLOW );

                /* Set usActualSpeed global for reference when generating reported json */
                usActualSpeed = 1;
            }
            else if( xQueueData.usSpeed == FAST )
            {
                configPRINTF( ( "Received request in stepper task. Setting speed to FAST.\r\n" ) );

                /* Set timer's alarm value to fast - this makes th emotor step quickly */
                timer_set_alarm_value( TIMER_GROUP, TIMER_IDX, ALARM_VALUE_FAST );

                /* Set usActualSpeed global for reference when generating reported json */
                usActualSpeed = 2;
            }

            /* Send message back to manager task that actual state has been updated. */
            configPRINTF( ( "Notifying manager task that actual state has been updated.\r\n" ) );
            xTaskNotifyGive( xManagerTaskHandle );
        }

        /* Belt jam detection. If all of the following conditions are true, then we report a belt jam:
         * the demo is not in error mode already, the current mode is not STOPPED, we are reading 0 or >=100 rpm,
         * it has been more than TIME_SINCE_MOVEMENT since we changed mode from STOPPED, we are not currently
         * reconnecting to services, and it has been more then TIME_SINCE_RECONNECT since we regained
         * connection to services (if we ever lost connection). */
        if( xConveyorErrorFlag == pdFALSE && xStopped == pdFALSE && ( uGetRpm() == 0 || uGetRpm() >= 100 ) && \
            ( xTaskGetTickCount() - ulTimeOfMovement >= TIME_SINCE_MOVEMENT ) && \
            xDisconnectFlag == pdFALSE && ( xTaskGetTickCount() - uTimeOfReconnect >= TIME_SINCE_RECONNECT ) )
        {
            /* Stop conveyor and report error */
            xConveyorErrorFlag = pdTRUE;
            timer_pause( TIMER_GROUP, TIMER_IDX );
            gpio_set_level( ENA_PIN, HIGH );
            prvReportError();

            /* Set LED to red to show we are in error mode. */
            xPixels[0] = xLED_red;
            ws2812_setColors(PIXEL_COUNT, xPixels);
        }
    }
}

/*-----------------------------------------------------------*/

static void prvManagerTask( void * pvParameters )
{
    QueueData_t xQueueData;
    ( void ) pvParameters;

    for( ; ; )
    {
        if( xQueueReceive( xManagerQueue, &xQueueData, RECV_QUEUE_WAIT_TICKS ) == pdTRUE )
        {
            /* Send speed and mode to stepper queue so that stepper task can update output to stepper motor. */
            if( xQueueSendToBack( xStepperQueue, &xQueueData, SEND_QUEUE_WAIT_TICKS ) == pdTRUE )
            {
                configPRINTF( ( "Successfully sent request to stepper queue.\r\n" ) );

                /* Wait for notification that stepper motor actual state has been updated before updating reported state. */
                configASSERT( ulTaskNotifyTake( pdTRUE, NOTIFY_WAIT_MS ) == 1 );
                configPRINTF( ( "Stepper motor actual state has been updated.\r\n" ) );

                /* Generate a new JSON document with new reported state and add it to queue data struct. */
                xQueueData.ulDataLength = prvGenerateReportedJSON( &xQueueData, xConveyorErrorFlag );

                /* Add new reported state to update queue. */
                if( xQueueSendToBack( xUpdateQueue, &xQueueData, SEND_QUEUE_WAIT_TICKS ) == pdTRUE )
                {
                    configPRINTF( ( "Successfully added new reported state to update queue.\r\n" ) );
                }
                else
                {
                    configPRINTF( ( "Update queue full, deferring reported state update.\r\n" ) );
                }
            }
            else
            {
                configPRINTF( ( "Stepper queue full, deferring stepper request.\r\n" ) );
            }
        }
    }
}

/*-----------------------------------------------------------*/

static void IRAM_ATTR prvTimerInterruptHandler( void * pvParameters )
{
    /* We use TIMERG0 here instead of the usual timer API that we use
     * elsewhere because the API is not declared with IRAM_ATTR. */

    int timer_idx = ( int ) pvParameters;
    uint32_t ulIntrStatus = TIMERG0.int_st_timers.val;

    /* Make sure this interrupt was called by our hardware timer... */
    if( ulIntrStatus & BIT( timer_idx ) && timer_idx == TIMER_IDX )
    {
        /* If we are reconnecting to wifi / mqtt / shadow, don't run motor */
        if( xDisconnectFlag == pdFALSE )
        {
            /* Pulse step pin and increment count */
            gpio_set_level( STEP_PIN, vTimerCount % 2 );
            vTimerCount++;
        }

        TIMERG0.hw_timer[timer_idx].update = 1;
        TIMERG0.int_clr_timers.t0 = 1;

        /* After the alarm has been triggered we need enable it again. */
        TIMERG0.hw_timer[timer_idx].config.alarm_en = TIMER_ALARM_EN;
    }
}

/*-----------------------------------------------------------*/

void vSyncWithShadow( void )
{
    ShadowReturnCode_t xReturn;
    ShadowOperationParams_t xOperationParams;

    /* Get previous shadow state so that we can sync up actual state. */
    xOperationParams.pcThingName = THING_NAME;
    xOperationParams.xQoS = eMQTTQoS0;
    xOperationParams.pcData = NULL;
    /* Don't keep subscriptions, since SHADOW_Get is only called here once. */
    xOperationParams.ucKeepSubscriptions = pdFALSE;

    xReturn = SHADOW_Get( xClientHandle, &xOperationParams, SHADOW_TIMEOUT );

    /* If we successfully got the shadow, update actual and reported state accordingly. */
    if( xReturn == eShadowSuccess )
    {
        prvRespondToDesiredState( xOperationParams.pcData, xOperationParams.ulDataLength );

        /* Return the MQTT Buffer taken by SHADOW_Get. */
        SHADOW_ReturnMQTTBuffer( xClientHandle, xOperationParams.xBuffer );
    }
    else
    {
        configPRINTF( ( "Failed to get previous shadow upon boot. Proceeding as usual without sync.\r\n" ) );
    }
}

/*-----------------------------------------------------------*/

void vCreateShadowTasks( void )
{
    /* Create the task to constantly check the shadow connection. */
    ( void ) xTaskCreate( prvCheckShadowConnectionTask,
                          CONNECTION_TASK_NAME,
                          CONNECTION_TASK_STACK_SIZE,
                          NULL,
                          democonfigSHADOW_DEMO_TASK_PRIORITY,
                          NULL );

    /* Create the update task which will process the update queue. */
    ( void ) xTaskCreate( prvUpdateQueueTask,
                          UPDATE_TASK_NAME,
                          UPDATE_TASK_STACK_SIZE,
                          NULL,
                          democonfigSHADOW_DEMO_TASK_PRIORITY,
                          NULL );

    /* Create the stepper task which will control the stepper motors. */
    ( void ) xTaskCreate( prvStepperTask,
                          STEPPER_TASK_NAME,
                          STEPPER_TASK_STACK_SIZE,
                          NULL,
                          democonfigSHADOW_DEMO_TASK_PRIORITY,
                          NULL );

    /* Create the manager task which will control reported state response to actual state. */
    ( void ) xTaskCreate( prvManagerTask,
                          MANAGER_TASK_NAME,
                          MANAGER_TASK_STACK_SIZE,
                          NULL,
                          democonfigSHADOW_DEMO_TASK_PRIORITY,
                          &xManagerTaskHandle );
}

/*-----------------------------------------------------------*/

void vMarkReconnectTimestamp( void )
{
    /* If we are done reconnecting to services, take down a timestamp.
     * This is used to give some buffer time before reporting a belt jam. */
    uTimeOfReconnect = xTaskGetTickCount();
}

/*-----------------------------------------------------------*/

ShadowReturnCode_t xRegisterCallbacks( void )
{
    ShadowReturnCode_t xReturn;
    ShadowCallbackParams_t xCallbackParams;

    /* Register callbacks. This demo doesn't use updated or deleted callbacks, so
     * those members are set to NULL. */
    xCallbackParams.pcThingName = THING_NAME;
    xCallbackParams.xShadowUpdatedCallback = NULL;
    xCallbackParams.xShadowDeletedCallback = NULL;
    xCallbackParams.xShadowDeltaCallback = prvDeltaCallback;

    xReturn = eShadowFailure;
    uint8_t usFailCount = 0;

    /* Loop until we successfully register shadow callbacks */
    while( xReturn != eShadowSuccess )
    {
        /* If we have failed to register callbacks SHADOW_CONNECTION_FAIL_LIMIT times in a row,
         * Wifi is likely disconnected. Break and reconnect Wifi. */
        if( usFailCount >= SHADOW_CONNECTION_FAIL_LIMIT )
        {
            break;
        }

        configPRINTF( ( "Attempting to register shadow callbacks.\r\n" ) );
        xReturn = SHADOW_RegisterCallbacks( xClientHandle, &xCallbackParams, SHADOW_TIMEOUT );
        if( xReturn != eShadowSuccess )
        {
            configPRINTF( ( "SHADOW_RegisterCallbacks unsuccessful, returned %d.\r\n", xReturn ) );
            usFailCount++;
        }
    }

    if( xReturn == eShadowSuccess )
    {
        configPRINTF( ( "Successfully registered shadow callbacks.\r\n" ) );
    }
    else
    {
        configPRINTF( ( "Repeatedly failed to register shadow callbacks. Returning to reconnect to Wifi. \r\n" ) );
    }

    return xReturn;
}

/*-----------------------------------------------------------*/

static ShadowReturnCode_t prvShadowClientDisconnect( void )
{
    ShadowReturnCode_t xReturn;

    xReturn = eShadowFailure;

    /* Loop until we successfully disconnect the shadow client */
    while( xReturn != eShadowSuccess )
    {
        configPRINTF( ( "Attempting to disconnect Shadow Client.\r\n" ) );
        xReturn = SHADOW_ClientDisconnect( xClientHandle );
        if( xReturn != eShadowSuccess )
        {
            configPRINTF( ( "SHADOW_ClientDisconnect unsuccessful, returned %d.\r\n", xReturn ) );
        }
    }

    configPRINTF( ( "Successfully disconnected Shadow client.\r\n" ) );

    return xReturn;
}

/*-----------------------------------------------------------*/

ShadowReturnCode_t xShadowClientConnect( void )
{
    /* First disconnect from the shadow client. If not connected, this is a no-op. */
    prvShadowClientDisconnect();

    ShadowReturnCode_t xReturn;
    MQTTAgentConnectParams_t xConnectParams =
    {
        clientcredentialMQTT_BROKER_ENDPOINT,                   /* The URL of the MQTT broker to connect to. */
        democonfigMQTT_AGENT_CONNECT_FLAGS,                     /* Connection flags. */
        pdFALSE,                                                /* Deprecated. */
        clientcredentialMQTT_BROKER_PORT,                       /* Port number on which the MQTT broker is listening. */
        ( const uint8_t * ) ( clientcredentialIOT_THING_NAME ), /* Client Identifier of the MQTT client. It should be unique per broker. */
        ( uint16_t ) strlen( clientcredentialIOT_THING_NAME ),  /* The length of the client Id, filled in later as not const. */
        pdFALSE,                                                /* Deprecated. */
        &xClientHandle,                                         /* User data supplied to the callback. Can be NULL. */
        NULL,                                                   /* Callback used to report various events. Can be NULL. */
        NULL,                                                   /* Certificate used for secure connection. Can be NULL. */
        0                                                       /* Size of certificate used for secure connection. */
    };

    xReturn = eShadowFailure;
    uint8_t usFailCount = 0;

    /* Loop until we successfully connect to the shadow client */
    while( xReturn != eShadowSuccess )
    {
        /* If we have failed to connect SHADOW_CONNECTION_FAIL_LIMIT times in a row,
         * Wifi is likely disconnected. Break and reconnect Wifi. */
        if( usFailCount >= SHADOW_CONNECTION_FAIL_LIMIT )
        {
            break;
        }

        /* Attempt to connect. */
        configPRINTF( ( "Attempting to connect to Shadow Client.\r\n" ) );
        xReturn = SHADOW_ClientConnect( xClientHandle, &xConnectParams, SHADOW_TIMEOUT );
        if( xReturn != eShadowSuccess )
        {
            configPRINTF( ( "Shadow_ClientConnect unsuccessful, returned %d.\r\n", xReturn ) );
            usFailCount++;
        }
    }

    if( xReturn == eShadowSuccess )
    {
        configPRINTF( ( "Successfully connected to Shadow Client.\r\n" ) );
    }
    else
    {
        configPRINTF( ( "Repeatedly failed to connect to Shadow Client. Returning to reconnect to Wifi. \r\n" ) );
    }

    return xReturn;
}

/*-----------------------------------------------------------*/

ShadowReturnCode_t xShadowClientCreate( void )
{
    ShadowReturnCode_t xReturn;
    ShadowCreateParams_t xCreateParams;

    /* Create shadow client. */
    xCreateParams.xMQTTClientType = eDedicatedMQTTClient;

    xReturn = eShadowFailure;

    /* Loop until we successfully create the shadow client */
    while( xReturn != eShadowSuccess )
    {
        configPRINTF( ( "Attempting to create Shadow Client.\r\n" ) );
        xReturn = SHADOW_ClientCreate( &xClientHandle, &xCreateParams );
        if( xReturn != eShadowSuccess )
        {
            configPRINTF( ( "Shadow_ClientCreate unsuccessful, returned %d.\r\n", xReturn ) );
        }
    }

    configPRINTF( ( "Successfully created Shadow Client.\r\n" ) );

    return xReturn;
}

/*-----------------------------------------------------------*/

void vCreateQueues( void )
{
    /* Initialize the update queue, stepper queue, and manager queue. */
    xUpdateQueue = xQueueCreateStatic( QUEUE_LENGTH,
                                       sizeof( QueueData_t ),
                                       ucQueueStorageArea,
                                       &xUpdateStaticQueue );

    xStepperQueue = xQueueCreateStatic( QUEUE_LENGTH,
                                        sizeof( QueueData_t ),
                                        ucQueueStorageArea,
                                        &xStepperStaticQueue );

    xManagerQueue = xQueueCreateStatic( QUEUE_LENGTH,
                                        sizeof( QueueData_t ),
                                        ucQueueStorageArea,
                                        &xManagerStaticQueue );
}

/*-----------------------------------------------------------*/

void vConfigureTimer( void )
{
    /* Select and initialize basic parameters of the timer */
    timer_config_t config;
    config.divider = TIMER_DIVIDER;
    config.counter_dir = TIMER_COUNT_UP;
    config.counter_en = TIMER_PAUSE;
    config.alarm_en = TIMER_ALARM_EN;
    config.intr_type = TIMER_INTR_LEVEL;
    config.auto_reload = TIMER_AUTORELOAD_EN;
    timer_init( TIMER_GROUP, TIMER_IDX, &config );

    /* Pause timer. */
    timer_pause( TIMER_GROUP, TIMER_IDX );

    /* Tell timer's counter to start from 0. */
    timer_set_counter_value( TIMER_GROUP, TIMER_IDX, 0x00000000ULL );

    /* Configure the alarm value to slow. */
    timer_set_alarm_value( TIMER_GROUP, TIMER_IDX, ALARM_VALUE_SLOW );

    /* Configure the interrupt that is triggered on alarm. */
    timer_enable_intr( TIMER_GROUP, TIMER_IDX );
    timer_isr_register( TIMER_GROUP, TIMER_IDX, prvTimerInterruptHandler, (void *) TIMER_IDX, ESP_INTR_FLAG_IRAM, NULL );
}
