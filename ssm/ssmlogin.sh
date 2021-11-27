#!/bin/bash

BASE_PATH=$(
	cd $(dirname $0)
	pwd
)
DEFAULT="\033[00m"
BOLD="\033[01m"
COLOR_GREEN="\033[32m"

echo "Please input the ${BOLD}EC2 INSTANCE NAME${DEFAULT}: "
read TARGET_INSTANCE_NAME

TARGET_INSTANCE_ID=`aws ec2 describe-instances --filters "Name=tag:Name,Values=$TARGET_INSTANCE_NAME" "Name=instance-state-name,Values=running" --query "Reservations[].Instances[].InstanceId" --output yaml | head -n 1`
TARGET_INSTANCE_ID=`echo ${TARGET_INSTANCE_ID//- /}`

echo "Instance ID : ${COLOR_GREEN}$TARGET_INSTANCE_ID${DEFAULT}"
echo "Start Session ..."
aws ssm start-session --target $TARGET_INSTANCE_ID
