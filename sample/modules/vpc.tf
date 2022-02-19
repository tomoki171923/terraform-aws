/*********************************
  VPC
    ref: https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/examples/complete-vpc/main.tf
    pricing:
      https://aws.amazon.com/jp/vpc/pricing/
*********************************/

module "vpc" {
  // remote module
  source     = "terraform-aws-modules/vpc/aws"
  version    = "3.12.0"
  create_vpc = true
  name       = "${var.base_name}-vpc"
  cidr       = "10.101.0.0/16"

  azs              = ["${data.aws_region.this.name}a", "${data.aws_region.this.name}c"]
  private_subnets  = ["10.101.1.0/24", "10.101.2.0/24"]
  public_subnets   = ["10.101.11.0/24", "10.101.12.0/24"]
  database_subnets = ["10.101.21.0/24", "10.101.22.0/24"]
  enable_ipv6      = false

  // dns
  enable_dns_hostnames = true
  enable_dns_support   = true

  // nat gateway
  enable_nat_gateway     = var.nat_gateway
  single_nat_gateway     = var.nat_gateway
  one_nat_gateway_per_az = false

  // Default security group - ingress/egress rules cleared to deny all
  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []

  // tag
  vpc_tags = {
    Name        = "${var.base_name}-vpc"
    Terraform   = "true"
    Environment = "dev"
  }
  public_subnet_tags = {
    Name        = "${var.base_name}-public-subnet"
    Terraform   = "true"
    Environment = "dev"
  }
  private_subnet_tags = {
    Name        = "${var.base_name}-private-subnet"
    Terraform   = "true"
    Environment = "dev"
  }
  database_subnet_tags = {
    Name        = "${var.base_name}-database-subnet"
    Terraform   = "true"
    Environment = "dev"
  }
}


/*********************************
  vpc endpoint
    ref: https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/examples/complete-vpc/main.tf
         https://github.com/terraform-aws-modules/terraform-aws-vpc/tree/master/modules/vpc-endpoints
    pricing:
      https://aws.amazon.com/jp/privatelink/pricing/
      type: Interface (tokyo)
        0.014USD/hour (Pricing per VPC endpoint) + 0.01 USD/GB (per GB of Data Processed)
      type: Gateway (tokyo)
        0.014USD/hour (Pricing per VPC endpoint) + 0.0035 USD/GB (per GB of Data Processed)
*********************************/

