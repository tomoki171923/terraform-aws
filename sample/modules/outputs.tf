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
