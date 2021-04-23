# ********************************* #
# REST API on API Gateway
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage
# ********************************* #
/*

resource "aws_api_gateway_rest_api" "sample" {
  name = var.api_name.sample
  body = data.template_file.sample-dev-oas30-apigateway.rendered
}

resource "aws_api_gateway_rest_api" "${var.api_name.sample}" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "example"
      version = "1.0"
    }
    paths = {
      "/path1" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })

  name = "example"
}
*/

#resource "aws_lambda_permission" "lambda_permission" {
#  statement_id  = "Allow_hello_world_MyDemoAPIInvoke"
#  action        = "lambda:InvokeFunction"
#  function_name = "hello_world"
#  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
#  source_arn = "${aws_api_gateway_rest_api.sample.execution_arn}/*/*/*"
#}

/*
aws lambda add-permission  --function-name '{function_name}'  --source-arn '{source_arn}'  --principal apigateway.amazonaws.com  --statement-id {statement_id}  --action lambda:InvokeFunction  --output yaml"

resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.example.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "development" {
  deployment_id = aws_api_gateway_deployment.example.id
  rest_api_id   = aws_api_gateway_rest_api.example.id
  stage_name    = "development"
}

resource "aws_api_gateway_stage" "production" {
  deployment_id = aws_api_gateway_deployment.example.id
  rest_api_id   = aws_api_gateway_rest_api.example.id
  stage_name    = "production"
}

*/