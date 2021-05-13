#!/bin/sh

BASE_PATH=`dirname $0`
PUBLIC_IP=`terraform output -json ec2 | jq '."sample-single"[0].public_ip' | sed 's/"//g'`
KEY_NAME=`terraform output -json ec2 | jq '."sample-single"[0].key_name' | sed 's/"//g'`
ssh -i "~/.ssh/${KEY_NAME}.pem" ubuntu@$PUBLIC_IP
