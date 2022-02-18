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
    public                     = aws_security_group.public
    web                        = aws_security_group.web
    private                    = aws_security_group.private
    allowTlsFromVpc            = aws_security_group.allowTlsFromVpc
    allowTlsFromEcstaskSubnets = aws_security_group.allowTlsFromEcstaskSubnets
    allowTlsToVpc              = aws_security_group.allowTlsToVpc
    allowTlsToEcstaskSubnets   = aws_security_group.allowTlsToEcstaskSubnets
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

output "iam" {
  value = {
    instance_profile = {
      ssm_instance_profile = aws_iam_instance_profile.ssm_instance_profile
    }
    role = {
      ec2_ssm_managed = module.iam_role_ec2_ssm_managed
      ecs_task_exec   = module.iam_role_ecs_task_exec
      ecs_task        = module.iam_role_ecs_task
    }
    policy = {
      kms_core            = module.iam_policy_kms_core
      secretsmanager_core = module.iam_policy_secretsmanager_core
    }
  }
}
