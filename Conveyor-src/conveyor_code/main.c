// Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0
// Based on a demo from FreeRTOS
// SPDX-License-Identifier: MIT

/* FreeRTOS includes. */
#include "FreeRTOS.h"
#include "task.h"

/* FreeRTOS GPIO and analog includes. */
#include "driver/gpio.h"
#include "driver/adc.h"

/* AWS System includes. */
#include "aws_system_init.h"
#include "aws_logging_task.h"
#include "aws_wifi.h"
#include "aws_clientcredential.h"
#include "aws_shadow.h"
#include "aws_mqtt_agent.h"
#include "nvs_flash.h"
#include "FreeRTOS_IP.h"
#include "FreeRTOS_Sockets.h"

/* Demo configurations. */
#include "aws_demo_config.h"

/* Conveyor demo includes. */
#include "conveyor_include/aws_conveyor_shared.h"
#include "conveyor_include/aws_conveyor_telemetry.h"
#include "conveyor_include/aws_conveyor_shadow.h"

/* Include LED driver. */
#include "conveyor_include/ws2812.h"

#include "esp_system.h"
#include "esp_wifi.h"
#include "esp_interface.h"

/* Logging Task Defines. */
#define mainLOGGING_MESSAGE_QUEUE_LENGTH    ( 32 )
#define mainLOGGING_TASK_STACK_SIZE         ( configMINIMAL_STACK_SIZE * 6 )
#define mainDEVICE_NICK_NAME                "Espressif_Demo"

/* Stack size for main task. */
#define MAIN_TASK_STACK_SIZE                ( ( uint16_t ) configMINIMAL_STACK_SIZE * ( uint16_t ) 5 )

/* Stack size for watchdog task. */
#define WATCHDOG_TASK_STACK_SIZE            ( ( uint16_t ) configMINIMAL_STACK_SIZE * ( uint16_t ) 5 )

/* Input GPIO pin for hall effect sensor */
#define RPM_PIN                             33
#define GPIO_BIT_MASK                       ( 1ULL << GPIO_NUM_33 )

/* Delay for watchdog task. */
#define WATCHDOG_TASK_DELAY                 250      /* Will equate to 250ms */

/* Delay between Wifi connect attempts. */
#define WIFI_CONNECT_DELAY                  3000     /* Will equate to 3 seconds */

/* Number of times wifi can fail to connect before we restart ESP32. */
#define WIFI_FAIL_LIMIT                     20

/* GPIO pin for the conveyor belt's sensor plugin. */
#define SENSOR_PIN                          21

/* Declare xPixels array. See aws_conveyor_shared.h for more information. */
rgbVal *xPixels;

/* Declare xDisconnectFlag and initialize it to pdTRUE as we are not connected to services.
 * See aws_conveyor_shared.h for more information. */
BaseType_t xDisconnectFlag = pdTRUE;

/* Static arrays for FreeRTOS+TCP stack initialization for Ethernet network connections
 * are use are below. If you are using an Ethernet connection on your MCU device it is
 * recommended to use the FreeRTOS+TCP stack. The default values are defined in
 * FreeRTOSConfig.h. */

/* Default MAC address configuration.  The demo creates a virtual network
 * connection that uses this MAC address by accessing the raw Ethernet data
 * to and from a real network connection on the host PC.  See the
 * configNETWORK_INTERFACE_TO_USE definition for information on how to configure
 * the real network connection to use. */
uint8_t ucMACAddress[ 6 ] =
{
    configMAC_ADDR0,
    configMAC_ADDR1,
    configMAC_ADDR2,
    configMAC_ADDR3,
    configMAC_ADDR4,
    configMAC_ADDR5
};

/* The default IP and MAC address used by the demo.  The address configuration
 * defined here will be used if ipconfigUSE_DHCP is 0, or if ipconfigUSE_DHCP is
 * 1 but a DHCP server could not be contacted.  See the online documentation for
 * more information.  In both cases the node can be discovered using
 * "ping RTOSDemo". */
