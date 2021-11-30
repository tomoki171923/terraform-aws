#!/bin/bash

BASE_PATH=$(
	cd $(dirname $0)
	pwd
)
DEFAULT="\033[00m"
BOLD="\033[01m"
COLOR_GREEN="\033[32m"

# --------------------------------------------------
# local functions
# --------------------------------------------------
function check_arg() {
  local correcy_args=('dev' 'st' 'pro')
  local arg=$1
  local i
  for i in ${correcy_args[@]}; do
      if [ ${i} == $arg ]; then
          return 0
      fi
  done
  echo "${COLOR_RED}Please select an environment just between [${COLOR_YELLOW}${correcy_args[@]}${COLOR_RED}]."
  exit 255
}


# --------------------------------------------------
# main
# --------------------------------------------------
# input arguments
echo "Please input the ${BOLD}ECR REPOSITORY NAME${DEFAULT}: "
read ECR_REPOSITORY_NAME
echo "Please input the ${BOLD}LOCAL DOCKER IMAGE NAME${DEFAULT}: "
read LOCAL_DOCKER_IMAGE_NAME
echo "Please input the ${BOLD}DEPLOY ENVIRONMENT${DEFAULT} between [${COLOR_GREEN}${BOLD}dev, st, pro${DEFAULT}]."
read DEPLOY_ENVIRONMENT
check_arg $DEPLOY_ENVIRONMENT
echo "Please input the ${BOLD}DOCKER IMAGE TAG${DEFAULT}: "
read DOCKER_IMAGE_TAG

# get aws account
AWS_ACCOUNT=`aws sts get-caller-identity --query 'Account' --output text`

# get latest image tag
IMAGES=`aws ecr list-images --repository-name $ECR_REPOSITORY_NAME --output text | grep $DEPLOY_ENVIRONMENT | awk '{print $3}'`

echo $IMAGES


# build image.
<< COMMENTOUT
echo "...Start building ${COLOR_GREEN}${LOCAL_DOCKER_IMAGE_NAME}:$DOCKER_IMAGE_TAG${DEFAULT} image in local."
echo "...Build ${COLOR_GREEN}${LOCAL_DOCKER_IMAGE_NAME}_$DOCKER_IMAGE_TAG${DEFAULT} docker image"
docker build -t $LOCAL_DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG .
echo "...Create Docker image tag to push ECR."
docker tag $LOCAL_DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG $AWS_ACCOUNT.dkr.ecr.ap-northeast-1.amazonaws.com/$ECR_REPOSITORY_NAME:${DEPLOY_ENVIRONMENT}_$DOCKER_IMAGE_TAG

# push docker image to ecr.
echo "...Start pushing image into ${COLOR_GREEN}$AWS_ACCOUNT.dkr.ecr.ap-northeast-1.amazonaws.com/$ECR_REPOSITORY_NAME:${DEPLOY_ENVIRONMENT}_$DOCKER_IMAGE_TAG${DEFAULT}"
echo "...Login ECR."
aws ecr get-login-password | docker login --username AWS --password-stdin https://$AWS_ACCOUNT.dkr.ecr.ap-northeast-1.amazonaws.com
echo "...Push docker image to ${COLOR_GREEN}${ECR_REPOSITORY_NAME}${DEFAULT} repository on ECR."
docker push $AWS_ACCOUNT.dkr.ecr.ap-northeast-1.amazonaws.com/$ECR_REPOSITORY_NAME:${DEPLOY_ENVIRONMENT}_$DOCKER_IMAGE_TAG
COMMENTOUT
