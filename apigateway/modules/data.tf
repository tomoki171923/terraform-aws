data "aws_caller_identity" "this" {}

/*
    Existing Lambda functions
*/
data "aws_lambda_function" "hello_world" {
  function_name = "hello_world"
}
data "aws_lambda_alias" "hello_world_dev" {
  function_name = "hello_world"
  name          = "dev"
}
data "aws_lambda_alias" "hello_world_st" {
  function_name = "hello_world"
  name          = "st"
}
data "aws_lambda_alias" "hello_world_pro" {
  function_name = "hello_world"
  name          = "pro"
}

/*
    Existing Rest API on API Gateway
*/
#data "aws_api_gateway_rest_api" "sample" {
#  name = "sample"
#}

/*
    Reading Open API files in yaml format
*/
data "template_file" "sample-oas30-apigateway" {
  template = file("${path.module}/oas30/sample-oas30-apigateway.yaml")

  vars = {
    integration_url = "arn:aws:apigateway:ap-northeast-1:lambda:path/2015-03-31/functions/${data.aws_lambda_function.hello_world.arn}:$${stageVariables.alias}/invocations"
  }
}