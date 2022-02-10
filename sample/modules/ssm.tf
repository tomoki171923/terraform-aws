resource "aws_ssm_parameter" "this" {
  name  = "AmazonCloudWatchAgent_${var.base_name}"
  type  = "String"
  value = data.template_file.cloudwatchagt_basic.rendered
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_cloudwatch_log_group" "ssm_console" {
  name              = "/aws/ssm/console"
  retention_in_days = 30
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

data "template_file" "cloudwatchagt_basic" {
  template = file("${path.module}/cloudwatchagent/cloudwatchagt_basic.json")
  vars = {
    instane_name = "${var.base_name}"
  }
}
