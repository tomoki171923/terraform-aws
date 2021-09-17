# ********************************* #
# ECS
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster
# ********************************* #

resource "aws_ecs_cluster" "sample" {
  name = local.ecs_cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    Name        = "${local.ecs_cluster_name}"
    Terraform   = "true"
    Environment = "dev"
  }
}
