output "vpc" {
  value = module.vpc
}
output "subnet" {
  value = {
    vpc_endpoint_a = aws_subnet.vpc_endpoint_a
    vpc_endpoint_c = aws_subnet.vpc_endpoint_c
    ecs_task_a     = aws_subnet.ecs_task_a
    ecs_task_c     = aws_subnet.ecs_task_c
  }
}
output "endpoints" {
  value = module.endpoints
}

output "security_group" {
  value = {
    public           = aws_security_group.public
    web              = aws_security_group.web
    private          = aws_security_group.private
    vpc2tls          = aws_security_group.vpc2tls
    sub_privates2tls = aws_security_group.sub_privates2tls
    tls2vpc          = aws_security_group.tls2vpc
    tls2sub_privates = aws_security_group.tls2sub_privates
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
