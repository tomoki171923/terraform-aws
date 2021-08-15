output "event" {
  value = {
    hello_world = module.hello_world_event
  }
}


output "alarm" {
  value = {
    hello_world_dev_error = aws_cloudwatch_metric_alarm.lambda_hello_world_dev_error
  }
}
