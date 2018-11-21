## General Info

- The Industrial IoT demo is a comprehensive demo that combines AWS technologies
  to show the art of the possible in how AWS can play a central role in industrial
  design & automation, fleet management, predictive maintenance, and technician training.
  The physical demo itself is a 3D printed conveyor belt controlled by an ESP32 microcontroller.

- The ESP32 is connected to AWS IoT via wifi, allowing the conveyor belt to communicate
  with and be controlled by the cloud. The demo utilizes AWS IoT's shadow service as a
  way to control the conveyor and report on its state. This digital state of the conveyor belt is called the device shadow which has two main components: desired state and reported state. Desired state is what
  the user wants the conveyor to do, and reported state is what the conveyor reports it
  is doing. Desired state is set by the user via a Sumerian application, and in response, the conveyor
  belt will adjust it's actual state to mirror this new desired state and then publish a
  new reported state to the device shadow service. With this demo, there are two fields
  that can be manipulated by the shadow: the conveyor's mode which has the possible values
  of forward, stopped, or backward and the conveyor's speed which has the possible values
  of slow and fast. Alongside this communication with this shadow service, the conveyor
  belt also continuously reports rpm and vibration data to AWS MQTT Topics.

- The ESP32 runs Amazon FreeRTOS. By taking advantage of this real time operating system,
  the demo is able to simultaneously perform its necessary tasks of communicating with
  the AWS IoT device shadow, controlling the conveyor's stepper motor, and publishing
  telemetry data. To perform this simultaneous workflow, the demo utilizes FreeRTOS tasks,
  which run independently and perform respective functionality. Inter-task communication
  is implemented with FreeRTOS queues, a simple first-in-first-out structure designed
  to pass messages between tasks.

- The rest of this document describes the logic flow of the demo in greater detail.

## Flow Diagram

  ![](flow-diagram.png)

## Detailed Logic Flow

### Initialization (main.c)

- Initialization of the demo occurs when the conveyor belt is powered on. Low level
  application initialization occurs first, including the logic contained in main.c, i.e.
  starting the FreeRTOS scheduler and configuring memory. Eventually,
  `vApplicationDaemonTaskStartupHook()`, a function within main.c will be called.

- This function first makes a call to `prvConfigurePeripherals()` to set up GPIO pins and peripherals,
  then creates the main initialization task, `prvConveyorInitTask()`.

- `prvConveyorInitTask()` is responsible for starting up the core shadow and telemetry functionality.
  The task first calls `vCreateQueues()` to create the queues that are used for communication
  between the various shadow tasks. It then calls `prvWifiInit()`, `xShadowClientCreate()`, and `xMQTTClientCreate()`
  to initialize our clients. *It will not yet connect to these clients*. This task will next call `vCreateShadowTasks()`
  and `vCreateTelemetryTask()` to create the shadow and telemetry tasks that will carry out the core
  functionality of the demo. Then, `prvConveyorInitTask()` creates the watchdog task, `prvWatchdogTask()`.

- The watchdog task `prvWatchdogTask()` is responsible for reconnecting to Wifi, the shadow client, and the
  MQTT client if any of them become disconnected. The task runs continuously, checking if any of the services
  are not connected. There are two scenarios which will lead to the task detecting that one or more services
  are not connected: the initialization process in which we have not yet connected to our services, and the
  case in which we lose connection to one or more of our services. In both of these cases, the task will detect
  that we are not connected and make sure that the demo is connected to Wifi, the shadow client, and the MQTT
  client. Along with connecting to these services, the task also registers our shadow delta callback which is
  triggered whenever a new delta document is produced. After these connections are secured, the task then
  calls `vSyncWithShadow()` to ensure that we are up do date with the IoT thing's device shadow.

- `vSyncWithShadow()` first sends out a `SHADOW_Get()` call to retrieve the shadow document and
  then calls `prvRespondToDesiredState()` to adequately sync up actual state with the desired
  state of the shadow document (`prvRespondToDesiredState()` is described in greater detail
  below as it is a core function of aws_conveyor_shadow.c).

- Once this initialization is complete, our shadow and telemetry tasks will run simultaneously
  to execute the functionality of the demo.

### Shadow Logic (aws_conveyor_shadow.c)

- This file contains all logic relating to the conveyor's communication with the AWS IoT
  shadow service and the actions taken in response to shadow changes. It contains the
  three shadow tasks mentioned above: `prvManagerTask()`, `prvStepperTask()`, and
  `prvUpdateQueueTask()`. These three tasks run simultaneously in a somewhat dormant
  state once created during initialization and each jump into action when their
  respective queues receive a request.

