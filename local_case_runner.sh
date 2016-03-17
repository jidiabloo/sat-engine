#!/bin/bash

#include the utils
. ./utils.sh
echo "111111"
function handle_opt
{
    echo " "
}


# Function：extract_test_case
# Extract the executable test case from given directory and upload the cases to the target device
# 
# 
# The given folder is expected to contain at least one rpm package
# input：$@
#       The path to folder containing test rpms 
function extract_test_case
{
    ##the new workspace
    tzipworkdir="$SAT_HOST_PACKAGEING_PATH/cases"
    #after the extraction, we move the case to here
    #tzipworkdir="${DirsName}/testspace/${SAT_TEST_ROOT}/${TestCaseDir}/unit-case"

    local local_folder="/home/xji/Misc/sat-engine/tests/res"
    local rpm_workspace="${DirsName}/testrpmwork/unit-case"

    #Create new rpm workspace if it is not exist
    if [ -d "${rpm_workspace}" ]; then
	cd "${rpm_workspace}" && rm -rf ./*
    else
	mkdir -p "${rpm_workspace}"
    fi
    
    if [ -d "${tzipworkdir}" ]; then
	cd "${tzipworkdir}" && rm -rf ./*
    else
	mkdir -p "${tzipworkdir}"
    fi

    
    #Create new rpm workspace if it is not exist
    #! [ -d "${rpm_workspace}" ] && mkdir -p "${rpm_workspace}" 
    #! [ -d "${tzipworkdir}" ] && mkdir -p "${tzipworkdir}" 

    #Get all test rpm from folder
    local filelist=`ls "$local_folder"/*-tests-[0-9]*.armv7tnhl.rpm`

    (
	for((i = 0 ; i < ${#filelist[@]} ; ++i))
	do
	    PutTtyInfo "The rpm test file: ${filelist[$i]} will be extracted "
	    ! [ -f "${filelist[$i]}" ] && CerrInfo "Error: the rpm package: $filelist[$i] is not qualify ! " || cp "${filelist[$i]}" "${rpm_workspace}"
	    cd "${rpm_workspace}" && rpm2cpio "${filelist[$i]##/*/}" | cpio -div 1>/dev/null 2>&1 | [ $? != 0 ] && CerrInfo "Error: Failed to extract test rpm package! : " && exit 170

	    echo " !!!!!!!! $?"
	    
	done
    ) 

    echo "the extraction has been done, do the moving"

    #Contain the list of all the executable test case
    local bin_list=()

    #Get all executable binary from extracted rpm
    bin_list=(`find ${rpm_workspace} -name "*_syberos.out"`)

    if [ $? != 0 ]; then
	CerrInfo "Error: problem occured duing extract test case ! "
    else
	PutTtyInfo "Extract test case successfully !!"
    fi
    
    #PutTtyInfo "rpm_list: ${filelist[@]}"
    #PutTtyInfo "bin_list: ${bin_list[@]}"
    
    #Move all the case to scp dir
    for((i = 0 ; i < ${#bin_list[@]} ; ++i))
    do
	local case_folder=${bin_list[$i]%%/bin/*.out}
	#echo "move case folder $case_folder to ::::  ${tzipworkdir}"
	! mv $case_folder "${tzipworkdir}" && CerrInfo "cp ${exefile_name_array[${i}]} error" && exit 111
    done


    (
	# Change dir to "${DirsName}/testcasedir"
	cd "${SAT_HOST_PACKAGEING_PATH}/cases"
	
	# Create folder containing the result data
	mkdir -p "./case_result"
	
	tar -cvzf cases.tar.gz ./* 1>/dev/null
	
    )

    #TODO: Scp the new tar file to target device
    ssh_copy "${SAT_HOST_PACKAGEING_PATH}/cases/cases.tar.gz" "${SAT_DEVICE_TEST_ROOT}"

    run_case
}
echo "111111 3"

function run_case
{
    local returncode=0
    #extract the cases
    phoneroot_exec "cd ${SAT_DEVICE_TEST_ROOT} && tar -xvzf ${SAT_DEVICE_TEST_ROOT}/cases.tar.gz 1>/dev/null 2>&1 && rm -rf ${SAT_DEVICE_TEST_ROOT}/cases.tar.gz && chmod 777 ${SAT_DEVICE_RESULT_PATH}"
    #execute the cases
    phoneroot_exec "${SAT_DEVICE_TOOL_PATH}/${caseexe} ${SAT_DEVICE_TEST_ROOT}/${phonecasedata} ${SAT_DEVICE_RESULT_PATH};"' returncode=$?; '"chown -R ${SYBEROS_LOGIN_USER}:${SYBEROS_LOGIN_USER} ${SAT_DEVICE_TEST_ROOT}"

    #phoneroot_exec "cd ${SAT_DEVICE_TEST_ROOT} && tar -xvzf ${SAT_DEVICE_TEST_ROOT}/cases.tar.gz 1>/dev/null 2>&1 && rm -rf ${SAT_DEVICE_TEST_ROOT}/cases.tar.gz && chmod 777 ${SAT_DEVICE_RESULT_PATH} && ${SAT_DEVICE_TEST_ROOT}/${caseexe} ${SAT_DEVICE_TEST_ROOT}/${phonecasedata} ${SAT_DEVICE_RESULT_PATH};"' returncode=$?; '"chown -R ${SYBEROS_LOGIN_USER}:${SYBEROS_LOGIN_USER} ${SAT_DEVICE_TEST_ROOT} && rm -rf ${SAT_DEVICE_TEST_ROOT}/${phonecasedata} ${SAT_DEVICE_TEST_ROOT}/${caseexe}; "'exit ${returncode}' >/dev/tty   

}

#function run_case
#{    
#    ##clean environment
#    phoneroot_exec "cd ~${SYBEROS_LOGIN_USER} && rm -rf ${SAT_DEVICE_TEST_ROOT}"
#
#    
#    local returncode=0
#
#    phoneroot_exec "cd ~${SAT_DEVICE_TEST_ROOT} && tar -xvzf ~${SAT_DEVICE_TEST_ROOT}/cases.tar.gz 1>/dev/null 2>&1 && rm -rf ~${SAT_DEVICE_TEST_ROOT}/cases.tar.gz && chmod 777 ${SAT_DEVICE_RESULT_PATH} && ${SAT_DEVICE_TEST_ROOT}/${caseexe} ${SAT_DEVICE_TEST_ROOT}/${phonecasedata} ${SAT_DEVICE_RESULT_PATH};"' returncode=$?; '"chown -R ${SYBEROS_LOGIN_USER}:${SYBEROS_LOGIN_USER} ${SAT_DEVICE_TEST_ROOT} && rm -rf ${SAT_DEVICE_TEST_ROOT}/${phonecasedata} ${SAT_DEVICE_TEST_ROOT}/${caseexe}; "'exit ${returncode}' >/dev/tty
#
#
#    returncode=$?
#    [ ${returncode} != 0 ] && CerrInfo "phonerootexe.exp fails : ${returncode}" && exit 107
#    
#    ! sshpass -p "${LoginPawd}" scp -r -o StrictHostKeyChecking=no "${LoginUser}@${PhoneAddr}:${inphoneroot}/${inphoneresult}/${caseexe}/*" "${restdir}" && CerrInfo "scp -r -o StrictHostKeyChecking=no ${LoginUser}@${PhoneAddr}:${inphoneroot}/${inphoneresult}/${caseexe}/* ${restdir} fails" && exit 106
#    sshpass -p "${LoginPawd}" ssh -o StrictHostKeyChecking=no "${LoginUser}@${PhoneAddr}" "[ -d ~${LoginUser}/tst_log ]" && ! sshpass -p "${LoginPawd}" scp -r -o StrictHostKeyChecking=no "${LoginUser}@${PhoneAddr}:~${LoginUser}/tst_log" "${restdir}/tst_log" && CerrInfo "scp -r -o StrictHostKeyChecking=no ${LoginUser}@${PhoneAddr}:~${LoginUser}/tst_log ${restdir}/tst_log fails" && exit 105
#
#    return 0
#}
echo "111111 4"

function Test
{
    #We check if the target device support the qt5-test
    #check_qt5_test
    
    #Upload the tools needed by exeuting case in target device
    upload_tools "device1"

    #Extract the test case and copy them to case folder
    extract_test_case
    
    #run_case
    
}

#TODO: Add usage function
#TODO: Command option handling
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
		caseexe="unit_case_run"
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
echo "start !!!"
Main "$@"
