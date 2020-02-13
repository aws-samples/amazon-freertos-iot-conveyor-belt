// Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

/**
 * @file aws_conveyor_telemetry.c
 *
 * Contains the logic concerning reading and publishing telemetry data.
 *
 * Reads and reports rpm and vibration data to their respective AWS IoT MQTT topics.
 */

/* Standard includes. */
#include <stdio.h>
#include <stdlib.h> 
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

/* MQTT include. */
#include "aws_mqtt_agent.h"

/* Demo configurations. */
#include "aws_demo_config.h"

/* Required to get the broker address and port. */
#include "aws_clientcredential.h"

/* Required for accelerometer reading */
#include "driver/adc.h"

/**
 * Dimension of the character array buffers used to hold data (strings in
 * this case) that is published to and received from the MQTT broker (in the cloud).
 */
#define MQQT_MAX_DATA_LENGTH                 50

/* MQTT client ID. It must be unique per MQTT broker. */
#define MQQT_CLIENT_ID                       ( ( const uint8_t * ) clientcredentialIOT_THING_NAME )

#define DATA_PREFIX_TOPIC_NAME               ( ( const uint8_t * ) "dt/conveyors/" ) 

/* The vibration topic that the MQTT client publishes to. */
#define VIBR_TOPIC_NAME                      ( ( const uint8_t * ) "/vibration" ) 

/* The rpm topic that the MQTT client publishes to. */
#define RPM_TOPIC_NAME                       ( ( const uint8_t * ) "/speed" )

/* Task name. */
#define TELEM_TASK_NAME                      "TelemetryTask"

/* Stack size for task that publishes telemetry data. */
#define TELEM_TASK_STACK_SIZE                ( ( uint16_t ) configMINIMAL_STACK_SIZE * ( uint16_t ) 5 )

/* Constants for rpm calculation. */
#define THIRD_OF_ROTATION                    3
#define TICKS_PER_MINUTE                     6000
#define COUNTS_PER_ROTATION                  9

/* Constants for publishing telemetry data. */
#define TIME_SINCE_RPM_CALC                  250        /* Will equate to 2500ms */
#define TIME_SINCE_PUBLISH                   50         /* Will equate to 500ms */

/* MQTT connection constants. */
#define MQTT_PUBLISH_FAIL_LIMIT              12         /* 12 publishes takes 3 seconds */
#define MQTT_CONNECTION_FAIL_LIMIT           5

/* The handle of the MQTT client object. */
static MQTTAgentHandle_t xMQTTHandle = NULL;

/* Initialize usRpm and usRpmCount. */
static uint8_t usRpm = 0;
static uint8_t usRpmCount = 0;

/* Initialize MQTT publish fail count. */
static uint8_t uMQTTPublishFailCount = 0;

/**
 * @brief Publishes passed in payload to passed in IoT topic.
 *
 * @param[in] pucTopic The MQTT topic to publish to.
 * @param[in] pcPayload The message that will be published to topic.
 *
 * @return void.
 */
static void prvPublishToTopic( const uint8_t * pucTopic, const char * const pcPayload );

/**
 * @brief Reports rpm and vibration data.
 *
 * Generates json payload strings and calls prvPublishToTopic to publish rpm and
 * vibration data to their respective IoT topics.
 *
 * @param[in] ulX_val The x value read from the accelerometer.
 * @param[in] ulY_val The y value read from the accelerometer.
 * @param[in] ulZ_val The z value read from the accelerometer.
 * @param[in] rpm Rotations per minute calculated with the hall effect sensor.
 *
 * @return void.
 */
static void prvReportVals( uint32_t ulX_val, uint32_t ulY_val, uint32_t ulZ_val, uint32_t usRpm );

/**
 * @brief Reads and reports vibration and rpm data.
 *
 * The task will continuously read in accelerometer and rpm data and call prvReportVals
 * to post data to our MQTT topics.
 *
 * @param[in] pvParameters Default task parameters - ignored.
 *
 * @return void.
 */
static void prvTelemetryTask( void * pvParameters );

/**
 * @brief Disconnects MQTT client from MQTT broker.
 *
 * @param[in] None.
 *
 * @return eMQTTAgentSuccess if success, error code otherwise.
 */
