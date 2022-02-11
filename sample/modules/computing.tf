locals {
  amis = {
    /*
        Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type (64-bit Arm)
        amazon/amzn2-ami-kernel-5.10-hvm-2.0.20220207.1-arm64-gp2
    */
    arm64 = "ami-050a677a0dbb257ab"
    /*
        base image is ami-050a677a0dbb257ab.
        amzn2-ami-kernel-5.10-hvm-2.0.20220207.1-arm64-gp2 with ssm agent, cloudwatch agent and collectd.
        setted CloudWatch Agent and Collectd
            Ref : https://github.com/tomoki171923/terraform-aws/tree/main/ssm
    */
    basic = "ami-08891275749e41efa"
    /*
        base image is ami-050a677a0dbb257ab.
        amzn2-ami-kernel-5.10-hvm-2.0.20220207.1-arm64-gp2 with ssm agent , cloudwatch agent, collectd, and nginx1.
        installed Nginx:
            sudo amazon-linux-extras install nginx1 -y
            sudo systemctl start nginx
            sudo systemctl enable nginx
    */
    nginx = "ami-0355105f8bbad21c2"
  }

  instance_names = {
    ec2_single = var.ec2_single == true ? "${var.base_name}-single-instance" : null
    ec2_alb    = var.ec2_alb == true ? "${var.base_name}-alb-instance" : null
    ec2_clb    = var.ec2_clb == true ? "${var.base_name}-clb-instance" : null
  }

}

# ********************************* #
# computings
# ********************************* #

module "computing_ec2_single" {
  count     = var.ec2_single == true ? 1 : 0
  source    = "./computing/ec2_single/"
  subnet_id = module.vpc.public_subnets[0]
  security_group_ids = [
    aws_security_group.ssm2ec2.id,
    aws_security_group.public.id
  ]
  instance_name    = local.instance_names.ec2_single
  instance_profile = aws_iam_instance_profile.ssm_instance_profile.name
  instance_ami     = local.amis.nginx
  instance_type    = "t4g.nano"
}
