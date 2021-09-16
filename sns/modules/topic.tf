resource "aws_sns_topic" "dynamodb_alarms" {
  content_based_deduplication = "false"
  display_name                = "DynamoDB Alarms"
  fifo_topic                  = "false"
  name                        = "dynamodb_alarms"

  policy = <<POLICY
{
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish",
        "SNS:Receive"
      ],
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "868795213030"
        }
      },
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Resource": "arn:aws:sns:ap-northeast-1:868795213030:dynamodb_alarms",
      "Sid": "__default_statement_ID"
    }
  ],
  "Version": "2008-10-17"
}
POLICY
}

resource "aws_sns_topic" "lambda_alarms" {
  content_based_deduplication = "false"
  display_name                = "Lambda Alarms"
  fifo_topic                  = "false"
  name                        = "lambda_alarms"

  policy = <<POLICY
{
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish",
        "SNS:Receive"
      ],
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "868795213030"
        }
      },
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Resource": "arn:aws:sns:ap-northeast-1:868795213030:lambda_alarms",
      "Sid": "__default_statement_ID"
    }
  ],
  "Version": "2008-10-17"
}
POLICY
}
