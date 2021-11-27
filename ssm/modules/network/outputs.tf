output "security_group" {
  value = {
    public    = aws_security_group.public
    ssm2vpcep = aws_security_group.ssm2vpcep
    ssm2ec2   = aws_security_group.ssm2ec2
  }
}

output "vpc" {
  value = module.vpc
}
