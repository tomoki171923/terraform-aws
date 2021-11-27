# ********************************* #
# ECS
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
# ********************************* #

resource "aws_ecs_service" "this" {
  name            = "${var.base_name}_service"
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  cluster         = aws_ecs_cluster.this.name
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }
  platform_version       = "1.4.0"
  enable_execute_command = true

  tags = {
    Name        = "${var.base_name}_service"
    Terraform   = "true"
    Environment = "dev"
  }
}
