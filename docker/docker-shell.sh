#!/usr/bin/env bash

TEST_MODE=test
JENKINSBUILD_MODE=jenkinsbuild
MODE=$TEST_MODE

#parse argument list
while [[ $# > 0 ]]
do
	ARG=$1

	case $ARG in
	-t|--test) MODE=$TEST_MODE ;;
	-j|--jenkintest) MODE=$JENKINSBUILD_MODE ;;
	esac

	shift
done

#set pwd
cd /opt/app/current

#echo out environment variables we care about
echo APPLICATION_VARIABLES
echo NODE_ENV=$NODE_ENV
echo JOB_NAME=$JOB_NAME
echo BUILD_NUMBER=$BUILD_NUMBER

#execution based on argument
if [ $MODE == $TEST_MODE ]; then
	echo RUNNING TESTS
	make test
elif [ $MODE == $JENKINSBUILD_MODE ]; then
    echo RUNNING TB EVENT TRACK TESTS
    ls
    make test
fi