static const uint8_t ucIPAddress[ 4 ] =
{
    configIP_ADDR0,
    configIP_ADDR1,
    configIP_ADDR2,
    configIP_ADDR3
};
static const uint8_t ucNetMask[ 4 ] =
{
    configNET_MASK0,
    configNET_MASK1,
    configNET_MASK2,
    configNET_MASK3
};
static const uint8_t ucGatewayAddress[ 4 ] =
{
    configGATEWAY_ADDR0,
    configGATEWAY_ADDR1,
    configGATEWAY_ADDR2,
    configGATEWAY_ADDR3
};
static const uint8_t ucDNSServerAddress[ 4 ] =
{
    configDNS_SERVER_ADDR0,
    configDNS_SERVER_ADDR1,
    configDNS_SERVER_ADDR2,
    configDNS_SERVER_ADDR3
};

/**
 * @brief Application task startup hook.
 */
void vApplicationDaemonTaskStartupHook( void );

/**
 * @brief Configures GPIO pins, rpm interrupt, and accelerometer
 */
static void prvConfigurePeripherals( void );

/**
 * @brief Initializes the WiFi module.
 */
static BaseType_t prvWifiInit( void );

/**
 * @brief Connects to WiFi.
 */
static BaseType_t prvWifiConnect( void );

/**
 * @brief Sets up queues, connects to shadow client, registers callbacks, and creates remaining tasks.
 */
static void prvConveyorInitTask( void * pvParameters );

/**
 * @brief Monitors flags that are raised on WiFi, Shadow, or MQTT disconnect. Reconnects everything on flag raise.
 */
static void prvWatchdogTask( void * pvParameters );

/**
 * @brief Initializes the board.
 */
static void prvMiscInitialization( void );
/*-----------------------------------------------------------*/

/**
 * @brief Application runtime entry point.
 */
int app_main( void )
{
    /* Perform any hardware initialization that does not require the RTOS to be
     * running.  */
    prvMiscInitialization();
    /* Create tasks that are not dependent on the WiFi being initialized. */
    xLoggingTaskInitialize( mainLOGGING_TASK_STACK_SIZE,
							              tskIDLE_PRIORITY + 5,
							              mainLOGGING_MESSAGE_QUEUE_LENGTH );
    FreeRTOS_IPInit( ucIPAddress,
                     ucNetMask,
                     ucGatewayAddress,
                     ucDNSServerAddress,
                     ucMACAddress );

    /* Start the scheduler.  Initialization that requires the OS to be running,
     * including the WiFi initialization, is performed in the RTOS daemon task
     * startup hook. */
    // Following is taken care by initialization code in ESP IDF
    // vTaskStartScheduler();

    return 0;
}

/*-----------------------------------------------------------*/

static void prvMiscInitialization( void )
{
    // Initialize NVS
    esp_err_t ret = nvs_flash_init();
    if( ret == ESP_ERR_NVS_NO_FREE_PAGES )
    {
        ESP_ERROR_CHECK(nvs_flash_erase());
        ret = nvs_flash_init();
    }
    ESP_ERROR_CHECK( ret );
}
/*-----------------------------------------------------------*/

void vApplicationDaemonTaskStartupHook( void )
{
    if( SYSTEM_Init() == pdPASS )
    {
        /* Call prvConfigurePeripherals() to set up GPIO pins, rpm interrupt, accelerometer, and LED. */
        prvConfigurePeripherals();

        /* Create the conveyor demo main task */
        ( void ) xTaskCreate( prvConveyorInitTask,
                              "MainDemoTask",
                              MAIN_TASK_STACK_SIZE,
                              NULL,
                              tskIDLE_PRIORITY,
                              NULL );
    }
}
/*-----------------------------------------------------------*/

