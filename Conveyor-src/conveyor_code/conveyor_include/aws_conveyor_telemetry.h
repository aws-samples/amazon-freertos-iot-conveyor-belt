/*
 * Amazon FreeRTOS V1.2.6
 * Copyright (C) 2017 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * http://aws.amazon.com/freertos
 * http://www.FreeRTOS.org
 */

/*
 * @file aws__conveyor_telemetry.h
 */

#ifndef _AWS_CONVEYOR_TELEMETRY_H_
#define _AWS_CONVEYOR_TELEMETRY_H_

#include "aws_mqtt_agent.h"

/**
 * @brief Interrupt handler that is triggered when the hall effect sensor detects a magnet.
 *
 * Used externally in main.c for initialization of rpm reading.
 *
 * @param[in] pvParameters Default interrupt parameters - ignored.
 *
 * @return void.
 */
void vRpmInterruptHandler( void * pvParameters );

/**
 * @brief Simple get function for rpm.
 *
 * Used externally in aws_conveyor_shadow.c for belt jam detection.
 *
 * @param[in] None.
 *
 * @return The most recent calculated rpm value.
 */
uint8_t uGetRpm( void );

/**
 * @brief Creates the telemetry task that will continuously read in accelerometer and
 * rpm data and call prvReportVals to post data to our MQTT topics.
 *
 * Used externally in main.c during initialization of tasks.
 *
 * @param[in] None.
 *
 * @return void.
 */
void vCreateTelemetryTask( void );

/**
 * @brief Connects MQTT client to MQTT broker.
 *
 * Used externally in main.c during initialization and during reconnection process.
 *
 * @param[in] None.
 *
 * @return eMQTTAgentSuccess if success, error code otherwise.
 */
MQTTAgentReturnCode_t xMQTTClientConnect( void );

/**
 * @brief Creates MQTT client and connects to MQTT broker.
 *
 * Used externally in main.c during initialization.
 *
 * @param[in] None.
 *
 * @return eMQTTAgentSuccess if success, error code otherwise.
 */
MQTTAgentReturnCode_t xMQTTClientCreate( void );

#endif /* _AWS_CONVEYOR_TELEMETRY_H_ */
