output "security_group" {
  value = {
    public   = aws_security_group.public
    private  = aws_security_group.private
    web      = aws_security_group.web
    redis    = aws_security_group.redis
    postgres = aws_security_group.postgres
  }
}

output "vpc" {
  value = module.vpc
}

output "endpoint" {
  value = module.endpoints
}
