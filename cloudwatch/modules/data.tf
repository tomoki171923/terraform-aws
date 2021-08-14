data "aws_lambda_alias" "hello_world_dev" {
  function_name = "hello_world"
  name          = "dev"
}
