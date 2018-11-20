// Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

#ifndef AWS_CONVEYOR_SHARED_H
#define AWS_CONVEYOR_SHARED_H

/* Include LED driver. */
#include "ws2812.h"

/* The GPIO pins for the stepper motor. */
#define STEP_PIN                      16
#define DIR_PIN                       15
#define ENA_PIN                       17

/* Number of LEDs we are using. */
#define PIXEL_COUNT                   1

/* Our array of LED pixels. Because we only have one LED, it is an array of length 1. */
extern rgbVal *xPixels;

/* Declare disconnect flag.
 * pdTRUE if Shadow Client and/or MQTT Client is disconnected.
 * pdFALSE if both clients are connected. */
extern BaseType_t xDisconnectFlag;

/* Declare conveyor error flag.
 * pdTRUE if belt jam has been reported.
 * pdFALSE otherwise. */
extern BaseType_t xConveyorErrorFlag;

#endif /* AWS_CONVEYOR_SHARED_H */
