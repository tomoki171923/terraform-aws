
output "_alb" {
  value = {
    alb = aws_alb.ecs_cluster
    isteners = {
      http  = aws_alb_listener.http
      https = aws_alb_listener.https
    }
    target_group = aws_alb_target_group.tg
  }
}

output "_vpc" {
  value = {
    vpc = aws_vpc.vpc
    subents = {
      public-a  = aws_subnet.public-a
      public-c  = aws_subnet.public-c
      private-a = aws_subnet.private-a
      private-c = aws_subnet.private-c
    }
    igw = aws_internet_gateway.igw
    routes = {
      public-igw            = aws_route.public-igw
      table_public          = aws_route_table.public
      table_private         = aws_route_table.private
      association-public-a  = aws_route_table_association.public-a
      association-public-c  = aws_route_table_association.public-c
      association-private-a = aws_route_table_association.private-a
      association-private-c = aws_route_table_association.private-c
    }
  }
}


output "_security_group" {
  value = {
    ecs_cluster = aws_security_group.ecs_cluster
    ecs_alb     = aws_security_group.ecs_alb
    ecs_service = aws_security_group.ecs_service
  }
}


output "_iam" {
  value = {
    ecs_cluster = {
      role   = aws_iam_role.ecs_cluster
      policy = aws_iam_role_policy.ecs_cluster
    }
    ecs_service = {
      role   = aws_iam_role.ecs_service
      policy = aws_iam_role_policy.ecs_service
    }
  }
}