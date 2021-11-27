# ********************************* #
# IAM user
# ref: https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/examples/iam-group-with-policies/main.tf
# ********************************* #

module "iam_user_ssm_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name = "${var.base_name}User"

  create_iam_user_login_profile = false
  create_iam_access_key         = true
}
