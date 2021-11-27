resource "aws_ssm_parameter" "cloudwatchagt_basic" {
  name  = "cloudwatchagt_basic"
  type  = "String"
  value = data.template_file.cloudwatchagt_basic.rendered
}
