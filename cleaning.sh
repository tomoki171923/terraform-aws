#!/bin/sh

BASE_PATH=$(cd $(dirname $0); pwd)

# in the destroying order
MODULES=(
    "rds"
    "dynamodb"
    "elasticache"
    "kinesis/ap-northeast-1"
    "es/amazon-es"
    "ec2"
    "lambda"
    "apigateway"
    "vpc"
    #"ecr"
    #"cloudfront/ap-northeast-1"
    #"route53"
    #"acm/ap-northeast-1"
    #"acm/us-east-1"
)

# destroy all modules
for module in "${MODULES[@]}" ; do
    cd ${BASE_PATH}/${module}
    pwd
    terraform destroy -auto-approve
done