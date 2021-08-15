output "topic" {
  value = {
    dynamodb_alarms = aws_sns_topic.dynamodb_alarms
    lambda_alarms   = aws_sns_topic.lambda_alarms
  }
}

output "topic_subscription" {
  value = {
    email = aws_sns_topic_subscription.email
  }
}