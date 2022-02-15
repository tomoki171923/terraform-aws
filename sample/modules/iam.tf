# ********************************* #
# IAM role
# ref: https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/examples/iam-assumable-role/main.tf
# ********************************* #


/****************************
  EC2 IAM Role
****************************/

# EC2 instance profile managed by SSM & CloudWatchAgent
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "${module.iam_role_ec2_ssm_managed.iam_role_name}InstanceProfile"
  role = module.iam_role_ec2_ssm_managed.iam_role_name
}

# EC2 instance profile role managed by SSM & CloudWatchAgent
module "iam_role_ec2_ssm_managed" {
  # remote module
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "4.11.0"

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]
  create_role       = true
  role_name         = "EC2SSMManaged${var.base_name}"
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
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "4.11.0"

  name        = "kms_core_${var.base_name}_${data.aws_region.this.name}"
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


/****************************
  ECS IAM Role
****************************/

# for a ECS container agent.
module "iam_role_ecs_task_exec" {
  # remote module
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "4.11.0"

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]
  create_role       = true
  role_name         = "ECSTaskExecRole_${var.base_name}"
  role_description  = "IAM role for a ECS container agent"
  role_requires_mfa = false

  custom_role_policy_arns = [
    data.aws_iam_policy.AmazonECSTaskExecutionRolePolicy.arn,
  ]
}

# for container on ECS.
module "iam_role_ecs_task" {
  # remote module
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "4.11.0"

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]
  create_role       = true
  role_name         = "ECSTaskRole_${var.base_name}"
  role_description  = "IAM role for a container on ECS"
  role_requires_mfa = false

  custom_role_policy_arns = [
    data.aws_iam_policy.AmazonS3FullAccess.arn,
  ]
}

data "aws_iam_policy" "AmazonECSTaskExecutionRolePolicy" {
  name = "AmazonECSTaskExecutionRolePolicy"
}
data "aws_iam_policy" "AmazonS3FullAccess" {
  name = "AmazonS3FullAccess"
}
