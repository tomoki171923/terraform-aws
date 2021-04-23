data "aws_api_gateway_rest_api" "sample" {
  name = "sample"
}



/*
    reading Open API files in yaml format
*/
#data "template_file" "sample-dev-oas30-apigateway" {
#  template = file("${path.module}/oas30/sample-dev-oas30-apigateway.yaml")
#}