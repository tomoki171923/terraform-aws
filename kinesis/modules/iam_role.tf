# ********************************* #
# IAM role
# ref: https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/examples/iam-assumable-role/main.tf
# ********************************* #

module "KinesisFirehoseServiceRole" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_services = [
    "firehose.amazonaws.com"
  ]
  create_role       = true
  role_name         = "KinesisFirehoseServiceRole"
  role_description  = "Kinesis Firehose Service Role"
  role_requires_mfa = false

  custom_role_policy_arns = [
    aws_iam_policy.KinesisFirehoseServicePolicy.arn
  ]
}