static void prvConfigurePeripherals( void )
{
    /* Configure GPIO pins for stepper motor */
    gpio_pad_select_gpio( STEP_PIN );
    gpio_pad_select_gpio( DIR_PIN );
    gpio_pad_select_gpio( ENA_PIN );
    gpio_set_direction( STEP_PIN, GPIO_MODE_OUTPUT );
    gpio_set_direction( DIR_PIN, GPIO_MODE_OUTPUT );
    gpio_set_direction( ENA_PIN, GPIO_MODE_OUTPUT );

    /* Configure interrupt for hall effect sensor */
    gpio_config_t io_conf;
    io_conf.intr_type = GPIO_INTR_NEGEDGE;
    io_conf.mode = GPIO_MODE_INPUT;
    io_conf.pin_bit_mask = GPIO_BIT_MASK;
    io_conf.pull_down_en = GPIO_PULLDOWN_DISABLE;
    io_conf.pull_up_en = GPIO_PULLUP_ENABLE;
    gpio_config( &io_conf );
    gpio_install_isr_service( 0 );
    gpio_isr_handler_add( RPM_PIN, vRpmInterruptHandler, ( void * ) RPM_PIN );

    /* Configuration for accelerometer */
    adc1_config_width( ADC_WIDTH_BIT_12 );
    adc1_config_channel_atten( ADC1_CHANNEL_4, ADC_ATTEN_DB_11 ); //X -> GPIO32
    adc1_config_channel_atten( ADC1_CHANNEL_7, ADC_ATTEN_DB_11 ); //Y -> GPIO35
    adc1_config_channel_atten( ADC1_CHANNEL_6, ADC_ATTEN_DB_11 ); //Z -> GPIO34

    /* Configure hardware timer, alarm, and interrupt for stepper motor control. */
    vConfigureTimer();

    /* Initialize LED. */
    ws2812_init( SENSOR_PIN );
}

/*-----------------------------------------------------------*/

static void prvConveyorInitTask( void * pvParameters )
{
    ( void ) pvParameters;

    /* Create the queues that are used for inter-task communication */
    vCreateQueues();

    /* Initialize/create WiFi, shadow client, and MQTT client. */
    prvWifiInit();
    xShadowClientCreate();
    xMQTTClientCreate();

    /* Create the tasks associated with the device shadow. */
    vCreateShadowTasks();

    /* Create the telemetry task. */
    vCreateTelemetryTask();

    /* Create the watchdog task, which is in charge of detecting disconnects from Wifi/Shadow/MQTT
    * and reconnecting to them. Additionally, because we have not yet connected any of these services, the
    * watchdog task will notice we are not connected and handle the initial connection process. */
    ( void ) xTaskCreate( prvWatchdogTask,
                          "WatchdogTask",
                          WATCHDOG_TASK_STACK_SIZE,
                          NULL,
                          tskIDLE_PRIORITY,
                          NULL );

    vTaskDelete( NULL );
}

/*-----------------------------------------------------------*/

