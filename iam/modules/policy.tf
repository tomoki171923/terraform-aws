# ********************************* #
# IAM policy
# ref: https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/examples/iam-assumable-role/main.tf
# ********************************* #

module "policy_apigateway_read" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "apigateway_read"
  path        = "/"
  description = "apigateway read"

  policy = data.template_file.policy_apigateway_read.rendered
}

