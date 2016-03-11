#!/bin/bash

#TODO: Command option handling

#include the utils
. ./utils.sh

function handle_opt
{
    echo " "
}

#TODO: Prepare the test execution environment on target device
function prepare_env
{
    echo " "
}

######################################################################
##### Function：extract_test_case
##### Extract the executable test case from given directory 
#####       
##### input：$@
#####       The path to folder containing test rpms 
######################################################################
function extract_test_case
{
    ##the new workspace
    tzipworkdir = "$SAT_HOST_PACKAGEING_PATH/cases"
    #after the extraction, we move the case to here
    #tzipworkdir="${DirsName}/testspace/${SAT_TEST_ROOT}/${TestCaseDir}/unit-case"

    local local_folder="/home/xji/Downloads/framework-test"
    local rpm_workspace="${DirsName}/testrpmwork/unit-case"

    #Create new rpm workspace if it is not exist
    ! [ -d "${rpm_workspace}" ] && mkdir -p "${rpm_workspace}" 
    ! [ -d "${tzipworkdir}" ] && mkdir -p "${tzipworkdir}" 

    #Get all test rpm from folder
    local filelist=`ls "$local_folder"/*-tests-[0-9]*.armv7tnhl.rpm`

    (
	for((i = 0 ; i < ${#filelist[@]} ; ++i))
	do
	    PutTtyInfo "The rpm test file: ${filelist[$i]} will be extracted "
	    ! [ -f "${filelist[$i]}" ] && CerrInfo "Error: the rpm package: $filelist[$i] is not qualify ! " || cp "${filelist[$i]}" "${rpm_workspace}"
	    
	    cd "${rpm_workspace}" && rpm2cpio "${filelist[$i]##/*/}" | cpio -div 1>/dev/null 2>&1 | [ $? != 0 ] && CerrInfo "Error: Failed to extract test rpm package! : " && exit 170
	    
	done
    ) || exit $?
    

    #Contain the list of all the executable test case
    local bin_list=()

    #Get all executable binary from extracted rpm
    bin_list=(`find -name "*_syberos.out"`)

    if [ $? != 0 ]; then
	CerrInfo "Error: problem occured duing extract test case ! "
    else
	PutTtyInfo "Extract test case successfully !!"
    fi
    
    PutTtyInfo "rpm_list: ${filelist[@]}"
    PutTtyInfo "bin_list: ${bin_list[@]}"
    
    #Move all the case to scp dir
    for((i = 0 ; i < ${#bin_list[@]} ; ++i))
    do
	local case_folder=${bin_list[$i]%%/bin/*.out}
	echo "move case folder $case_folder to ::::  ${tzipworkdir}"
	! mv $case_folder "${tzipworkdir}" && CerrInfo "cp ${exefile_name_array[${i}]} error" && exit 111
    done


    #TODO: Package the cases as cases.tar.gz
    (
	# Change dir to "${DirsName}/testcasedir"
	cd "${tzipworkdir}"
	find -name "*"
        #tar -cvzf cases.tar.gz ./tools/* 1>/dev/null

    )

    #TODO: Scp the new tar file to target device
    #ssh_copy "${SAT_HOST_PACKAGEING_PATH}/cases.tar.gz" "${SAT_DEVICE_TEST_ROOT}" && [ $? != 0 ] && exit 109
}

function upload_cases
{
    echo "upload cases !!!"
        
}



function run_case
{
    phoneroot_exec "cd ~${SYBEROS_LOGIN_USER} && rm -rf ${SAT_DEVICE_TEST_ROOT} && tar -xvzf ${SAT_DEVICE_TAR_PATH} 1>/dev/null 2>&1 && rm -rf ${SAT_DEVICE_TAR_PATH} && ${SAT_DEVICE_TEST_ROOT}/install_init.sh ${SYBEROS_LOGIN_USER} ${SAT_DEVICE_TEST_ROOT} ${SAT_DEVICE_STDOUT_FILE} ${SAT_DEVICE_ERROUT_FILE} ${SAT_DEVICE_RESULT_FILE} && ( ( ${SAT_DEVICE_TEST_ROOT}/install_run.sh ${SAT_DEVICE_CASE_PATH} ${SAT_DEVICE_TEST_ROOT}/${SAT_DEVICE_RESULT_FILE} | /bin/test_case/tools/tee /dev/tty; "'exit ${PIPESTATUS[0]}'" ) 2>&1 1>${SAT_DEVICE_TEST_ROOT}/${SAT_DEVICE_STDOUT_FILE};"' exit $?'" ) | /bin/test_case/tools/tee /dev/tty 1>${SAT_DEVICE_TEST_ROOT}/${SAT_DEVICE_ERROUT_FILE};"' returncode=${PIPESTATUS[0]}; '"${SAT_DEVICE_TEST_ROOT}/install_destroy.sh ${SYBEROS_LOGIN_USER} ${SAT_DEVICE_TEST_ROOT} ${SAT_DEVICE_CASE_PATH}; rm -rf ${SAT_DEVICE_TEST_ROOT}/install_init.sh ${SAT_DEVICE_TEST_ROOT}/install_run.sh ${SAT_DEVICE_TEST_ROOT}/install_destroy.sh;"'exit ${returncode}' >/dev/tty

}


function Test
{
    #We check if the target device support the qt5-test
    #check_qt5_test
    
    #Extract the test case and copy them to case folder
    extract_test_case
    
    #Upload the tools needed by exeuting case in target device
    #upload_tools "device1"

    #run_case
    
}

function Main
{
    E_OPTERROR=65

    if [ $# -eq 0 ]
    then
	echo "Usage: `basename $0` options (-mnopqrs)"
	exit $E_OPTERROR
    fi
    
    while getopts ":td:" Option
    do
	case $Option in
	    t     ) 
		echo "SAT: Go into the self test routin !"
		Test
		;;
	    d     )
		echo "SAT: Start to run test case :: \"$OPTARG\""
		;;
	    *     ) 
		echo "Unimplemented option chosen" #DEFAULT
	esac
    done
    
    shift $(($OPTIND - 1))
    # Decrement the point to arguments, make it point to next argment
    
    exit 0
}




Main "$@"