static MQTTAgentReturnCode_t prvMQTTClientDisconnect( void );

/*-----------------------------------------------------------*/

static void prvPublishToTopic( const uint8_t * pucTopic, const char * const pcPayload )
{
    MQTTAgentPublishParams_t xPublishParameters;
    MQTTAgentReturnCode_t xReturn;

    /* Check this function is not being called before the MQTT client object has
    * been created. */
    configASSERT( xMQTTHandle != NULL );
        
    /* Setup the publish parameters. */
    memset( &( xPublishParameters ), 0x00, sizeof( xPublishParameters ) );
    xPublishParameters.pucTopic = pucTopic;
    xPublishParameters.pvData = pcPayload;
    xPublishParameters.usTopicLength = ( uint16_t ) strlen( ( const char * ) pucTopic );
    xPublishParameters.ulDataLength = ( uint32_t ) strlen( pcPayload );
    xPublishParameters.xQoS = eMQTTQoS1;

    /* Publish the message. */
    xReturn = MQTT_AGENT_Publish( xMQTTHandle,
                                  &( xPublishParameters ),
                                  democonfigMQTT_TIMEOUT );

    if( xReturn == eMQTTAgentSuccess )
    {
        configPRINTF( ( "Successfully published '%s'\r\n", pcPayload ) );
        uMQTTPublishFailCount = 0;
    }
    else
    {
        configPRINTF( ( "ERROR:  Failed to publish '%s'\r\n", pcPayload ) );
        uMQTTPublishFailCount++;
    }

    /* Remove compiler warnings in case configPRINTF() is not defined. */
    ( void ) xReturn;
}

/*-----------------------------------------------------------*/

static void prvReportVals( uint32_t ulX_val, uint32_t ulY_val, uint32_t ulZ_val, uint32_t usRpm )
{
    char rpmBuffer[ MQQT_MAX_DATA_LENGTH ];
    char vibrBuffer[ MQQT_MAX_DATA_LENGTH ];
    char vibrtopicBuffer[ MQQT_MAX_DATA_LENGTH ];
    char rpmtopicBuffer[ MQQT_MAX_DATA_LENGTH ];
    /* Create the message that will be published, which is of the form "{"speed":{"rpm":RPM}}"
    * where RPM is the most recent calculated rotations per minute. */
    ( void ) snprintf( rpmBuffer, MQQT_MAX_DATA_LENGTH, "{\"speed\":{\"rpm\":%u}}", usRpm );
    /* Create unique topic for your thing to send rpms */
    ( void ) snprintf( rpmtopicBuffer, MQQT_MAX_DATA_LENGTH, "%s%s%s",  DATA_PREFIX_TOPIC_NAME, MQQT_CLIENT_ID, RPM_TOPIC_NAME);

    /* Send message as payload over to prvPublishToTopic. */
    prvPublishToTopic( (const uint8_t *)rpmtopicBuffer , rpmBuffer );

    /* Create the message that will be published, which is of the form "{"chassis":{"x":ulX_val,"y":ulY_val,"z":ulZ_val}}"
    * where ulX_val, ulY_val, and ulZ_val are the corresponding accelerometer readings. */
    ( void ) snprintf( vibrBuffer, MQQT_MAX_DATA_LENGTH, "{\"chassis\":{\"x\":%u,\"y\":%u,\"z\":%u}}", ulX_val, ulY_val, ulZ_val );
    /* Create unique topic for your thing to send vibrations */
    ( void ) snprintf( vibrtopicBuffer, MQQT_MAX_DATA_LENGTH, "%s%s%s",  DATA_PREFIX_TOPIC_NAME, MQQT_CLIENT_ID, VIBR_TOPIC_NAME);
    
    /* Send message as payload over to prvPublishToTopic. */
    prvPublishToTopic( (const uint8_t *)vibrtopicBuffer , vibrBuffer );
}

/*-----------------------------------------------------------*/

