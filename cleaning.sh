#!/bin/sh

BASE_PATH=$(cd $(dirname $0); pwd)

# in the destroying order
MODULES=(
    "rds"
    "dynamodb"
    "elasticache"
    "ec2"
    "lambda"
    "apigateway"
    "vpc"
)

# destroy all modules
for module in "${MODULES[@]}" ; do
    cd ${BASE_PATH}/${module}
    pwd
    terraform destroy -aoto-approve
done