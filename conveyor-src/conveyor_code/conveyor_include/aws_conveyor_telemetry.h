// Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

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
