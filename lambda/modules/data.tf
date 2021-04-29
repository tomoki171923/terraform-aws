data "aws_iam_role" "LambdaExecute" {
  name = "LambdaExecute"
}

# please comment out to the first time only.
data "aws_lambda_alias" "hello_world_st" {
  function_name = "hello_world"
  name          = "st"
}

# please comment out to the first time only.
data "aws_lambda_alias" "hello_world_pro" {
  function_name = "hello_world"
  name          = "pro"
}
