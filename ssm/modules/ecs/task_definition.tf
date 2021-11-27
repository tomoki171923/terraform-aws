resource "aws_ecs_task_definition" "this" {
  container_definitions    = data.template_file.task_definition.rendered
  family                   = var.task_name
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  lifecycle {
    ignore_changes = [
      container_definitions,
      family,
      cpu,
      memory
    ]
  }
}
