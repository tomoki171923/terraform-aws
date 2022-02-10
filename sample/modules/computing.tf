locals {
  ami = "ami-0ef5df6525f1522b3" # amzn2-ami-kernel-5.10-hvm-2.0.20211103.1-arm64-gp2 with ssm agent , cloudwatch agent and collectd.
}

# ********************************* #
# computings
# ********************************* #

module "computing_ec2_single" {
  count     = var.ec2_single == true ? 1 : 0
  source    = "./computing/ec2_single/"
  base_name = var.base_name
  subnet_id = module.vpc.public_subnets[0]
  security_group_ids = [
    aws_security_group.ssm2ec2.id,
    aws_security_group.public.id
  ]
  instance_profile = aws_iam_instance_profile.ssm_instance_profile.name
  instance_ami     = local.ami
  instance_type    = "t4g.nano"
}
