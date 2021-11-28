# ********************************* #
# IAM role
# ref: https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/examples/iam-assumable-role/main.tf
# ********************************* #

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

# for a ECS container agent
module "role_task_exec_role" {
  # remote module
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]
  create_role       = true
  role_name         = "${var.base_name}ECSTaskExecRole"
  role_description  = "IAM role for a ECS container agent"
  role_requires_mfa = false

  custom_role_policy_arns = [
    data.aws_iam_policy.AmazonECSTaskExecutionRolePolicy.arn,
  ]
}

# for container on ECS
module "role_task_role" {
  # remote module
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]
  create_role       = true
  role_name         = "${var.base_name}ECSTaskRole"
  role_description  = "IAM role for a container on ECS"
  role_requires_mfa = false

  custom_role_policy_arns = [
    data.aws_iam_policy.AmazonS3FullAccess.arn,
  ]
}
