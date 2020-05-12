#!/bin/bash
#
# Fills out configure.json by prompting user for name of IoT thing,
# WiFi SSID, WiFi password, and WiFi security type.

APPLICATION_CODE_PATH=$PWD/Amazon_FreeRTOS_Conveyor/demos/espressif/esp32_devkitc_esp_wrover_kit/common/application_code
PYTHON_SCRIPT_PATH=$PWD/Amazon_FreeRTOS_Conveyor/demos/common/tools/aws_config_quick_start
HOME_PATH=$PWD

# set up the entire project
all() {
  ### ------ configure.json prompting ------ ###

  # create the file
  touch config/configure.json

  # add opening bracket
  echo { > config/configure.json

  # prompt user and read in thing name
  echo 'Enter the name of your IoT thing. Before proceeding, make sure the IoT Thing does not already exist in your account:'
  read thing_name
  echo \"thing_name\":\"$thing_name\", >> config/configure.json

  # prompt user and read in wifi ssid
  echo 'Enter the SSID of your Wi-Fi network:'
  read wifi_ssid
  echo \"wifi_ssid\":\"$wifi_ssid\", >> config/configure.json

  # prompt user and read in wifi password
  echo 'Enter the password for your Wi-Fi network:'
  read wifi_password
  echo \"wifi_password\":\"$wifi_password\", >> config/configure.json

  # prompt user and read in wifi security type
  echo 'Enter the security type for your Wi-Fi network. Possible values are - eWiFiSecurityOpen, eWiFiSecurityWEP, eWiFiSecurityWPA, eWiFiSecurityWPA2:'
  read wifi_security
  echo \"wifi_security\":\"$wifi_security\" >> config/configure.json

  # add closing bracket
  echo } >> config/configure.json

  ### ------ set up project directory ------ ###

  echo 'Setting up your project directory...'

  # copy submodule into new folder Amazon_FreeRTOS_Conveyor and insert conveyor code
  if [ ! -d 'Amazon_FreeRTOS_Conveyor' ]; then
    mkdir Amazon_FreeRTOS_Conveyor
  fi
  cp -a amazon-freertos/. Amazon_FreeRTOS_Conveyor
  cp -a conveyor_code/. $APPLICATION_CODE_PATH

  ### ------ create AWS IoT thing, certificate, and policy, (with initial thing shadow) ------ ###

  echo 'Creating your AWS IoT thing...'

  # create AWS IoT thing, certificate, and policy
  cp config/configure.json $PYTHON_SCRIPT_PATH
  cd $PYTHON_SCRIPT_PATH
  python SetupAWS.py prereq

  # add initial thing shadow with aws cli tool
  aws --profile AdmThomas iot-data update-thing-shadow --thing-name=$thing_name --payload='{"state":{"desired":{"speed":1,"mode":2}}}' /dev/null

  ### ------ update aws_clientcredential.h and aws_clientcredential_keys.h ------ ###

  cd $PYTHON_SCRIPT_PATH
  python SetupAWS.py update_creds

  echo 'Done.'
}

# update aws_clientcredential.h and aws_clientcredential_keys.h
credentials() {
  cp config/configure.json $PYTHON_SCRIPT_PATH
	cd $PYTHON_SCRIPT_PATH
  python SetupAWS.py update_creds
}

# update Amazon_FreeRTOS_Conveyor directory based on updated submodule
update() {
  # grab thing name from configure.json
  thing_name=$(grep -o '"thing_name": *"[^"]*"' config/configure.json | grep -o '"[^"]*"$' | tr -d '"')

  # pull out files we want to save
  cp $PYTHON_SCRIPT_PATH/${thing_name}_cert_id_file .
  cp $PYTHON_SCRIPT_PATH/${thing_name}_cert_pem_file .
  cp $PYTHON_SCRIPT_PATH/${thing_name}_private_key_pem_file .

  # delete the project directory
  rm -rf Amazon_FreeRTOS_Conveyor

  # pull in updated submodule
  git submodule update --recursive

  # copy submodule into new project directory and insert conveyor code
  mkdir Amazon_FreeRTOS_Conveyor
  cp -a amazon-freertos/. Amazon_FreeRTOS_Conveyor
  cp -a conveyor_code/. $APPLICATION_CODE_PATH

  # copy saved files back into the script folder
  cp ${thing_name}_cert_id_file $PYTHON_SCRIPT_PATH
  cp ${thing_name}_cert_pem_file $PYTHON_SCRIPT_PATH
  cp ${thing_name}_private_key_pem_file $PYTHON_SCRIPT_PATH

  # remake aws_clientcredential.h and aws_clientcredential_keys.h
  cp config/configure.json $PYTHON_SCRIPT_PATH
  cd $PYTHON_SCRIPT_PATH
  python SetupAWS.py update_creds

  # remove temporary files
  cd $HOME_PATH
  rm -f ${thing_name}_cert_id_file
  rm -f ${thing_name}_cert_pem_file
  rm -f ${thing_name}_private_key_pem_file
}

# revert the changes in aws_clientcredential.h and aws_clientcredential_keys.h
clean-credentials() {
  cd $PYTHON_SCRIPT_PATH
  python SetupAWS.py cleanup_creds
}

# clean entire project (includes AWS IoT thing)
clean() {
  cd $PYTHON_SCRIPT_PATH
  python SetupAWS.py delete_prereq
  cd $HOME_PATH
  rm -rf Amazon_FreeRTOS_Conveyor
	rm -f config/configure.json
}

# make sure we got exactly one argument
if [ $# -ne 1 ]; then
  echo 'usage: configure.sh arg1 (arg1 possible values: all, credentials, update, clean-credentials, clean)'
  exit 1
fi

# grab argument in variable "arg"
arg="$1"

if [ "$arg" = "all" ]; then
  all
fi

if [ "$arg" = "credentials" ]; then
  credentials
fi

if [ "$arg" = "update" ]; then
  update
fi

if [ "$arg" = "clean-credentials" ]; then
  clean-credentials
fi

if [ "$arg" = "clean" ]; then
  clean
fi
