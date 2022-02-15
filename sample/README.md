<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Sample Computing](#sample-computing)
  - [EC2](#ec2)
  - [ECS Fargate](#ecs-fargate)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Sample Computing

Terraform Samples for a computing like EC2, AutoScalingGroup, ECS, Fargate.

## EC2

[EC2 Single](./modules/computing/ec2_single/)

[EC2 Auto Scaling Group on CLB](./modules/computing/ec2_clb/)

[EC2 Auto Scaling Group on ALB](./modules/computing/ec2_alb/)

## ECS Fargate

[ECS Fargate on ALB](./modules/computing/fargate_alb/)

procedure

1. terraform apply with fargate_alb=false
1. push docker image into ecr
1. terraform apply with fargate_alb=true
