#!/bin/sh

BASE_PATH=$(cd $(dirname $0); pwd)

# in the destroying order
MODULES=(
    "rds"
    "dynamodb"
    "elasticache"
    "es/amazon-es"
    "ec2"
    "lambda"
    "apigateway"
    "vpc"
    "cloudfront"
    "route53"
    "acm"
)

# destroy all modules
for module in "${MODULES[@]}" ; do
    cd ${BASE_PATH}/${module}
    pwd
    terraform destroy -auto-approve
done