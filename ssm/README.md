# SSM

<https://ap-northeast-1.console.aws.amazon.com/systems-manager/home?region=ap-northeast-1>

## Quick Setup

Set SSM agent & Cloudwatch agent in EC2 instances.

Quick Setup > Get Started > Create > Host Management >

Configuration options:
select all check boxes.

Targets:
select your instances.

Click [Create] button.

## Session Manager

### Set session log

<https://ap-northeast-1.console.aws.amazon.com/systems-manager/session-manager/preferences?region=ap-northeast-1>

Edit > CloudWatch logging >

CloudWatch logging:
select Enable.

Choose a log group name from the list:
select [/aws/ssm/console]

### from AWS Console to EC2

<https://ap-northeast-1.console.aws.amazon.com/systems-manager/session-manager/sessions?region=ap-northeast-1>

Start session >

Target instances:
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
