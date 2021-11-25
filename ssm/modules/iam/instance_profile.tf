resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "${module.role_ec2_ssm_managed.iam_role_name}InstanceProfile"
  role = module.role_ec2_ssm_managed.iam_role_name
}
