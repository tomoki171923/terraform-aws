#!/bin/bash

ECR_REPOSITORY_NAME=sample-ecr
AWS_REGION=ap-northeast-1
IMAGE_NAME=web

bash ./push_ecr.sh $ECR_REPOSITORY_NAME $AWS_REGION $IMAGE_NAME
