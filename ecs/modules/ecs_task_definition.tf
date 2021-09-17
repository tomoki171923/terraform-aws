# ********************************* #
# ECS
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition
# ********************************* #

# Supported task CPU and memory values for tasks that are hosted on Fargate are as follows.
# https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/task-cpu-memory-error.html
# task_definition will be overridden when deploying application.
resource "aws_ecs_task_definition" "sample" {
  container_definitions    = data.template_file.task_definition.rendered
  family                   = local.ecs_service_name
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.fargate.arn
  task_role_arn            = aws_iam_role.fargate.arn
  lifecycle {
    ignore_changes = [
      container_definitions,
      family,
      cpu,
      memory
    ]
  }
}