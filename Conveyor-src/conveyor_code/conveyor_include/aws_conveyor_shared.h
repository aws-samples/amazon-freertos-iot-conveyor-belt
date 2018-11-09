/*
 * Amazon FreeRTOS V1.2.7
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