static void prvTelemetryTask( void * pvParameters )
{
    /* Variables to hold accelerometer data. */
    uint32_t ulX_val;
    uint32_t ulY_val;
    uint32_t ulZ_val;

    /* Initialize uPreviousPublishTimestamp. Used for publishing on set interval. */
    unsigned long uPreviousPublishTimestamp = xTaskGetTickCount();

    /* Initialize uPreviousRpmTimestamp. Used to calculate how much time has passed for rpm calculation. */
    unsigned long uPreviousRpmTimestamp = xTaskGetTickCount();

    /* Reset usRpmCount to 0 so that it aligns correctly with uPreviousRpmTimestamp. */
    usRpmCount = 0;

    for( ; ; )
    {
        /* Wait for a third of a rotation before calculating rpm. */
        if( usRpmCount >= THIRD_OF_ROTATION )
        {
            /* Calculate rpm.
             * (number of rotations) / (minutes elapsed)
             * (number of rotations) * (ms in 1min) / (ms per tick) / (elapsed ms)
             * (usRpmCount / 9)      * (60,000)     / (10)          / (elapsed ms)
             * (usRpmCount / COUNTS_PER_ROTATION) * (TICKS_PER_MINUTE) / (elapsed ms) */
            usRpm = ( usRpmCount * TICKS_PER_MINUTE / COUNTS_PER_ROTATION ) / ( xTaskGetTickCount() - uPreviousRpmTimestamp );

            /* Reset time and count for next calculation. */
            uPreviousRpmTimestamp = xTaskGetTickCount();
            usRpmCount = 0;
        }

        /* If it has been longer than TIME_SINCE_RPM_CALC since we calculated rpm, set rpm to 0. */
        if( xTaskGetTickCount() - uPreviousRpmTimestamp >= TIME_SINCE_RPM_CALC )
        {
            usRpm = 0;
        }

        /* If it has been more than TIME_SINCE_PUBLISH since last publish of telemetry, publish telemetry. */
        if( xTaskGetTickCount() - uPreviousPublishTimestamp >= TIME_SINCE_PUBLISH && xDisconnectFlag == pdFALSE )
        {
            /* Read in accelerometer data. */
            ulX_val = adc1_get_raw( ADC1_CHANNEL_4 );
            ulY_val = adc1_get_raw( ADC1_CHANNEL_7 );
            ulZ_val = adc1_get_raw( ADC1_CHANNEL_6 );

            /* Report telemetry to AWS IoT Topics. */
            prvReportVals( ulX_val, ulY_val, ulZ_val, usRpm );

            /* Update uPreviousPublishTimestamp. */
            uPreviousPublishTimestamp = xTaskGetTickCount();

            /* Raise MQTT disconnect flag if we have failed to publish MQTT_PUBLISH_FAIL_LIMIT times in a row. */
            if( uMQTTPublishFailCount >= MQTT_PUBLISH_FAIL_LIMIT )
            {
                configPRINTF( ( "MQTT Client disconnected. Raising xDisconnectFlag.\r\n" ) );
                xDisconnectFlag = pdTRUE;
                uMQTTPublishFailCount = 0;
            }
        }
    }
}

/*-----------------------------------------------------------*/

void vRpmInterruptHandler( void * pvParameters )
{
    usRpmCount++;
}

/*-----------------------------------------------------------*/

uint8_t uGetRpm( void )
{
    return usRpm;
}

/*-----------------------------------------------------------*/

void vCreateTelemetryTask( void )
{
    /* Create the telemetry task which will continuously read and report vibration and rpm data. */
    ( void ) xTaskCreate( prvTelemetryTask,
                          TELEM_TASK_NAME,
                          TELEM_TASK_STACK_SIZE,
                          NULL,
                          democonfigSHADOW_DEMO_TASK_PRIORITY,
                          NULL );
}

/*-----------------------------------------------------------*/

static MQTTAgentReturnCode_t prvMQTTClientDisconnect( void )
{
    MQTTAgentReturnCode_t xReturn;

    xReturn = eMQTTAgentFailure;

    /* Loop until we successfully disconnect the mqtt agent */
    while( xReturn != eMQTTAgentSuccess )
    {
        configPRINTF( ( "Attempting to disconnect MQTT Agent.\r\n" ) );
        xReturn = MQTT_AGENT_Disconnect( xMQTTHandle, democonfigMQTT_ECHO_TLS_NEGOTIATION_TIMEOUT );
        if( xReturn != eMQTTAgentSuccess )
        {
           configPRINTF( ( "MQTT_AGENT_Disconnect unsuccessful, returned %d.\r\n", xReturn ) );
        }
    }

    configPRINTF( ( "Successfully disconnected MQTT Agent.\r\n" ) );

    return xReturn;
}

