output "lambda" {
  value = {
    function = module.lambda.function
    layer    = module.lambda.layer
  }
}