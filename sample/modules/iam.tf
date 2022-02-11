# ********************************* #
# IAM role
# ref: https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/examples/iam-assumable-role/main.tf
# ********************************* #

# EC2 instance profile managed by SSM & CloudWatchAgent
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "${module.role_ec2_ssm_managed.iam_role_name}InstanceProfile"
  role = module.role_ec2_ssm_managed.iam_role_name
}


# EC2 instance profile role managed by SSM & CloudWatchAgent
module "role_ec2_ssm_managed" {
  # remote module
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]
  create_role       = true
  role_name         = "${var.base_name}EC2SSMManaged"
  role_description  = "EC2 instance profile role managed by SSM"
  role_requires_mfa = false

  custom_role_policy_arns = [
    data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn,
    data.aws_iam_policy.CloudWatchAgentServerPolicy.arn,
    data.aws_iam_policy.AmazonSSMPatchAssociation.arn,
    module.policy_kms_core.arn,
  ]
}

module "policy_kms_core" {
  # remote module
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "${var.base_name}_kms_core_${data.aws_region.this.name}"
  path        = "/"
  description = "kms keys core permission."

  policy = data.aws_iam_policy_document.kms_core.json
}

/*
    iam policy document
*/
data "aws_iam_policy_document" "kms_core" {
  statement {
    actions = [
      "kms:DescribeKey",
      "kms:ListKeys",
      "kms:ListAliases",
      "kms:ListResourceTags",
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]
    resources = [
      "arn:aws:kms:${data.aws_region.this.name}:${data.aws_caller_identity.this.account_id}:key/*"
    ]
  }
}

/*
  fetch aws default policies
*/
data "aws_iam_policy" "ReadOnlyAccess" {
  name = "ReadOnlyAccess"
}
data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  name = "AmazonSSMManagedInstanceCore"
}
data "aws_iam_policy" "CloudWatchAgentServerPolicy" {
  name = "CloudWatchAgentServerPolicy"
}
data "aws_iam_policy" "AmazonSSMPatchAssociation" {
  name = "AmazonSSMPatchAssociation"
}
