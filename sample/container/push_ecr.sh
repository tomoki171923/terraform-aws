#!/bin/bash -eu
# **************************************************
# Push docker image into ECR.
# Usage
#   $ bash ./push_ecr.sh $ECR_REPOSITORY_NAME $AWS_REGION $IMAGE_NAME
# **************************************************

BASE_PATH=$(
	cd $(dirname $0)
	pwd
)
ESC=$(printf '\033')
RESET="${ESC}[0m"
BOLD="${ESC}[1m"
RED="${ESC}[31m"
YELLOW="${ESC}[33m"
GREEN="${ESC}[32m"


# --------------------------------------------------
# parameters
# --------------------------------------------------
ECR_REPOSITORY_NAME=$1
AWS_REGION=$2
IMAGE_NAME=$3
<< COMMENTOUT
echo "Please input the ${BOLD}ECR REPOSITORY NAME${RESET}: "
read ECR_REPOSITORY_NAME
echo "Please input the ${BOLD}AWS REGION${RESET}: "
read AWS_REGION
echo "Please input the ${BOLD}IMAGE NAME${RESET}: "
read IMAGE_NAME
COMMENTOUT


# --------------------------------------------------
# main
# --------------------------------------------------
# get aws account
AWS_ACCOUNT=`aws sts get-caller-identity --query 'Account' --output text`

# get the latest image tag & create a new tag.
echo "*************** Get the latest docker image tag on ECR *************** "
LATEST_TAG_NUMBER=`aws ecr list-images --repository-name $ECR_REPOSITORY_NAME --region ${AWS_REGION} --filter tagStatus=TAGGED --output text | grep $IMAGE_NAME | awk '{print $3}' |  sed -e "s/${IMAGE_NAME}_//" | sort -rn | head -1`
if [ -n "$LATEST_TAG_NUMBER" ]; then
    NEW_TAG_NUMBER=$(expr $LATEST_TAG_NUMBER + 1)
    LATEST_TAG="${IMAGE_NAME}_${LATEST_TAG_NUMBER}"
    echo "The latest tag name : ${GREEN}${LATEST_TAG}${RESET}"
else
    echo "The latest tag name : "
    NEW_TAG_NUMBER=1
fi
echo "*************** Create the New Docker image tag name *************** "
NEW_TAG="${IMAGE_NAME}_${NEW_TAG_NUMBER}"
echo "The new tag name : ${GREEN}${NEW_TAG}${RESET}"

# build image.
echo "*************** Start building ${GREEN}${NEW_TAG}${RESET} docker image in local *************** "
docker build -t $NEW_TAG .
echo "*************** Create Docker image tag to push ECR *************** "
docker tag $NEW_TAG $AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY_NAME:$NEW_TAG
echo "Created ${GREEN}$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY_NAME:$NEW_TAG${RESET} image tag."

# push docker image to ecr.
echo "*************** Login ECR  *************** "
aws ecr get-login-password | docker login --username AWS --password-stdin https://$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com
echo "*************** Push docker image to ${GREEN}${ECR_REPOSITORY_NAME}${RESET} repository on ECR ***************"
docker push $AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY_NAME:$NEW_TAG
