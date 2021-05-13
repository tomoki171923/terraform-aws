output "security_group" {
  value = {
    public  = aws_security_group.public
    private = aws_security_group.private
  }
}

output "vpc" {
  value = module.vpc
}