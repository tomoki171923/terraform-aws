output "api_key" {
  value = {
    sample_dev = aws_api_gateway_api_key.sample_dev
    sample_pro = aws_api_gateway_api_key.sample_pro
  }
}

output "sample_api" {
  value = {
    rest_api   = aws_api_gateway_rest_api.sample
    deployment = aws_api_gateway_deployment.sample
    stages = {
      dev = aws_api_gateway_stage.sample_dev
      st  = aws_api_gateway_stage.sample_st
      pro = aws_api_gateway_stage.sample_pro
    }
  }
}