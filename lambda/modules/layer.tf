# ********************************* #
# Lambda Layer
# ref: https://github.com/terraform-aws-modules/terraform-aws-lambda
# ********************************* #

module "layer_base" {
  source = "terraform-aws-modules/lambda/aws"

  create_layer = true

  layer_name          = "base"
  description         = "these layers have base functions of python"
  compatible_runtimes = ["python3.8"]

  source_path = [
    {
      path             = "${path.module}/../src/layer/base",
      pip_requirements = false,
      prefix_in_zip    = "python/src/layer/base",
    }
  ]
}
