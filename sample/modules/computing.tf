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
}

# ********************************* #
# computings
# ********************************* #

module "computing_ec2_single" {
  count     = var.ec2_single == true ? 1 : 0
  source    = "./computing/ec2_single/"
  subnet_id = module.vpc.public_subnets[0]
  security_group_ids = [
    aws_security_group.tls2vpc.id,
    aws_security_group.public.id
  ]
  instance_name    = "${var.base_name}-single-instance"
  instance_profile = aws_iam_instance_profile.ssm_instance_profile.name
  instance_ami     = local.amis.nginx
  instance_type    = "t4g.nano"
}

module "computing_ec2_alb" {
  count                 = var.ec2_alb == true ? 1 : 0
  source                = "./computing/ec2_alb/"
  base_name             = var.base_name
  vpc_id                = module.vpc.vpc_id
  subnet_ids_lb         = module.vpc.public_subnets
  subnet_ids_computing  = module.vpc.private_subnets
  security_group_ids_lb = [aws_security_group.web.id]
  security_group_ids_computing = [
    aws_security_group.tls2vpc.id,
    aws_security_group.private.id
  ]
  instance_profile = aws_iam_instance_profile.ssm_instance_profile.name
  instance_ami     = local.amis.nginx
  instance_type    = "t4g.nano"
}

module "computing_ec2_clb" {
  count                 = var.ec2_clb == true ? 1 : 0
  source                = "./computing/ec2_clb/"
  base_name             = var.base_name
  subnet_ids_lb         = module.vpc.public_subnets
  subnet_ids_computing  = module.vpc.private_subnets
  security_group_ids_lb = [aws_security_group.web.id]
  security_group_ids_computing = [
    aws_security_group.tls2vpc.id,
    aws_security_group.private.id
  ]
  instance_profile = aws_iam_instance_profile.ssm_instance_profile.name
  instance_ami     = local.amis.nginx
  instance_type    = "t4g.nano"
}

module "computing_fargate_alb" {
  count         = var.fargate_alb == true ? 1 : 0
  source        = "./computing/fargate_alb/"
  base_name     = var.base_name
  vpc_id        = module.vpc.vpc_id
  subnet_ids_lb = module.vpc.public_subnets
  subnet_ids_computing = [
    aws_subnet.ecs_task_a.id,
    aws_subnet.ecs_task_c.id
  ]
  security_group_ids_lb = [aws_security_group.web.id]
  security_group_ids_computing = [
    aws_security_group.tls2vpc.id,
    aws_security_group.private.id
  ]
  aws_ecr_repository_url = aws_ecr_repository.this.repository_url
  aws_region             = data.aws_region.this.name
  execution_role_arn     = module.iam_role_ecs_task_exec.iam_role_arn
  task_role_arn          = module.iam_role_ecs_task.iam_role_arn
  container_name         = var.base_name
  container_port         = 80
}
