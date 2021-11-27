# ********************************* #
# ECS
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
# ********************************* #

resource "aws_ecs_cluster" "this" {
  name = "${var.base_name}_cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    Name        = "${var.base_name}_cluster"
    Terraform   = "true"
    Environment = "dev"
  }
}
