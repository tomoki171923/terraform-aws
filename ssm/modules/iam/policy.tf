# ********************************* #
# IAM policy
# ref: https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/examples/iam-assumable-role/main.tf
# ********************************* #

module "policy_ssm_start_session" {
  # remote module
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "${var.base_name}_ssm_start_session_dev"
  path        = "/"
  description = "ssm start session policy for instances with develop tag."

  policy = data.template_file.ssm_start_session.rendered
}

module "policy_kms_core" {
  # remote module
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "${var.base_name}_kms_core_${data.aws_region.this.name}"
  path        = "/"
  description = "kms keys core permission."

  policy = data.template_file.kms_core.rendered
}
