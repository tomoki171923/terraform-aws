locals {
  subscription = {
    dynamodb_alarms = aws_sns_topic.dynamodb_alarms.arn
    lambda_alarms   = aws_sns_topic.lambda_alarms.arn
  }
}


resource "aws_sns_topic_subscription" "email" {
  for_each  = local.subscription
  topic_arn = each.value
  protocol  = "email"
  endpoint  = var.email
}