- **General logic flow**:

  - The trigger that causes the central flow of logic to begin is a change in the device
    shadow's desired state. Because the device shadow contains a desired state and a reported
    state, a change to the desired state will cause the desired and reported states to differ.
    In response to this, the AWS IoT shadow service issues a delta document describing
    this difference. This issuance of a delta document triggers our delta callback.

  - `prvDeltaCallback()` simply passes on the data it receives to `prvRespondToDesiredState()`,
    which starts off by parsing the delta json document for requested speed and mode. It then
    calls `prvValidDesiredState()` to ensure that we have received a valid speed and mode,
    and if they pass the check, speed and mode are packed up into a QueueData_t struct
    and sent along to the manager task via the manager task's queue.

  - `prvManagerTask()` is in charge of controlling the order of flow between changes to
    actual state and issuance of reported state by managing communication between `prvStepperTask()`
    and `prvUpdateQueueTask()`. `prvManagerTask()` runs infinitely, constantly checking if its queue
    has received an element. When it does receive a request (a QueueData_t struct from the
    `prvRespondToDesiredState()` function), it passes the struct over to the stepper task
    via the stepper queue and then freezes until the stepper task responds with a
    notification that it has updated actual state.

  - `prvStepperTask()` is in charge of controlling the stepper motor. To do so, it continuously
    checks to see if a request has come in to update the speed or mode of the conveyor belt. When
    it receives a request from the manager task containing a new mode and/or speed, it will instruct
    the stepper motor to perform accordingly. This interaction with the stepper motor consists of
    toggling GPIO pins and manipulating a hardware timer that pulses the stepper motor via a
    system of alarms and interrupts. Once this is done, the task will then send a response
    back to the manager task, letting it know that actual state has been updated.

  - Once the manager task receives this notification, it calls `prvGenerateReportedJSON()` to
    generate a reported json document. This function simply packs up a string containing the
    actual mode and speed of the conveyor belt and formats it in the correct fashion. The
    manager task then sends this to `prvUpdateQueueTask()` via it's queue.

  - `prvUpdateQueueTask()` is in charge of updating the device shadow's reported state.
    To do this, the task runs infinitely, constantly checking if its queue has received
    a new json document. When it receives one, it performs a `SHADOW.Update()` call to send
    the json document to the AWS IoT shadow service as the reported state.

- **Error reporting**:

  - The conveyor belt also has built-in functionality to detect a belt jam or slippage.
    This error checking occurs within `prvStepperTask()`; it will constantly compare the rpm
    reading to the reported state of the motor to see if something is off. If rpm is 0
    but the motor is set to move forwards or backwards, then there must be a belt jam or
    slippage. To handle this, the task stops the motor and calls `prvReportError()`.

  - `prvReportError()` will then call `prvGenerateReportedJSON()` to generate a reported json
    document with an error flag raised. `prvReportError()` then sends this reported state document
    to `prvUpdateQueueTask()` to report this error state to the AWS IoT shadow service.

  - If an error is reported, the reported state will be locked and will show the most
    recent state it reported along with the error flag raised. Any subsequent changes
    in the desired state will be ignored. A reboot of the conveyor belt will bring
    the demo out of its error state.

### Telemetry Logic (aws_conveyor_telemetry.c)

- This file contains all logic related to the conveyor's reading and reporting of telemetry
  data, which runs isolated from the shadow logic. The file's only task, `prvTelemetryTask()`,
  handles the core functionality.

- `prvTelemetryTask()` runs in an infinite loop, constantly reading and reporting rpm and
  vibration data. To calculate rpm, magnets are placed inside of the conveyor's wheel.
  Each time a magnet passes the conveyor belt's hall effect sensor, an interrupt is
  triggered and the handler `vRpmInterruptHandler()` will increment a count variable.
  Once a third of a rotation of the wheel has occurred, `prvTelemetryTask()` will calculate rpm.
  Vibration data is read in from the conveyor belt's accelerometer every 500ms.
  Every 500ms the task will report this telemetry data by calling `prvReportVals()`.

- `prvReportVals()` takes the telemetry data for rpm and vibration, packages them into
  payload strings, and makes two calls to `prvPublishToTopic()`. `prvPublishToTopic()`
  calls `MQTT_AGENT_Publish()` to publish the payload to the correct MQTT topic.

- Thus, every 500ms the vibration and rpm topics will receive updated telemetry data.

## List of Functions

**MAIN.C**

- `prvConfigurePeripherals` Configures GPIO pins, rpm interrupt, accelerometer, and LED

- `prvWifiInit` Initializes the wifi module

- `prvWifiConnect` Connects the ESP32 to wifi

- `prvConveyorInitTask` Sets up queues, connects to shadow client, registers callbacks,
  and creates remaining tasks.

