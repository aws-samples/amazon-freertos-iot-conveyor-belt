// Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

/*
 * @file aws__conveyor_shadow.h
 */

#ifndef _AWS_CONVEYOR_SHADOW_H_
#define _AWS_CONVEYOR_SHADOW_H_

#include "aws_shadow.h"

/**
 * @brief Syncs up with the existing shadow document.
 *
 * Performs a SHADOW_Get() call to retrieve the shadow document. Then calls
 * vRespondToDesiredState to correctly respond and sync up. Used externally
 * in main.c at end of initialization.
 *
 * @param[in] None.
 *
 * @return void.
 */
void vSyncWithShadow( void );

/**
 * @brief Creates the three tasks associated with the device shadow:
 * Manager Task, Stepper Task, and Update Queue Task.
 *
 * Used externally in main.c during initialization of tasks.
 *
 * @param[in] None.
 *
 * @return void.
 */
void vCreateShadowTasks( void );

/**
 * @brief Takes down a timestamp that is used to give some buffer time before reporting a belt jam.
 *
 * Used externally in main.c's watchdog task when we reconnect to services.
 *
 * @param[in] None.
 *
 * @return void.
 */
void vMarkReconnectTimestamp( void );

/**
 * @brief Registers shadow callbacks.
 *
 * Used externally in main.c during initialization.
 *
 * @param[in] None.
 *
 * @return eShadowSuccess if success, error code otherwise.
 */
ShadowReturnCode_t xRegisterCallbacks( void );

/**
 * @brief Connects Shadow client to MQTT broker.
 *
 * Used externally in main.c during initialization and during reconnection process.
 *
 * @param[in] None.
 *
 * @return eShadowSuccess if success, error code otherwise.
 */
ShadowReturnCode_t xShadowClientConnect( void );

/**
 * @brief Creates Shadow client
 *
 * Used externally in main.c during initialization.
 *
 * @param[in] None.
 *
 * @return eShadowSuccess if success, error code otherwise.
 */
ShadowReturnCode_t xShadowClientCreate( void );

/**
 * @brief Initializes the update queue, stepper queue, and manager queue.
 *
 * Used externally in main.c during initialization.
 *
 * @param[in] None.
 *
 * @return void.
 */
void vCreateQueues( void );

/**
 * @brief Configures the hardware timer, alarm, and interrupt for stepper motor control.
 *
 * Used externally in main.c during initialization.
 *
 * @param[in] None.
 *
 * @return void.
 */
void vConfigureTimer( void );

#endif /* _AWS_CONVEYOR_SHADOW_H_ */