static void prvWatchdogTask( void * pvParameters )
{
    ( void ) pvParameters;

    /* Allocate memory for xPixels array. */
    xPixels = pvPortMalloc( sizeof( rgbVal ) * PIXEL_COUNT );

    /* Initialize LED colors. */
    rgbVal xLED_blue = makeRGBVal(0, 0, 255);
    rgbVal xLED_green = makeRGBVal(0, 50, 0);
    rgbVal xLED_pink = makeRGBVal(255, 0, 150);
    rgbVal xLED_red = makeRGBVal(255, 0, 0);

    for( ; ; )
    {
        /* Run task every WATCHDOG_TASK_DELAY ms */
        vTaskDelay( WATCHDOG_TASK_DELAY / portTICK_PERIOD_MS );

        /* When Wifi goes down or the disconnect flag is raised, reconnect WiFi, Shadow, and MQTT.
         * See aws_conveyor_shadow.c and aws_conveyor_telemetry.c for where the flag gets raised. */
        if( !WIFI_IsConnected() || xDisconnectFlag == pdTRUE )
        {
            configPRINTF( ( "Received notice in Watchdog Task that we are not connected to a service.\r\n" ) );

            BaseType_t xReturn = 1;

            /* Raise disconnect flag (if it isn't already) so that shadow and MQTT operations know that we are reconnecting.
             * When the disconnect flag is raised, the task to check shadow connection will suspend itself,
             * belt jam detection will suspend itself, the hardware timer interrupt will not step the motor,
             * and the telemetry task will also not attempt to publish to MQTT topics. */
            xDisconnectFlag = pdTRUE;

            /* If Wifi disconnects after it is initially connected but before we finish connecting
             * to the shadow client, connecting to the MQTT client, and registering callbacks, then
             * one of these connection functions will fail, xReturn will be non-zero, and we will kick in a subsequent
             * iteration of this loop. xShadowClientConnect(), xRegisterCallbacks(), and xMQTTClientConnect() only
             * fail if they cannot connect within 5 attempts, thus, if they fail, it is almost certainly
             * because Wifi has been disconnected. In this subsequent iteration of the loop, we will
             * reconnect to Wifi, and then attempt our other three connection functions again. When everything
             * is connected, we break out of this loop.
             *
             * xReturn is 0 if these functions succeed, non-zero otherwise. */
            while( xReturn != 0 )
            {
                /* Set LED to blue to show we are connecting to Wifi. */
                xPixels[0] = xLED_blue;
                ws2812_setColors(PIXEL_COUNT, xPixels);

                /* Connect to WiFi */
                prvWifiConnect();

                /* Set LED to pink to show we are connecting to IoT services. */
                xPixels[0] = xLED_pink;
                ws2812_setColors(PIXEL_COUNT, xPixels);

                /* Connect to the shadow client. */
                xReturn = xShadowClientConnect();

                if( xReturn == 0 )
                {
                    /* Register shadow callbacks. */
                    xReturn = xRegisterCallbacks();
                }

                if( xReturn == 0 )
                {
                    /* Connect to the MQTT client. */
                    xReturn = xMQTTClientConnect();
                }
            }

            /* Sync up with existing shadow document in case a new desired state was added while connection was down. */
            vSyncWithShadow();

            /* Take down a timestamp that marks when we reconnected to services. Used for belt jam detection. */
            vMarkReconnectTimestamp();

            /* Set our disconnect flag to pdFALSE now that we are connected. */
            xDisconnectFlag = pdFALSE;

            /* Set LED color to green or red accordingly. */
            if( xConveyorErrorFlag == pdTRUE )
            {
                /* Set LED to red to show we are in error state. */
                xPixels[0] = xLED_red;
                ws2812_setColors(PIXEL_COUNT, xPixels);
            }
            else
            {
                /* Set LED to green to show we are up and running. */
                xPixels[0] = xLED_green;
                ws2812_setColors(PIXEL_COUNT, xPixels);
            }

            /* Set our disconnect flag to pdFALSE now that we are connected. */
            xDisconnectFlag = pdFALSE;

            configPRINTF( ( "Watchdog Task has connected Wifi, Shadow, and MQTT.\r\n" ) );
        }
    }
}

/*-----------------------------------------------------------*/

static BaseType_t prvWifiInit( void )
{
    WIFIReturnCode_t xReturn = eWiFiFailure;

    /* Loop until we successfully initialize WiFi module */
    while( xReturn != eWiFiSuccess )
    {
        configPRINTF( ( "Attempting to initialize WiFi module.\r\n" ) );
        xReturn = WIFI_On();
        if( xReturn != eWiFiSuccess )
        {
            configPRINTF( ( "WiFi module failed to initialize, returned %d.\r\n", xReturn ) );
        }
    }

    configPRINTF( ( "WiFi module initialized. Connecting to AP %s...\r\n", clientcredentialWIFI_SSID ) );

    return xReturn;
}

/*-----------------------------------------------------------*/

