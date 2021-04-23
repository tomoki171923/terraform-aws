data "aws_caller_identity" "this" {}

/*
    reading policy files in json format
*/
data "template_file" "policy_apigateway_read" {
  template = file("${path.module}/policies/apigateway_read.json")
}