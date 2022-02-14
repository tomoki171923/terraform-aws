output "vpc" {
  value = module.vpc
}
output "subnet" {
  value = {
    vpc_endpoint_a = aws_subnet.vpc_endpoint_a
    vpc_endpoint_c = aws_subnet.vpc_endpoint_c
  }
}
output "security_group" {
  value = {
    public    = aws_security_group.public
    web       = aws_security_group.web
    private   = aws_security_group.private
    ssm2vpcep = aws_security_group.ssm2vpcep
    ssm2ec2   = aws_security_group.ssm2ec2
  }
}
output "computing" {
  value = {
    ec2_single  = module.computing_ec2_single
    ec2_alb     = module.computing_ec2_alb
    ec2_clb     = module.computing_ec2_clb
    fargate_alb = module.computing_fargate_alb
  }
}

output "ecr" {
  value = {
    repository       = aws_ecr_repository.this
    lifecycle_policy = aws_ecr_lifecycle_policy.this
  }
}
