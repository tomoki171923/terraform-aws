output "log_group" {
  value = {
    ssm_console = aws_cloudwatch_log_group.ssm_console
  }
}
