<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [terraform-aws](#terraform-aws)
    - [Procedure](#procedure)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# terraform-aws

This repository is the AWS Infrastructure as Code by Terraform. These are all samples.


### Procedure

e.g. vpc
~~~
cd vpc
terraform init -backend-config=./backends/dev.config
terraform plan
terraform apply
~~~
