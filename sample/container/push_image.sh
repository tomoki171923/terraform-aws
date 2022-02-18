#!/bin/bash

BASE_PATH=$(
	cd $(dirname $0)
	pwd
)
DEFAULT="\033[00m"
BOLD="\033[01m"
COLOR_GREEN="\033[32m"


# --------------------------------------------------
# parameters
# --------------------------------------------------
ECR_REPOSITORY_NAME=sample-ecr
AWS_REGION=ap-northeast-1
IMAGE_NAME=web
<< COMMENTOUT
echo "Please input the ${BOLD}ECR REPOSITORY NAME${DEFAULT}: "
read ECR_REPOSITORY_NAME
echo "Please input the ${BOLD}AWS REGION${DEFAULT}: "
read AWS_REGION
echo "Please input the ${BOLD}IMAGE NAME${DEFAULT}: "
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
    echo "The latest tag name : ${COLOR_GREEN}${LATEST_TAG}${DEFAULT}"
else
    echo "The latest tag name : "
    NEW_TAG_NUMBER=1
fi
echo "*************** Create the New Docker image tag name *************** "
NEW_TAG="${IMAGE_NAME}_${NEW_TAG_NUMBER}"
echo "The new tag name : ${COLOR_GREEN}${NEW_TAG}${DEFAULT}"

# build image.
echo "*************** Start building ${COLOR_GREEN}${NEW_TAG}${DEFAULT} docker image in local *************** "
docker build -t $NEW_TAG .
echo "*************** Create Docker image tag to push ECR *************** "
docker tag $NEW_TAG $AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY_NAME:$NEW_TAG
echo "Created ${COLOR_GREEN}$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY_NAME:$NEW_TAG${DEFAULT} image tag."

# push docker image to ecr.
echo "*************** Login ECR  *************** "
aws ecr get-login-password | docker login --username AWS --password-stdin https://$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com
echo "*************** Push docker image to ${COLOR_GREEN}${ECR_REPOSITORY_NAME}${DEFAULT} repository on ECR ***************"
docker push $AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY_NAME:$NEW_TAG
