# ********************************* #
# CloudWatch Event
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule
#    : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target
# ********************************* #

locals {
  event_date = "14"
  event = {
    hello_world = {
      schedule_expression = "cron(0 0 ${local.event_date} * ? *)" # AM 9:00(JST)
    }
  }
}



module "hello_world_event" {
  for_each            = local.event
  source              = "git::https://github.com/tomoki171923/terraform-cloudwatch-event.git"
  name                = "${data.aws_lambda_alias.hello_world_dev.function_name}_${each.key}"
  description         = "Invoking lambda ${data.aws_lambda_alias.hello_world_dev.function_name} function"
  schedule_expression = each.value.schedule_expression
  tags = {
    Terraform    = "true"
  }
  input                = <<DOC
{
}
  DOC
  lambda_alias_arn     = data.aws_lambda_alias.hello_world_dev.arn
  lambda_alias_name    = data.aws_lambda_alias.hello_world_dev.name
  lambda_function_name = data.aws_lambda_alias.hello_world_dev.function_name
}