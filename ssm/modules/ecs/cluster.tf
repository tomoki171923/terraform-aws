# ********************************* #
# ECS
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
# ********************************* #

resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    Name        = var.cluster_name
    Terraform   = "true"
    Environment = "dev"
  }
}
