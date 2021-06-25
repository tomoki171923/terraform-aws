resource "aws_vpc" "ecs-test-vpc" {
  cidr_block           = local.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "${local.base_name}-vpc"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_subnet" "public-subnet-1" {
  cidr_block        = local.public_subnet_1_cidr
  vpc_id            = aws_vpc.ecs-test-vpc.id
  availability_zone = "${local.region}a"

  tags = {
    Name        = "${local.base_name}-public-1"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_subnet" "public-subnet-2" {
  cidr_block        = local.public_subnet_2_cidr
  vpc_id            = aws_vpc.ecs-test-vpc.id
  availability_zone = "${local.region}c"

  tags = {
    Name        = "${local.base_name}-public-2"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_subnet" "private-subnet-1" {
  cidr_block        = local.private_subnet_1_cidr
  vpc_id            = aws_vpc.ecs-test-vpc.id
  availability_zone = "${local.region}a"

  tags = {
    Name        = "${local.base_name}-private-1"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_subnet" "private-subnet-2" {
  cidr_block        = local.private_subnet_2_cidr
  vpc_id            = aws_vpc.ecs-test-vpc.id
  availability_zone = "${local.region}c"

  tags = {
    Name        = "${local.base_name}-private-2"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.ecs-test-vpc.id
  tags = {
    Name        = "${local.base_name}-public-rt"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.ecs-test-vpc.id
  tags = {
    Name        = "${local.base_name}-private-rt"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_route_table_association" "public-route-1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-1.id
}

resource "aws_route_table_association" "public-route-2-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-2.id
}

resource "aws_route_table_association" "private-route-1-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet-1.id
}

resource "aws_route_table_association" "private-route-2-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet-2.id
}

resource "aws_eip" "elastic-ip-for-nat-gw" {
  vpc                       = true
  associate_with_private_ip = "10.0.0.5"

  tags = {
    Name        = "${local.base_name}-eip"
    Terraform   = "true"
    Environment = "dev"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.elastic-ip-for-nat-gw.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name        = "${local.base_name}-natgw"
    Terraform   = "true"
    Environment = "dev"
  }

  depends_on = [aws_eip.elastic-ip-for-nat-gw]
}

resource "aws_route" "nat-gw-route" {
  route_table_id         = aws_route_table.private-route-table.id
  nat_gateway_id         = aws_nat_gateway.nat-gw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ecs-test-vpc.id
  tags = {
    Name        = "${local.base_name}-igw"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_route" "public-internet-igw-route" {
  route_table_id         = aws_route_table.public-route-table.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}
