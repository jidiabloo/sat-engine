#!/bin/bash

. ./device_profile.sh
. ./log.sh
. ./error_code.sh

#map the device profile so that we can use the universal device profile
init_device_profile "192.168.100.100" "developer" "system" "root" "system" "device1"

#Get the name of current script
FileName="$(basename "$0")"

#Get the path of current script file
DirsName="$([ "." != "$(dirname "$0")" ] && (cd $(dirname "$0") && pwd -P) || ([ -f ./"${FileName}" ] && pwd -P || dirname $(which "${FileName}")))"

######################################################################
##### if the terminal is avaliable
######################################################################
if tty 1>/dev/null 2>&1; then
    TerminalBool=1
else
    TerminalBool=0
fi




function check_tools_installed
{
    ErrorCode=63
    ! [ -f "/usr/bin/gawk" ] && CerrInfo "please install gawk" && exit ${ErrorCode} || ((--ErrorCode))
    ! [ -f "/usr/bin/wget" ] && CerrInfo "please install wget" && exit ${ErrorCode} || ((--ErrorCode))
    ! [ -f "/usr/bin/expect" ] && CerrInfo "please install expect" && exit ${ErrorCode} || ((--ErrorCode))
    ! [ -f "/usr/bin/sshpass" ] && CerrInfo "please install sshpass" && exit ${ErrorCode} || ((--ErrorCode))
    ! [ -f "/bin/cpio" ] && CerrInfo "please install cpio" && exit ${ErrorCode} || ((--ErrorCode))
    ! [ -f "/usr/bin/rpm2cpio" ] && CerrInfo "please install rpm2cpio" && exit ${ErrorCode} || ((--ErrorCode))
    ! [ -f "/usr/bin/xsltproc" ] && CerrInfo "please install xsltproc" && exit ${ErrorCode} || ((--ErrorCode))

    return 0
}


function clean_known_hosts
{
    [ $# != 1 ] && echo "Error: the amount of parameter is not correct !"

    PhoneAddr=$1
    ssh-keygen -f "${HOME}/.ssh/known_hosts" -R ${PhoneAddr}

    [ $? != 0 ] && echo "Error: problem during clean all the know_hosts"
}

function ssh_exec
{
    [ $# != 1 ] && echo "Error: the amount of parameter is not correct !"
    
    instruction=$1
    sshpass -p "${SYBEROS_LOGIN_PASSWD}" ssh -o StrictHostKeyChecking=no "${SYBEROS_LOGIN_USER}@${SYBEROS_PHONE_ADDR}" "$instruction"
    if [ $? != 0 ];then 
	CerrInfo "Error: ssh execution failed !!"
	exit $SSH_EXEC_FAILED
    fi
    
}

function ssh_copy
{
    
    [ $# != 2 ] && echo "Error: the amount of parameter is not correct !"
    
    source=$1
    dist=$2
    
    sshpass -p "${SYBEROS_LOGIN_PASSWD}" scp -r -o StrictHostKeyChecking=no "$source" "${SYBEROS_LOGIN_USER}@${SYBEROS_PHONE_ADDR}:$dist"

    if [ $? != 0 ];then 
	CerrInfo "Error: ssh copy failed !!"
	exit $SSH_COPY_FAILED
    fi
}

function init_device_env
{
    ssh_exec "mkdir -p ${SAT_DEVICE_TEST_ROOT} && rm -rf ${SAT_DEVICE_TEST_ROOT}/tools.tar.gz"
}

######################################################################
##### Package and upload tools to the target device
######################################################################

function upload_tools
{
    echo "tar file Name : $SAT_HOST_TAR_PATH ${SAT_TEST_ROOT}"
    #Check that if the tools has been installed into the host matchine
    check_tools_installed
    
    #Name of directory in SAT_HOST_PACKAGEING_PATH, which is for containing result
    local d_case_result="test_case_result"

    PutTtyInfo "Start to upload the tools to target device!"
    #create a tool folder, link tools to tar ball
    mkdir -p "${SAT_HOST_PACKAGEING_PATH}/tools"
    ##link all the tools to new folder
    ls ${DirsName}/tools/* | xargs -I xxx ln xxx "${SAT_HOST_PACKAGEING_PATH}/tools"
    ls ${DirsName}/inphoneshell/* | xargs -I xxx ln xxx "${SAT_HOST_PACKAGEING_PATH}/tools"
    
    (
	# Change dir to "${DirsName}/testcasedir"
	cd "$SAT_HOST_PACKAGEING_PATH"
        tar -cvzf tools.tar.gz ./tools/* 1>/dev/null

	
    )
    
    if [ $? != 0 ]; then
	PutTtyInfo "Error: there are problem during making tar ball"
    else
	PutTtyInfo "tar the cases ----------OK"
    fi
    
    #Clean the known host
    clean_known_hosts $SYBEROS_PHONE_ADDR
    
    #TODO: check if the qt5-test has been installed in target device 
    PutTtyInfo "Please wait: upload case to phone"

    ##Remove the existed tar file from target device
    #ssh_exec "mkdir -p ${SAT_DEVICE_TEST_ROOT} && rm -rf ${SAT_DEVICE_TEST_ROOT}/tools.tar.gz" && [ $? != 0 ] && exit 110
    
    init_device_env
    echo "!!!!!!!!!!! ${SAT_HOST_PACKAGEING_PATH}"
    echo "!!!!!!!!!!! ${SAT_DEVICE_TEST_ROOT}"
    ##Scp the new tar file to target device
    ssh_copy "${SAT_HOST_PACKAGEING_PATH}/tools.tar.gz" "${SAT_DEVICE_TEST_ROOT}" 
    
    ##Extract the tools to the specific location
    phoneroot_exec "cd ${SAT_DEVICE_TEST_ROOT} && tar -xvzf tools.tar.gz  1>/dev/null 2>&1 && rm -rf tools.tar.gz && rm -rf ${SAT_DEVICE_TOOL_PATH} && mkdir -p ${SAT_DEVICE_TOOL_PATH} && cp ${SAT_DEVICE_TEST_ROOT}/tools/* ${SAT_DEVICE_TOOL_PATH} && rm -rf ${SAT_DEVICE_TEST_ROOT}/tools && chmod 4755 /bin/test_case/tools/su_testcase;"' returncode=$?; exit ${returncode}' > /dev/tty

    PutTtyInfo "upload tools to phone ----------OK"    
}


function phoneroot_exec
{
   instruction="$1"
   echo "phoneroot_exec instruction: $1"

   "${DirsName}"/phonerootexe.exp "${SYBEROS_LOGIN_USER}@${SYBEROS_PHONE_ADDR}" "${SYBEROS_LOGIN_PASSWD}" "${SYBEROS_EXEC_USER}" "${SYBEROS_EXEC_PASSWD}" "${instruction}" 3600    

   returncode=$?
    [ ${returncode} != 0 ] && CerrInfo "failed to do phoneroot_exec() : ${returncode}" && exit $PHONE_ROOT_EXEC_FAILED
}



function Test
{
    
    phoneroot_exec "ls"

    #upload_tools
    #check_qt5_test
    #CerrInfo "aiyaya"
}

Test 
