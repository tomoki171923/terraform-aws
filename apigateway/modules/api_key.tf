# ********************************* #
# API Keys on API Gateway
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_api_key
# ********************************* #


/*
    Sample API Key for development
*/

resource "aws_api_gateway_api_key" "sample_dev" {
  name = "${aws_api_gateway_rest_api.sample.name}-${var.stage_name.development}-key"
}

resource "aws_api_gateway_usage_plan_key" "sample_dev" {
  key_id        = aws_api_gateway_api_key.sample_dev.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.sample_free.id
  depends_on = [
    aws_api_gateway_api_key.sample_dev,
    aws_api_gateway_usage_plan.sample_free
  ]
}

/*
    Sample API Key for production
*/

resource "aws_api_gateway_api_key" "sample_pro" {
  name = "${aws_api_gateway_rest_api.sample.name}-${var.stage_name.production}-key"
}

resource "aws_api_gateway_usage_plan_key" "sample_pro" {
  key_id        = aws_api_gateway_api_key.sample_pro.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.sample_basic.id
  depends_on = [
    aws_api_gateway_api_key.sample_pro,
    aws_api_gateway_usage_plan.sample_basic
  ]
}