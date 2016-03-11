#!/bin/bash

FileName="$(basename "$0")"

#Get the path of current script file
DirsName="$([ "." != "$(dirname "$0")" ] && (cd $(dirname "$0") && pwd -P) || ([ -f ./"${FileName}" ] && pwd -P || dirname $(which "${FileName}")))"


######################################################################
##### Create variables indicate couple of paths used during the execution
######################################################################
function init_common_profile
{
    
    export SAT_TEST_ROOT="tst_test"
    export SAT_TEST_DIR="bin"
    
    #Path on device
    export SAT_DEVICE_TEST_ROOT="~${SYBEROS_LOGIN_USER}/${SAT_TEST_ROOT}"
    export SAT_DEVICE_TAR_PATH="~${SYBEROS_LOGIN_USER}/${SAT_TEST_ROOT}.tar.gz"
    export SAT_DEVICE_CASE_PATH="${SAT_DEVICE_TEST_ROOT}/bin"
    export SAT_DEVICE_TOOL_PATH="/bin/test_case/tools"
    export SAT_DEVICE_RESULT_PATH="${SAT_DEVICE_TEST_ROOT}/case_result"
    
    export SAT_DEVICE_RESULT_FILE="test_case_result"
    export SAT_DEVICE_STDOUT_FILE="case_out_put.txt"
    export SAT_DEVICE_ERROUT_FILE="case_err_put.txt"
    
    #Path on host machine
    export SAT_HOST_PACKAGEING_PATH="${DirsName}/testspace/${SYBEROS_DEVICE_NAME}"
    export SAT_HOST_TAR_PATH="$SAT_HOST_PACKAGEING_PATH"'.tar.gz'


    
    #local d_case_result="test_case_result"
    #local f_exe_out_put="case_out_put.txt"
    #local f_exe_err_put="case_err_put.txt"

    #scpfilepath="${DirsName}/testcasedir/${TestRootDir}"
    #tarfilename="$scpfilepath"'.tar.gz'
    #inphonefile="~${LoginUser}/${TestRootDir}.tar.gz"
}

######################################################################
##### Mapping the device profile given from user to local variable
######################################################################
function init_device_profile
{

    [ $# != 6 ] && echo "Error: the amount of parameter is not correct !" && exit 181

    export SYBEROS_PHONE_ADDR="$1"
    
    export SYBEROS_LOGIN_USER="$2"
    export SYBEROS_LOGIN_PASSWD="$3"

    export SYBEROS_EXEC_USER="$4"
    export SYBEROS_EXEC_PASSWD="$5"
    
    export SYBEROS_DEVICE_NAME="$6"
    
    
    init_common_profile
}




