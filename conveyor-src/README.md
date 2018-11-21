# Industrial IoT demo

The Industrial IoT demo is a comprehensive demo that combines several AWS technologies
to show the art of the possible in how AWS can play a central role in industrial
design & automation, fleet management, predictive maintenance, and technician training.
It features a 3D printed conveyor belt that is connected to AWS IoT.

This repository contains the software that is flashed onto the conveyor belt's
ESP32 microcontroller. By taking advantage of Amazon FreeRTOS, the demo is able
to simultaneously communicate with the AWS IoT device shadow, control the
conveyor's stepper motor, and publish telemetry data.

## Getting Started

*This getting started guide has been adapted from [Amazon FreeRTOS's webpage](https://docs.aws.amazon.com/freertos/latest/userguide/getting_started_espressif.html).*

### Setting Up Your Environment

1. Establishing a Serial Connection

  - To establish a serial connection with the ESP32-DevKitC, you must install CP210x
    USB to UART Bridge VCP drivers. If you are running Windows 10, install v6.7.5 of
    the CP210x USB to UART Bridge drivers. If you are running an older verion of Windows,
    install the version indicated in the list of downloads.

  - For more information see, [Establishing a Serial Connection with ESP32](https://docs.espressif.com/projects/esp-idf/en/latest/get-started/establish-serial-connection.html).

  - Note the serial port you configure (based on host OS), you will need it during the build process.

2. Setting Up the Toolchain

  - When following the links below, do not install the ESP-IDF library from Espressif,
    this project already contains this library. In addition, make sure the IDF_PATH
    environment variable has not been set.

    - [Setting up the toolchain for Windows](https://docs.espressif.com/projects/esp-idf/en/latest/get-started/windows-setup.html)

    - [Setting up the toolchain for Mac OS](https://docs.espressif.com/projects/esp-idf/en/latest/get-started/macos-setup.html)

    - [Setting up the toolchain for Linux](https://docs.espressif.com/projects/esp-idf/en/latest/get-started/linux-setup.html)

3. Installing boto3 and Configuring AWS CLI

  - If you are running MacOS or Linux, open a terminal prompt. If you are running Windows, open mingw32.exe.

  - Install python on your system. Minimum version should be 2.7.10.

  - If you are running on Windows, install the AWS CLI inside the mingw32 environment using the
    following command: `easy_install awscli`. If you are running on MacOS or Linux, make sure the
    AWS CLI is installed on your system. For more information about installing the AWS CLI, see
    [Installing the AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/installing.html).

  - Configure the AWS CLI by running `aws configure`. For information about configuring the AWS CLI, see
    [Configuring the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html).

  - Install the boto3 Python module using the following command:

    - On Windows in the mingw32 environment: `easy_install boto3`

    - On MacOS or Linux: `pip install boto3`

### Downloading and Building the Demo

1. Downloading the Demo

  - Clone this repository to a directory on your local computer.

  - From the project's home directory, run `git submodule update --init --recursive` to pull in the Amazon FreeRTOS submodule.

2. Building the Project Directory and AWS Resources

  - Run `./config/configure.sh all` from the project's home directory. This script will first prompt you to fill
    in your AWS IoT thing name, your WiFi SSID, your WiFi password, and your WiFi security type. It will
    then set up the project directory, generate your credential files, and create your AWS IoT Thing.

  - For more information on the project's structure, see the "Repository Structure" section below.
    For more information on the `./config/configure.sh all` command and the scripts and makefiles this
    project uses, see the "Scripts and Makefiles" section below.

3. Building and Flashing the Demo

  - Connect the ESP32 board to your computer.

  - Navigate to `Amazon_FreeRTOS_Conveyor/demos/espressif/esp32_devkitc_esp_wrover_kit/make`
    and run `make menuconfig`. An Espressif IoT Development Framework Configuration menu will
    be displayed. In the menu, navigate to **Serial flasher config** and then **Default serial port**
    to configure the serial port with the port that you used earlier in the "Establishing a
    Serial Connection" section. Confirm your selection by pressing [ENTER], save the configuration
    by choosing < Save > and then exit application by choosing < Exit >.

  - To build the demo and flash it onto the ESP32, run `make flash monitor`. After the
    flashing process completes, the demo will start running!

4. Troubleshooting

  - If you see errors when running `idf_monitor.py`, please use Python 2.7 or simply run `make flash`.

  - If `pyserial` cannot be installed using `pip` on MacOS, download it from
    [pyserial](https://pypi.org/simple/pyserial/).

  - If the board resets continuously, try erasing the flash by running `make erase_flash`

  - The ESP-IDF provided monitor utility (invoked using make monitor) helps in decoding addresses, thus helps in
    getting some meaningful backtraces in case the application crashes. For more information, see [Automatically decoding addresses](https://docs.espressif.com/projects/esp-idf/en/latest/get-started/idf-monitor.html#automatically-decoding-addresses).

  - It is also possible to enable GDBstub for communication with gdb without requiring
    any special JTAG hardware, for more information, see [Launch GDB for GDBStub](https://docs.espressif.com/projects/esp-idf/en/latest/get-started/idf-monitor.html#launch-gdb-for-gdbstub).

  - If full-fledged JTAG hardware-based debugging is required, see
    [JTAG Debugging](https://docs.espressif.com/projects/esp-idf/en/latest/api-guides/jtag-debugging)
    for information about setting up an OpenOCD based environment.

## Usage

Once the software is flashed onto the ESP32 and the conveyor belt has been assembled,
it is ready to be controlled from AWS IoT's shadow service.

### Control the Conveyor Belt

1. First log into your AWS account and navigate to the "IoT Core" service.

2. From the navigation sidebar on the left, choose "Manage".

3. From the list of things, click on the thing name of your conveyor belt.

4. Choose "Shadow" from the sidebar. You will then see your conveyor's device shadow state. The
   device shadow state is divided into two json objects: "desired" and "reported". To control
   the conveyor belt, you will edit the "desired" object.

5. To edit the shadow's desired state, click "Edit" on the right side of the display. Now you are
   free to change the conveyor's desired speed and mode. Listed below are the valid inputs for
   speed and mode. If you enter an invalid speed or mode, the conveyor will ignore it.

   - Speed: 1 = slow; 2 = fast

   - Mode: 1 = backward; 2 = stopped; 3 = forward

6. After making your changes, click "Save". The ESP32 will then be notified of the request,
   update its actual state accordingly, and then update the device shadow's reported
   state accordingly.

### Monitor the Publishing of Telemetry Data

1. First log into your AWS account and navigate to the "IoT Core" service.

2. From the navigation sidebar on the left, choose "Test".

3. Click on "Subscribe to a topic".

4. For "Subscription topic", enter `dt/conveyor/speed`. Then click the "Subscribe to topic"
   button to subscribe. You will be brought to a tab showing incoming rpm data.

5. Click on "Subscribe to a topic" again and enter `dt/conveyor/vibration`. Click the button to
   subscribe and you will be brought to a tab showing incoming vibration data.

## Repository Structure and Contents

### Detailed Overview

- This repository contains two main directories: `amazon-freertos` and `conveyor_code`.

  - The directory `amazon-freertos` is the full Amazon FreeRTOS git repository.
    It is included here as a git submodule to allow for easy response to updates to
    the Amazon FreeRTOS codebase; when Amazon FreeRTOS releases an update, the update can easily
    be pulled into this repository by running `git pull` from the `amazon-freertos` directory.

  - The directory `conveyor_code` contains the core logic specific to the Industrial
    IoT Demo. A detailed description of the directory's contents can be found below.

- When this project is built by running `./config/configure.sh all`, the contents of
  the `amazon-freertos` directory are copied into a new directory `Amazon_FreeRTOS_Conveyor`,
  then the contents of `conveyor_code` are inserted into their appropriate location within
  the newly populated `Amazon_FreeRTOS_Conveyor` directory. Specifically, the directory
  `./Amazon_FreeRTOS_Conveyor/demos/espressif/esp32_devkitc_esp_wrover_kit`,
  which is the directory dedicated to running Amazon FreeRTOS on the ESP32,
  becomes the home for this demo, and the demo's core logic that was copied over from
  `conveyor_code` (along with detailed documentation of the logic) can be found in
  `./Amazon_FreeRTOS_Conveyor/demos/espressif/esp32_devkitc_esp_wrover_kit/common/application_code`.
  The directory `Amazon_FreeRTOS_Conveyor/demos/espressif/esp32_devkitc_esp_wrover_kit/make`
  contains the Makefile that is used to build and flash the project (more information
  on this Makefile is available below).

- Thus, once the project is set up, `Amazon_FreeRTOS_Conveyor` will house the
  overarching project, `./Amazon_FreeRTOS_Conveyor/demos/espressif/esp32_devkitc_esp_wrover_kit`
  will hold the demo-specific code, and the two initial directories `amazon-freertos`
  and `conveyor_code` can be ignored.

- Again, the project is structured in this way to allow for easy response to updates
  to the Amazon FreeRTOS codebase. Specifically, if an updated version of `amazon-freertos`
  is available, running `./config/configure.sh update` will pull the update into the `amazon-freertos`
  submodule and rebuild `Amazon_FreeRTOS_Conveyor` with the updated codebase (see Scripts
  and Makefiles below for more information).

### Contents of conveyor_code

- `README.md` Contains in-depth documentation of the logic specific to the Industrial IoT Demo.

- `main.c` The entry point to the logic specific to the Industrial IoT Demo.
  Performs lower level application initialization, i.e. starting the FreeRTOS
  scheduler, configuring memory, and connecting to wifi. Then initializes the
  Industrial IoT demo by creating the demo's tasks, connecting to AWS IoT
  services, and configuring the GPIO pins. This file also includes the Watchdog task
  which is responsible for reconnecting to Wifi/IoT services upon a disconnect.

- `aws_conveyor_shadow.c` Contains the logic concerning communication with and response to
  the AWS IoT Device Shadow: listening for a change in desired state, updating actual
  conveyor state accordingly, and updating the device shadow with reported state.

- `aws_conveyor_telemetry.c` Contains the logic concerning telemetry data: reading
  rpm and vibration data and publishing them to their respective AWS IoT MQTT topics.

- `conveyor_include/` Contains the project-specific header files `aws_conveyor_shadow.h`,
  `aws_conveyor_telemetry.h`, and `aws_conveyor_shared.h`.

### Additional Libraries

This demo allows for easy inclusion of additional libraries. To add in a library, simply add the .c
file into `conveyor_code` and add the .h file into `conveyor_code/conveyor_include`.

- **WS2812 LED Library**

  - This library, downloaded from https://github.com/FozzTexx/ws2812-demo, is a driver for WS2812 RGB LEDs.
    Through the use of this library, we are able to display the demo's state via the demo's LED. The demo's
    possible states are as follows:

      - BLUE: Demo is attempting to connect to Wifi

      - PINK: Demo has connected to Wifi and is attempting to connect to AWS IoT services

      - GREEN: Demo has connected to all services and is running

      - RED: Demo has detected a belt jam and is in error mode

## Scripts and Makefiles

### Project Configuration Script (./config/configure.sh)

The project configuration script contains commands to set up the project, clean the project,
and update the project. You can use this script to do the following:

- **Set up the entire project**

  - Run `./config/configure.sh all`. The script will first fill out `config/configure.json` by
    prompting you to input your AWS IoT thing name, your WiFi SSID, your WiFi password, and your WiFi
    security type. It will then create the `Amazon_FreeRTOS_Conveyor` directory, copy the contents of
    the `amazon-freertos` directory and the `conveyor_code` directory into the new `Amazon_FreeRTOS_Conveyor`
    directory, and create the AWS IoT thing. It will also populate the file
    `./Amazon_FreeRTOS_Conveyor/demos/common/include/aws_clientcredential.h` with your
    AWS IoT endpoint, Wi-Fi SSID and credentials and will format your certificate and private
    key and write them to the `./Amazon_FreeRTOS_Conveyor/demos/common/include/aws_clientcredential_keys.h`
    header file.

    - When running this command, you might get a message warning you that your version of OpenSSL
      is out of date. You can safely ignore it.

- **Change your WiFi network**

  - First open `config/configure.json` and update the fields with your new WiFi information.
    Then run `./config/configure.sh credentials`. This updates `./Amazon_FreeRTOS_Conveyor/demos/common/include/aws_clientcredential.h`
    and `./Amazon_FreeRTOS_Conveyor/demos/common/include/aws_clientcredential_keys.h`.

- **Set up the project using a different AWS IoT thing**

  - If you want to run the project with a different AWS IoT thing, the easiest way to do so is to
    remake the project by running `./config/configure.sh all`. You can optionally run `./config/configure.sh clean`
    beforehand to clean up your old AWS IoT thing.

- **Update the project upon a new release of Amazon FreeRTOS**

  - Run `./config/configure.sh update`.This command pulls the updated version of Amazon FreeRTOS
    into the `amazon-freertos` submodule directory and updates the `Amazon_FreeRTOS_Conveyor` directory accordingly.

    - This command assumes you have set up the project already. If you have not set up the project
      but still want to update the Amazon FreeRTOS submodule, just run `git submodule update --recursive`.

- **Clear your credentials from the project**

  - Run `./config/configure.sh clean-credentials`. This reverts the changes in `aws_clientcredential.h` and
    `aws_clientcredential_keys.h` by setting the two files back to their original state.

- **Clean the entire project back to its original state**

  - Run `./config/configure.sh clean`. This command cleans up the entire project, including
    the deletion of the `Amazon_FreeRTOS_Conveyor` directory and the deletion of the AWS IoT thing.
    It assumes that you have run `./config/configure.sh all` to set up the IoT thing and have
    not since manually deleted the IoT thing.

    - This command will fail if you manually deleted your AWS IoT thing in the AWS console before
      running the command. If this occurs for you and you want to reset the project to its original state,
      just delete the `Amazon_FreeRTOS_Conveyor` directory and delete the `config/configure.json` file.
      If you want to rebuild the project using the same name of the IoT thing you deleted, you will
      need to manually delete your thing's AWS IoT policy in the console before rebuilding.

### Espressif Makefile (./Amazon_FreeRTOS_Conveyor/demos/espressif/esp32_devkitc_esp_wrover_kit/make/Makefile)

This internal Makefile is used after the project has been set up. It is Amazon FreeRTOS's
ESP32-specific Makefile and contains commands to build the project and flash it
to the ESP32. From this Makefile you can run the following commands:

- `make menuconfig` Build and display the *Espressif IDF Configuration* used for
  configuring the project.

- `make` Build the project.  

- `make flash` Build the project and flash it to the ESP32.  

- `make flash monitor` Build the project, flash it to the ESP32, and display
  the output in the terminal.  

## Data Types and Coding Style

This project makes use of Amazon FreeRTOS's data types and coding style guide, which includes
the use of `BaseType_t` data types and the use of specific prefixes for variable and function names.
[Click here](https://docs.aws.amazon.com/freertos-kernel/latest/ref/reference131.html)
to read more.
