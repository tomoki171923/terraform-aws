output "api_key" {
  value = {
    sample_dev = aws_api_gateway_api_key.sample_dev
    sample_pro = aws_api_gateway_api_key.sample_pro
  }
}
