/*
  VPC
*/
resource "aws_vpc" "vpc" {
  cidr_block           = local.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "${local.base_name}-vpc"
    Terraform   = "true"
    Environment = "dev"
  }
}

/*
  subnet
*/
resource "aws_subnet" "public-a" {
  cidr_block        = local.public_subnet_a_cidr
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "${data.aws_region.current.name}a"

  tags = {
    Name        = "${local.base_name}-subent-public-a"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_subnet" "public-c" {
  cidr_block        = local.public_subnet_c_cidr
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "${data.aws_region.current.name}c"

  tags = {
    Name        = "${local.base_name}-subent-public-c"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_subnet" "private-a" {
  cidr_block        = local.private_subnet_a_cidr
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "${data.aws_region.current.name}a"

  tags = {
    Name        = "${local.base_name}-subent-private-a"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_subnet" "private-c" {
  cidr_block        = local.private_subnet_c_cidr
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "${data.aws_region.current.name}c"

  tags = {
    Name        = "${local.base_name}-subent-private-c"
    Terraform   = "true"
    Environment = "dev"
  }
}

/*
  internet gateway
*/
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${local.base_name}-igw"
    Terraform   = "true"
    Environment = "dev"
  }
}

/*
  route table
*/
resource "aws_route" "public-igw" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${local.base_name}-rt-public"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${local.base_name}-rt-private"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_route_table_association" "public-a" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public-a.id
}

resource "aws_route_table_association" "public-c" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public-c.id
}

resource "aws_route_table_association" "private-a" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private-a.id
}

resource "aws_route_table_association" "private-c" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private-c.id
}





/*
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
*/


