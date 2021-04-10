# ********************************* #
# IAM user
# ref: https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/examples/iam-group-with-policies/main.tf
# ********************************* #

module "iam_user_admin" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name = "Admin"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}