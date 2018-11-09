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
