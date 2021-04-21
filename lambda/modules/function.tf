# ********************************* #
# Lambda Function
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lambda_function
# ********************************* #

module "function_hello_world" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "hello_world"
  description   = "hell worlda function"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"

  source_path = "./src/function/hello_world"

  tags = {
    Terraform   = "true"
  }
}