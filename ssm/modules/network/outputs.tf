output "security_group" {
  value = {
    public = aws_security_group.public
    ssm    = aws_security_group.ssm
  }
}

output "vpc" {
  value = module.vpc
}
