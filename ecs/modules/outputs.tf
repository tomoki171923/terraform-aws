
output "_vpc" {
  value = {
    ecs-test-vpc                = aws_vpc.ecs-test-vpc
    public-subnet-1             = aws_subnet.public-subnet-1
    public-subnet-2             = aws_subnet.public-subnet-2
    private-subnet-1            = aws_subnet.private-subnet-1
    private-subnet-2            = aws_subnet.private-subnet-2
    public-route-table          = aws_route_table.public-route-table
    private-route-table         = aws_route_table.private-route-table
    public-route-1-association  = aws_route_table_association.public-route-1-association
    public-route-2-association  = aws_route_table_association.public-route-2-association
    private-route-1-association = aws_route_table_association.private-route-1-association
    private-route-2-association = aws_route_table_association.private-route-2-association
    elastic-ip-for-nat-gw       = aws_eip.elastic-ip-for-nat-gw
    nat-gw                      = aws_nat_gateway.nat-gw
    nat-gw-route                = aws_route.nat-gw-route
    igw                         = aws_internet_gateway.igw
    public-internet-igw-route   = aws_route.public-internet-igw-route

  }
}


output "_security_group" {
  value = {
    ecs_security_group     = aws_security_group.ecs_security_group
    ecs_alb_security_group = aws_security_group.ecs_alb_security_group
  }
}