// These subnets are exclusively for vpc endpoints.
resource "aws_subnet" "vpc_endpoint_a" {
  count                                       = var.vpc_endpoints == true ? 1 : 0
  vpc_id                                      = module.vpc.vpc_id
  cidr_block                                  = "10.101.30.0/25"
  availability_zone                           = "${data.aws_region.this.name}a"
  enable_resource_name_dns_a_record_on_launch = true
  tags = {
    Name        = "${var.base_name}-vpc-endpoint-a-subnet"
    Terraform   = "true"
    Environment = "dev"
  }
}
resource "aws_subnet" "vpc_endpoint_c" {
  count                                       = var.vpc_endpoints == true ? 1 : 0
  vpc_id                                      = module.vpc.vpc_id
  cidr_block                                  = "10.101.30.128/25"
  availability_zone                           = "${data.aws_region.this.name}c"
  enable_resource_name_dns_a_record_on_launch = true
  tags = {
    Name        = "${var.base_name}-vpc-endpoint-c-subnet"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_route_table" "s3" {
  count  = var.vpc_endpoints == true ? 1 : 0
  vpc_id = module.vpc.vpc_id

  tags = {
    Name        = "${var.base_name}-s3-endpoint-rt"
    Terraform   = "true"
    Environment = "dev"
  }
}

module "endpoints" {
  count   = var.vpc_endpoints == true ? 1 : 0
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.12.0"

  vpc_id = module.vpc.vpc_id
  // common security group for each endpoint.
  security_group_ids = [
    module.vpc.default_security_group_id,
    aws_security_group.allowTlsFromVpc.id
  ]

  endpoints = {
    // Gatyway type. connected route table.
    // for s3
    s3 = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = [aws_route_table.s3[0].id]
      policy          = data.aws_iam_policy_document.allow_access_ecr_buckets.json
      tags = {
        Name = "${var.base_name}-s3-vpc-endpoint"
      }
    },
    # // for ssm agent
    # ec2messages = {
    #   service             = "ec2messages"
    #   private_dns_enabled = true
    #   subnet_ids          = [aws_subnet.vpc_endpoint_a[0].id, aws_subnet.vpc_endpoint_c[0].id]
    #   tags = {
    #     Name = "${var.base_name}-ec2messages-vpc-endpoint"
    #   }
    # },
    # // for ssm agent
    # ssm = {
    #   service             = "ssm"
    #   private_dns_enabled = true
    #   subnet_ids          = [aws_subnet.vpc_endpoint_a[0].id, aws_subnet.vpc_endpoint_c[0].id]
    #   security_group_ids  = [aws_security_group.allowTlsFromVpc.id]
    #   tags = {
    #     Name = "${var.base_name}-ssm-vpc-endpoint"
    #   }
    # },
    # // for ssm agent
    # ssmmessages = {
    #   service             = "ssmmessages"
    #   private_dns_enabled = true
    #   subnet_ids          = [aws_subnet.vpc_endpoint_a[0].id, aws_subnet.vpc_endpoint_c[0].id]
    #   tags = {
    #     Name = "${var.base_name}-ssmmessages-vpc-endpoint"
    #   }
    # },
    # // for cloudwatch agent
    # ec2 = {
    #   service             = "ec2"
    #   private_dns_enabled = true
    #   subnet_ids          = [aws_subnet.vpc_endpoint_a[0].id, aws_subnet.vpc_endpoint_c[0].id]
    #   tags = {
    #     Name = "${var.base_name}-ec2-vpc-endpoint"
    #   }
    # },
    // for cloudwatch agent
    logs = {
      service             = "logs"
      private_dns_enabled = true
      subnet_ids          = [aws_subnet.vpc_endpoint_a[0].id, aws_subnet.vpc_endpoint_c[0].id]
      tags = {
        Name = "${var.base_name}-logs-vpc-endpoint"
      }
    },
    # // for cloudwatch agent
    # monitoring = {
    #   service             = "monitoring"
    #   private_dns_enabled = true
    #   subnet_ids          = [aws_subnet.vpc_endpoint_a[0].id, aws_subnet.vpc_endpoint_c[0].id]
    #   tags = {
    #     Name = "${var.base_name}-monitoring-vpc-endpoint"
    #   }
    # },
    # // for ecs
    # // https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/vpc-endpoints.html
    # ecs = {
    #   service             = "ecs"
    #   private_dns_enabled = true
    #   subnet_ids          = [aws_subnet.vpc_endpoint_a[0].id, aws_subnet.vpc_endpoint_c[0].id]
    #   tags = {
    #     Name = "${var.base_name}-ecr-vpc-endpoint"
    #   }
    # },
    # // for ecs
    # // https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/vpc-endpoints.html
    # ecs_agent = {
    #   service             = "ecs-agent"
    #   private_dns_enabled = true
    #   subnet_ids          = [aws_subnet.vpc_endpoint_a[0].id, aws_subnet.vpc_endpoint_c[0].id]
    #   tags = {
    #     Name = "${var.base_name}-ecs_agent-vpc-endpoint"
    #   }
    # },
    # // for ecs
    # // https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/vpc-endpoints.html
    # ecs_telemetry = {
    #   service             = "ecs-telemetry"
    #   private_dns_enabled = true
    #   subnet_ids          = [aws_subnet.vpc_endpoint_a[0].id, aws_subnet.vpc_endpoint_c[0].id]
    #   tags = {
    #     Name = "${var.base_name}-ecs_telemetry-vpc-endpoint"
    #   }
    # },
    // for ecs fargate
    // https://docs.aws.amazon.com/ja_jp/AmazonECR/latest/userguide/vpc-endpoints.html
    ecr_api = {
      service             = "ecr.api"
      private_dns_enabled = true
      subnet_ids          = [aws_subnet.vpc_endpoint_a[0].id, aws_subnet.vpc_endpoint_c[0].id]
      security_group_ids = [
        aws_security_group.allowDnsToVpc.id
      ]
      policy = data.aws_iam_policy_document.allow_ecs_actions.json
      tags = {
        Name = "${var.base_name}-ecr_api-vpc-endpoint"
      }
    },
    // for ecs fargate
    // https://docs.aws.amazon.com/ja_jp/AmazonECR/latest/userguide/vpc-endpoints.html
    ecr_dkr = {
      service             = "ecr.dkr"
      private_dns_enabled = true
      subnet_ids          = [aws_subnet.vpc_endpoint_a[0].id, aws_subnet.vpc_endpoint_c[0].id]
      security_group_ids = [
        aws_security_group.allowDnsToVpc.id
      ]
      policy = data.aws_iam_policy_document.allow_ecs_actions.json
      tags = {
        Name = "${var.base_name}-ecr_dkr-vpc-endpoint"
      }
    },
    // for kms
    kms = {
      service             = "kms"
      private_dns_enabled = true
      subnet_ids          = [aws_subnet.vpc_endpoint_a[0].id, aws_subnet.vpc_endpoint_c[0].id]
      tags = {
        Name = "${var.base_name}-kms-vpc-endpoint"
      }
    },
    # // for lambda
    # lambda = {
    #   service             = "lambda"
    #   private_dns_enabled = true
    #   subnet_ids          = [aws_subnet.vpc_endpoint_a[0].id, aws_subnet.vpc_endpoint_c[0].id]
    #   tags = {
    #     Name = "${var.base_name}-lambda-vpc-endpoint"
    #   }
    # },
    // for secretsmanager
    secretsmanager = {
      service             = "secretsmanager"
      private_dns_enabled = true
      subnet_ids          = [aws_subnet.vpc_endpoint_a[0].id, aws_subnet.vpc_endpoint_c[0].id]
      tags = {
        Name = "${var.base_name}-secretsmanager-vpc-endpoint"
      }
    },
  }
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
// allow access to ecr buckets.
// https://aws.amazon.com/jp/premiumsupport/knowledge-center/ecs-ecr-docker-image-error/
data "aws_iam_policy_document" "allow_access_ecr_buckets" {
  statement {
    sid     = "allow-access-to-ecr-bucket-${data.aws_region.this.name}"
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      "arn:aws:s3:::prod-${data.aws_region.this.name}-starport-layer-bucket/*"
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}
// allow access to images on ecr.
// https://docs.aws.amazon.com/ja_jp/AmazonECR/latest/userguide/vpc-endpoints.html#ecr-vpc-endpoint-policy
data "aws_iam_policy_document" "allow_access_ecr_images" {
  statement {
    sid    = "allow-access-to-images-on-ecr-for-${module.iam_role_ecs_task_exec.iam_role_name}"
    effect = "Allow"
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken"
    ]
    resources = [
      "*"
    ]
    principals {
      type        = "AWS"
      identifiers = [module.iam_role_ecs_task_exec.iam_role_arn]
    }
  }
}
// allow actions for ecs.
// https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/vpc-endpoints.html#vpc-endpoint-policy
data "aws_iam_policy_document" "allow_ecs_actions" {
  statement {
    sid    = "allow-ecs-actions"
    effect = "Allow"
    actions = [
      "ecs:*",
    ]
    resources = [
      "*"
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}


/*********************************
  Ecs Fargate networks
  pricing:
    case1. using internet gateway
      0 USD/hour + 0.114 USD/GB (outbound only)
    case2. using vpc-endpoints (6 endpoints)
      0.084 USD/hour + 0.01 USD/GB(s3) + 0.0035 USD/GB(others)
    case3. using natgateway
      0.062 USD/hour + 0.62 USD/GB + 0.114 USD/GB (igw)
*********************************/
// These subnets are exclusively for ecs task.
resource "aws_subnet" "ecs_task_a" {
  vpc_id            = module.vpc.vpc_id
  cidr_block        = "10.101.3.0/24"
  availability_zone = "${data.aws_region.this.name}a"
  tags = {
    Name        = "${var.base_name}-ecs-task-a-subnet"
    Terraform   = "true"
    Environment = "dev"
  }
}
resource "aws_subnet" "ecs_task_c" {
  vpc_id            = module.vpc.vpc_id
  cidr_block        = "10.101.4.0/24"
  availability_zone = "${data.aws_region.this.name}c"
  tags = {
    Name        = "${var.base_name}-ecs-task-c-subnet"
    Terraform   = "true"
    Environment = "dev"
  }
}
// case1. using internet gateway
resource "aws_route_table" "ecs_task_a" {
  count  = var.vpc_endpoints == false ? 1 : 0
  vpc_id = module.vpc.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.vpc.igw_id
  }
  tags = {
    Name        = "${var.base_name}-ecs-task-a-rt"
    Terraform   = "true"
    Environment = "dev"
  }
}
resource "aws_route_table" "ecs_task_c" {
  count  = var.vpc_endpoints == false ? 1 : 0
  vpc_id = module.vpc.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.vpc.igw_id
  }
  tags = {
    Name        = "${var.base_name}-ecs-task-c-rt"
    Terraform   = "true"
    Environment = "dev"
  }
}
resource "aws_route_table_association" "ecs_task_a_igw" {
  count          = var.vpc_endpoints == false ? 1 : 0
  subnet_id      = aws_subnet.ecs_task_a.id
  route_table_id = aws_route_table.ecs_task_a[0].id
}
resource "aws_route_table_association" "ecs_task_c_igw" {
  count          = var.vpc_endpoints == false ? 1 : 0
  subnet_id      = aws_subnet.ecs_task_c.id
  route_table_id = aws_route_table.ecs_task_c[0].id
}

// case2. using vpc-endpoints
// https://aws.amazon.com/jp/premiumsupport/knowledge-center/ecs-pull-container-error/
resource "aws_route_table_association" "s3_ecs_task_a" {
  count          = var.vpc_endpoints == true ? 1 : 0
  subnet_id      = aws_subnet.ecs_task_a.id
  route_table_id = aws_route_table.s3[0].id
}
resource "aws_route_table_association" "s3_ecs_task_c" {
  count          = var.vpc_endpoints == true ? 1 : 0
  subnet_id      = aws_subnet.ecs_task_c.id
  route_table_id = aws_route_table.s3[0].id
}
