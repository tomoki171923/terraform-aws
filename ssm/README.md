<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [SSM](#ssm)
  - [Install SSM Agent](#install-ssm-agent)
  - [Quick Setup](#quick-setup)
  - [Session Manager](#session-manager)
    - [Set session log](#set-session-log)
    - [from AWS Console to EC2](#from-aws-console-to-ec2)
    - [from Local to EC2](#from-local-to-ec2)
  - [Cloudwatch Agent](#cloudwatch-agent)
    - [install collected on EC2](#install-collected-on-ec2)
    - [update Cloudwatch Agent config](#update-cloudwatch-agent-config)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# SSM

<https://ap-northeast-1.console.aws.amazon.com/systems-manager/home?region=ap-northeast-1>

## Install SSM Agent

<https://docs.aws.amazon.com/systems-manager/latest/userguide/agent-install-al2.html>

## Quick Setup

Set SSM agent & Cloudwatch agent in EC2 instances.

Quick Setup > Get Started > Create > Host Management >

- Configuration options:
  select all check boxes.

- Target Instances:
  Manual > select your instances.
  or
  Specify instance tag > add tag [Key: SSM , Value: true]

Click [Create] button.

## Session Manager

### Set session log

<https://ap-northeast-1.console.aws.amazon.com/systems-manager/session-manager/preferences?region=ap-northeast-1>

Edit > CloudWatch logging >

- CloudWatch logging:
  select Enable.

- Choose a log group name from the list:
  select [/aws/ssm/console]

### from AWS Console to EC2

<https://ap-northeast-1.console.aws.amazon.com/systems-manager/session-manager/sessions?region=ap-northeast-1>

Start session >

- Target instances:
  select your instances.

Click [Start sesstion] button.

### from Local to EC2

install Session Manager plugin on Local.

<https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html>

login

```bash
% bash ssmlogin.sh
```

e.g.

```bash
% bash ssmlogin.sh
Please input the EC2 INSTANCE NAME:
SampleSSMInstance
Instance ID : i-022f787f867dbe071
Start Session ...

Starting session with SessionId: iamuser-070623729437abff5
date; hostname ; whoami


sh-4.2$ date; hostname ; whoami
Fri Nov 26 11:53:31 UTC 2021
ip-10-101-1-93.ap-northeast-1.compute.internal
ssm-user
sh-4.2$
```

## Cloudwatch Agent

### install collected on EC2

<https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/monitoring/CloudWatch-Agent-custom-metrics-collectd.html>

### update Cloudwatch Agent config

<https://ap-northeast-1.console.aws.amazon.com/systems-manager/run-command/executing-commands?region=ap-northeast-1>

Run Command >

- Command document:
  select [AmazonCloudWatch-ManageAgent]

- Command parameters:
  Action: configure
  Mode: ec2
  Optional Configuration Source: ssm
  Optional Configuration Location: YOUR SSM PARAMETER NAME (e.g. cloudwatchagt_basic)
  Optional Restart: yes

- Targets
  select instances

- Output options
  check [Enable CloudWatch logs]

Click [RUN] button.