- `prvWatchdogTask` Monitors flags that are raised on WiFi, Shadow, or MQTT disconnect.
  Reconnects everything on flag raise.

**AWS_CONVEYOR_SHADOW.C**

- `vConfigureTimer` Configures the hardware timer, alarm, and interrupt for stepper motor control.

- `vCreateQueues` Initializes the update queue, stepper queue, and manager queue.

- `xShadowClientCreate` Creates the shadow client.

- `xShadowClientConnect` Connects the shadow client to the MQTT broker.

- `xShadowClientDisconnect` Disconnects the shadow client from the MQTT broker.

- `xRegisterCallbacks` Registers shadow callbacks, specifically the delta callback.

- `vMarkReconnectTimestamp` Takes down a timestamp that is used to give some buffer time before
  reporting a belt jam.

- `vCreateShadowTasks` Creates the three tasks associated with the device shadow:
  Manager Task, Stepper Task, and Update Queue Task.

- `vSyncWithShadow` Syncs up with the existing shadow document. Performs a SHADOW_Get() call
  to retrieve the shadow document. Then calls vRespondToDesiredState to complete the sync.

- `prvTimerInterruptHandler` The interrupt handler for the hardware timer. Pulses the stepper
  motor when triggered.

- `prvManagerTask` Controls order of flow between changes to actual state and reported state.
  First sends request to Stepper Task to update actual state. Upon notification that this has
  been completed, sends request to Update Queue Task to update reported state.

- `prvStepperTask` Steps the stepper motor according to desired speed and mode. Continuously
  checks to see if a request has come in to update the speed or mode of the conveyor belt. When
  it receives a request from the manager task containing a new mode and/or speed, it will instruct
  the stepper motor to perform accordingly. This interaction with the stepper motor consists of
  toggling GPIO pins and manipulating a hardware timer that pulses the stepper motor via a
  system of alarms and interrupts. Once this is done, the task will then send a response
  back to the manager task, letting it know that actual state has been updated. Also checks
  for belt jams by comparing rpm to reported mode.

- `prvUpdateQueueTask` Calls SHADOW.Update() to update device shadow's reported state.

- `prvCheckShadowConnectionTask` Raises xShadowDisconnectFlag if we lose connection to shadow client.

- `prvDeltaCallback` Called when desired state differs from reported state, i.e. when desired
  state is changed. Passes on data to prvRespondToDesiredState function to continue logic flow.

- `prvRespondToDesiredState` Called during initialization of shadow document and by
  prvDeltaCallback to take in and process desired state. Parses the shadow document
  for requested speed and mode. If valid, packages up the speed and mode into a QueueData_t
  struct and sends it along to the manager task so it can control order of flow
  between actual and reported state. **NOTE**: The project sets a buffer limit `MAX_TOKENS` on
  the size of the shadow document; if the shadow document's size exceeds this limit, then it
  cannot be parsed. If you have more than seven fields in your shadow's desired state, you
  might exceed the set buffer limit with certain SHADOW_Get() calls. To fix this, trim down the
  number of fields in the desired state or increase `MAX_TOKENS` in `aws_conveyor_shadow.c`.

- `prvReportError` Called after belt jam to report an error state. Generates reported
  json with "error": 1 and calls the updateQueueTask to update the device shadow.

- `prvValidDesiredState` Returns pdTRUE if speed and mode from new desired state are
  valid; pdFALSE otherwise.

- `prvIsStringEqual` Compares chosen parsed token to pcString to test for equality.

- `prvGenerateReportedJSON` Generates reported state json document and returns document's length.

**AWS_CONVEYOR_TELEMETRY.C**

- `xMQTTClientCreate` Creates MQTT client.

- `xMQTTClientConnect` Connects MQTT client to MQTT broker.

- `xMQTTClientDisconnect` Disconnects MQTT client from MQTT broker.

- `vCreateTelemetryTask` Creates the telemetry task that will continuously read in accelerometer
  and rpm data and call prvReportVals to post data to our MQTT topics.

- `uGetRpm` Simple get function for rpm. Used in aws_conveyor_shadow.c for belt jam detection.

- `vRpmInterruptHandler` Interrupt handler that is triggered when the hall effect sensor
  detects a magnet.

- `prvTelemetryTask` Reads and reports vibration and rpm data. The task will continuously
  read in accelerometer and rpm data and call prvReportVals to post data to our MQTT topics.

- `prvReportVals` Reports rpm and vibration data. Generates json payload strings and calls
  prvPublishToTopic to publish rpm and vibration data to their respective IoT topics.

- `prvPublishToTopic` Publishes passed in payload to passed in IoT topic.
