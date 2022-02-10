output "vpc" {
  value = module.vpc
}
output "subnet" {
  value = {
    vpc_endpoint_a = aws_subnet.vpc_endpoint_a
    vpc_endpoint_c = aws_subnet.vpc_endpoint_c
  }
}
