# ********************************* #
# vpc endpoint
# ref: https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/examples/complete-vpc/main.tf
# ********************************* #

module "endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [aws_security_group.ssm2vpcep.id]

  endpoints = {
    // for ssm agent
    ec2messages = {
      service             = "ec2messages"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = { Name = "ec2messages-vpc-endpoint" }
    },
    // for ssm agent
    ssm = {
      service             = "ssm"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = { Name = "ssm-vpc-endpoint" }
    },
    // for ssm agent
    ssmmessages = {
      service             = "ssmmessages"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = { Name = "ssmmessages-vpc-endpoint" }
    },
    // for cloudwatch agent
    ec2 = {
      service             = "ec2"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = { Name = "ec2-vpc-endpoint" }
    },
    // for cloudwatch agent
    logs = {
      service             = "logs"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = { Name = "logs-vpc-endpoint" }
    },
    // for cloudwatch agent
    monitoring = {
      service             = "monitoring"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = { Name = "monitoring-vpc-endpoint" }
    },
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
