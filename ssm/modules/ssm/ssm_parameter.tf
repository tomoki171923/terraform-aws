resource "aws_ssm_parameter" "cloudwatchagt_basic" {
  name  = "cloudwatchagt_basic"
  type  = "String"
  value = file("${path.module}/cloudwatchagent/cloudwatchagt_basic.json")
}
