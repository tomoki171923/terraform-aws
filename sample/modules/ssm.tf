resource "aws_ssm_parameter" "this" {
  name  = "AmazonCloudWatchAgent_${var.base_name}"
  type  = "String"
  value = data.template_file.cloudwatchagt_basic.rendered
}

resource "aws_cloudwatch_log_group" "ssm_console" {
  name = "/aws/ssm/console"

  tags = {
    Terraform = "true"
  }
}

data "template_file" "cloudwatchagt_basic" {
  template = file("${path.module}/cloudwatchagent/cloudwatchagt_basic.json")
  vars = {
    instane_name = "SampleSSMInstance"
  }
}