static BaseType_t prvWifiConnect( void )
{
    WIFIReturnCode_t xReturn;
    WIFINetworkParams_t xNetworkParams;

    /* Setup parameters. */
    xNetworkParams.pcSSID = clientcredentialWIFI_SSID;
    xNetworkParams.ucSSIDLength = sizeof( clientcredentialWIFI_SSID );
    xNetworkParams.pcPassword = clientcredentialWIFI_PASSWORD;
    xNetworkParams.ucPasswordLength = sizeof( clientcredentialWIFI_PASSWORD );
    xNetworkParams.xSecurity = clientcredentialWIFI_SECURITY;

    xReturn = eWiFiFailure;

    /* Counts number of times wifi has failed to connect. */
    uint8_t usWifiFailCount = 0;

    /* Loop until we successfully connect WiFi to AP */
    while( xReturn != eWiFiSuccess )
    {
        configPRINTF( ( "Attempting to connect WiFi to AP.\r\n" ) );
        xReturn = WIFI_ConnectAP( &( xNetworkParams ) );
        if( xReturn != eWiFiSuccess )
        {
            configPRINTF( ( "WiFi failed to connect to AP, returned %d.\r\n", xReturn ) );

            /* If wifi has failed to connect WIFI_FAIL_LIMIT number of times, restart ESP32.
             * We do this because after a certain number of consecutive attempts to connect
             * to wifi without restarting (around 100), the wifi module can freeze up when
             * it finally does connect. */
            usWifiFailCount++;
            if ( usWifiFailCount >= WIFI_FAIL_LIMIT )
            {
                esp_restart();
            }

            /* Delay for WIFI_CONNECT_DELAY between attempts to connect. */
            vTaskDelay( WIFI_CONNECT_DELAY / portTICK_PERIOD_MS );
        }
    }

    configPRINTF( ( "WiFi Connected to AP. \r\n" ) );

    return xReturn;
}

/*-----------------------------------------------------------*/
/* configUSE_STATIC_ALLOCATION is set to 1, so the application must provide an
 * implementation of vApplicationGetIdleTaskMemory() to provide the memory that is
 * used by the Idle task. */
void vApplicationGetIdleTaskMemory( StaticTask_t ** ppxIdleTaskTCBBuffer,
                                    StackType_t ** ppxIdleTaskStackBuffer,
                                    uint32_t * pulIdleTaskStackSize )
{
/* If the buffers to be provided to the Idle task are declared inside this
 * function then they must be declared static - otherwise they will be allocated on
 * the stack and so not exists after this function exits. */
    static StaticTask_t xIdleTaskTCB;
    static StackType_t uxIdleTaskStack[ configIDLE_TASK_STACK_SIZE ];

    /* Pass out a pointer to the StaticTask_t structure in which the Idle
     * task's state will be stored. */
    *ppxIdleTaskTCBBuffer = &xIdleTaskTCB;

    /* Pass out the array that will be used as the Idle task's stack. */
    *ppxIdleTaskStackBuffer = uxIdleTaskStack;

    /* Pass out the size of the array pointed to by *ppxIdleTaskStackBuffer.
     * Note that, as the array is necessarily of type StackType_t,
     * configMINIMAL_STACK_SIZE is specified in words, not bytes. */
    *pulIdleTaskStackSize = configIDLE_TASK_STACK_SIZE;
}
/*-----------------------------------------------------------*/

/* configUSE_STATIC_ALLOCATION is set to 1, so the application must provide an
 * implementation of vApplicationGetTimerTaskMemory() to provide the memory that is
 * used by the RTOS daemon/time task. */
void vApplicationGetTimerTaskMemory( StaticTask_t ** ppxTimerTaskTCBBuffer,
                                     StackType_t ** ppxTimerTaskStackBuffer,
                                     uint32_t * pulTimerTaskStackSize )
{
/* If the buffers to be provided to the Timer task are declared inside this
 * function then they must be declared static - otherwise they will be allocated on
 * the stack and so not exists after this function exits. */
    static StaticTask_t xTimerTaskTCB;
    static StackType_t uxTimerTaskStack[ configTIMER_TASK_STACK_DEPTH ];

    /* Pass out a pointer to the StaticTask_t structure in which the Idle
     * task's state will be stored. */
    *ppxTimerTaskTCBBuffer = &xTimerTaskTCB;

    /* Pass out the array that will be used as the Timer task's stack. */
    *ppxTimerTaskStackBuffer = uxTimerTaskStack;

    /* Pass out the size of the array pointed to by *ppxTimerTaskStackBuffer.
     * Note that, as the array is necessarily of type StackType_t,
     * configMINIMAL_STACK_SIZE is specified in words, not bytes. */
    *pulTimerTaskStackSize = configTIMER_TASK_STACK_DEPTH;
}
/*-----------------------------------------------------------*/

