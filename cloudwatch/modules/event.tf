# ********************************* #
# CloudWatch Event
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule
#    : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target
# ********************************* #


module "hello_world_event" {
  for_each            = local.event
  source              = "git::https://github.com/tomoki171923/terraform-cloudwatch-event.git"
  name                = "${local.lambda_function_name}_${each.key}"
  description         = "Invoking lambda ${local.lambda_function_name} function"
  schedule_expression = each.value.schedule_expression
  tags = {
    Terraform = "true"
  }
  input                = <<DOC
{
}
  DOC
  lambda_alias_arn     = local.lambda_alias_arn
  lambda_alias_name    = local.lambda_alias_name
  lambda_function_name = local.lambda_function_name
}