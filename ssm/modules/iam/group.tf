# ********************************* #
# IAM group
# ref: https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/examples/iam-group-with-policies/main.tf
# ********************************* #

module "iam_group_ssm_members" {
  # remote module
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  name   = "${var.base_name}Group"
  group_users = [
    module.iam_user_ssm_user.iam_user_name,
  ]
  custom_group_policy_arns = [
    data.aws_iam_policy.ReadOnlyAccess.arn,
    module.policy_ssm_start_session.arn
  ]
}