#if( ipconfigUSE_LLMNR != 0 ) || ( ipconfigUSE_NBNS != 0 ) || ( ipconfigDHCP_REGISTER_HOSTNAME == 1 )

const char * pcApplicationHostnameHook( void )
{
    /* This function will be called during the DHCP: the machine will be registered
     * with an IP address plus this name. */
    return clientcredentialIOT_THING_NAME;
}

#endif
/*-----------------------------------------------------------*/

#if( ipconfigUSE_LLMNR != 0 ) || ( ipconfigUSE_NBNS != 0 )

BaseType_t xApplicationDNSQueryHook( const char * pcName )
{
    BaseType_t xReturn;

    /* Determine if a name lookup is for this node.  Two names are given
     * to this node: that returned by pcApplicationHostnameHook() and that set
     * by mainDEVICE_NICK_NAME. */
    if( strcmp( pcName, pcApplicationHostnameHook() ) == 0 )
    {
        xReturn = pdPASS;
    }
    else if( strcmp( pcName, mainDEVICE_NICK_NAME ) == 0 )
    {
        xReturn = pdPASS;
    }
    else
    {
        xReturn = pdFAIL;
    }

    return xReturn;
}

#endif /* if ( ipconfigUSE_LLMNR != 0 ) || ( ipconfigUSE_NBNS != 0 ) */
/*-----------------------------------------------------------*/

/**
 * @brief Warn user if pvPortMalloc fails.
 *
 * Called if a call to pvPortMalloc() fails because there is insufficient
 * free memory available in the FreeRTOS heap.  pvPortMalloc() is called
 * internally by FreeRTOS API functions that create tasks, queues, software
 * timers, and semaphores.  The size of the FreeRTOS heap is set by the
 * configTOTAL_HEAP_SIZE configuration constant in FreeRTOSConfig.h.
 *
 */
void vApplicationMallocFailedHook()
{
    configPRINTF( ( "ERROR: Malloc failed to allocate memory\r\n" ) );
}
/*-----------------------------------------------------------*/

/**
 * @brief Loop forever if stack overflow is detected.
 *
 * If configCHECK_FOR_STACK_OVERFLOW is set to 1,
 * this hook provides a location for applications to
 * define a response to a stack overflow.
 *
 * Use this hook to help identify that a stack overflow
 * has occurred.
 *
 */
void vApplicationStackOverflowHook( TaskHandle_t xTask,
                                    char * pcTaskName )
{
    configPRINTF( ( "ERROR: stack overflow with task %s\r\n", pcTaskName ) );
    portDISABLE_INTERRUPTS();

    /* Loop forever */
    for( ; ; )
    {
    }
}
/*-----------------------------------------------------------*/
void vApplicationIPNetworkEventHook( eIPCallbackEvent_t eNetworkEvent )
{
    uint32_t ulIPAddress, ulNetMask, ulGatewayAddress, ulDNSServerAddress;
    system_event_t evt;

    if( eNetworkEvent == eNetworkUp )
    {
        /* Print out the network configuration, which may have come from a DHCP
         * server. */
        FreeRTOS_GetAddressConfiguration(
                &ulIPAddress,
                &ulNetMask,
                &ulGatewayAddress,
                &ulDNSServerAddress );

        evt.event_id = SYSTEM_EVENT_STA_GOT_IP;
        evt.event_info.got_ip.ip_changed = true;
        evt.event_info.got_ip.ip_info.ip.addr = ulIPAddress;
        evt.event_info.got_ip.ip_info.netmask.addr = ulNetMask;
        evt.event_info.got_ip.ip_info.gw.addr = ulGatewayAddress;
        esp_event_send( &evt );
    }
}