/*-----------------------------------------------------------*/

MQTTAgentReturnCode_t xMQTTClientConnect( void )
{
    /* First disconnect from the MQTT client. If already connected, this is a no-op. */
    prvMQTTClientDisconnect();

    char clientID[ MQQT_MAX_DATA_LENGTH ];
    ( void ) snprintf( clientID, MQQT_MAX_DATA_LENGTH, "%s%d", MQQT_CLIENT_ID, rand());

    MQTTAgentReturnCode_t xReturn;
    MQTTAgentConnectParams_t xConnectParams =
    {
        clientcredentialMQTT_BROKER_ENDPOINT,                    /* The URL of the MQTT broker to connect to. */
        democonfigMQTT_AGENT_CONNECT_FLAGS,                      /* Connection flags. */
        pdFALSE,                                                 /* Deprecated. */
        clientcredentialMQTT_BROKER_PORT,                        /* Port number on which the MQTT broker is listening. */
        (const uint8_t *) clientID ,                                          /* Client Identifier of the MQTT client. It should be unique per broker. */
        ( uint16_t ) strlen( ( const char * ) clientID ),  /* The length of the client Id, filled in later as not const. */
        pdFALSE,                                                 /* Deprecated. */
        NULL,                                                    /* User data supplied to the callback. Can be NULL. */
        NULL,                                                    /* Callback used to report various events. Can be NULL. */
        NULL,                                                    /* Certificate used for secure connection. Can be NULL. */
        0                                                        /* Size of certificate used for secure connection. */
    };

    xReturn = eMQTTAgentFailure;
    uint8_t usFailCount = 0;

    /* Loop until we successfully connect to the mqtt agent */
    while( xReturn != eMQTTAgentSuccess )
    {
        /* If we have failed to connect MQTT_CONNECTION_FAIL_LIMIT times in a row,
         * Wifi is likely disconnected. Break and reconnect Wifi. */
        if( usFailCount >= MQTT_CONNECTION_FAIL_LIMIT )
        {
            break;
        }

        configPRINTF( ( "MQTT attempting to connect to %s.\r\n", clientcredentialMQTT_BROKER_ENDPOINT ) );
        xReturn = MQTT_AGENT_Connect( xMQTTHandle, &xConnectParams, democonfigMQTT_ECHO_TLS_NEGOTIATION_TIMEOUT );
        if( xReturn != eMQTTAgentSuccess )
        {
            configPRINTF( ( "MQTT_AGENT_Connect unsuccessful, returned %d.\r\n", xReturn ) );
            usFailCount++;
        }
    }

    if( xReturn == eMQTTAgentSuccess )
    {
        configPRINTF( ( "Successfully connected to MQTT Agent.\r\n" ) );
    }
    else
    {
        configPRINTF( ( "Repeatedly failed to connect to MQTT Agent. Returning to reconnect to Wifi. \r\n" ) );
    }

    return xReturn;
}

/*-----------------------------------------------------------*/

MQTTAgentReturnCode_t xMQTTClientCreate( void )
{
    MQTTAgentReturnCode_t xReturn;

    /* Check this function has not already been executed. */
    configASSERT( xMQTTHandle == NULL );

    xReturn = eMQTTAgentFailure;

    /* Loop until we successfully create the mqtt agent */
    while( xReturn != eMQTTAgentSuccess )
    {
        configPRINTF( ( "Attempting to create MQTT Agent.\r\n" ) );
        xReturn = MQTT_AGENT_Create( &xMQTTHandle );
        if( xReturn != eMQTTAgentSuccess )
        {
            configPRINTF( ( "MQTT_AGENT_Create unsuccessful, returned %d.\r\n", xReturn ) );
        }
    }

    configPRINTF( ( "Successfully created MQTT Agent.\r\n" ) );

    return xReturn;
}
