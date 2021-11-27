resource "aws_cloudwatch_log_group" "ssm_console" {
  name = "/aws/ssm/console"

  tags = {
    Terraform = "true"
  }
}
