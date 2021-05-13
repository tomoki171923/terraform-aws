# ami Ubuntu Server 20.04 LTS (64-bit Arm)
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  }

  owners = ["099720109477"] # Canonical
}


# vpc
data "aws_vpc" "sample" {
  tags = {
    Name = "sample-vpc"
  }
}


# subnet
/*
data "aws_subnet" "sample-public-subnet" {
  filter {
    name   = "tag:Name"
    values = ["sample-public-subnet"]
  }
}
data "aws_subnet" "sample-private-subnet" {
  filter {
    name   = "tag:Name"
    values = ["sample-private-subnet"]
  }
}
*/
data "aws_subnet_ids" "sample-public-subnet" {
  vpc_id = data.aws_vpc.sample.id
  tags = {
    Name = "sample-public-subnet"
  }
}

data "aws_subnet_ids" "sample-private-subnet" {
  vpc_id = data.aws_vpc.sample.id
  tags = {
    Name = "sample-private-subnet"
  }
}


# security group
data "aws_security_groups" "sample-public-sg" {
  tags = {
    Name = "sample-public-sg"
  }
}
data "aws_security_groups" "sample-private-sg" {
  tags = {
    Name = "sample-private-sg"
  }
}

