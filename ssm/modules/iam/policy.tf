# ********************************* #
# IAM policy
# ref: https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/examples/iam-assumable-role/main.tf
# ********************************* #

module "policy_ssm_start_session" {
  # remote module
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "ssm_start_session_dev"
  path        = "/"
  description = "ssm start session policy for instances with develop tag."

  policy = data.template_file.ssm_start_session.rendered
}
