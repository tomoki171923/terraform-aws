# ********************************* #
# REST API on API Gateway
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission
# ********************************* #

/*
    sample api
*/

resource "aws_api_gateway_rest_api" "sample" {
  name = "sample"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  body = data.template_file.sample-oas30-apigateway.rendered
}

resource "aws_api_gateway_deployment" "sample" {
  rest_api_id = aws_api_gateway_rest_api.sample.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.sample.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "sample_dev" {
  deployment_id = aws_api_gateway_deployment.sample.id
  rest_api_id   = aws_api_gateway_rest_api.sample.id
  stage_name    = var.stage_name.development
}

resource "aws_api_gateway_stage" "sample_st" {
  deployment_id = aws_api_gateway_deployment.sample.id
  rest_api_id   = aws_api_gateway_rest_api.sample.id
  stage_name    = var.stage_name.staging
}

resource "aws_api_gateway_stage" "sample_pro" {
  deployment_id = aws_api_gateway_deployment.sample.id
  rest_api_id   = aws_api_gateway_rest_api.sample.id
  stage_name    = var.stage_name.production
}

resource "aws_lambda_permission" "sample_api_hellow_world_dev" {
  statement_id = "allow_${aws_api_gateway_rest_api.sample.name}API_to_invoke_${data.aws_lambda_function.hello_world.function_name}_${data.aws_lambda_alias.hello_world_dev.name}"
  action       = "lambda:InvokeFunction"
  # TODO:
  function_name = data.aws_lambda_alias.hello_world_dev.arn
  #function_name = "${data.aws_lambda_function.hello_world.function_name}:${aws_api_gateway_stage.sample_dev.stage_name}"
  principal = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  # "arn:aws:execute-api:{self.region}:{self.aws_account}:{api_id}/*/{method}/{func['resource_name']}"
  source_arn = "${aws_api_gateway_rest_api.sample.execution_arn}/*/GET/hello-world"
  depends_on = [
    aws_api_gateway_stage.sample_dev
  ]
}

resource "aws_lambda_permission" "sample_api_hellow_world_st" {
  statement_id  = "allow_${aws_api_gateway_rest_api.sample.name}API_to_invoke_${data.aws_lambda_function.hello_world.function_name}_${data.aws_lambda_alias.hello_world_st.name}"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_alias.hello_world_st.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.sample.execution_arn}/*/GET/hello-world"
  depends_on = [
    aws_api_gateway_stage.sample_st
  ]
}

resource "aws_lambda_permission" "sample_api_hellow_world_pro" {
  statement_id  = "allow_${aws_api_gateway_rest_api.sample.name}API_to_invoke_${data.aws_lambda_function.hello_world.function_name}_${data.aws_lambda_alias.hello_world_pro.name}"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_alias.hello_world_pro.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.sample.execution_arn}/*/GET/hello-world"
  depends_on = [
    aws_api_gateway_stage.sample_pro
  ]
}