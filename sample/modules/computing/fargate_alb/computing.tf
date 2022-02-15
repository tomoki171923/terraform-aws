# ********************************* #
# ECS
# ref:
#   https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster
#   https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service
#   https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition
# ********************************* #
resource "aws_ecs_cluster" "this" {
  name = "${var.base_name}-ecs-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    Name        = "${var.base_name}-ecs-cluster"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_ecs_service" "this" {
  name                               = "${var.base_name}-ecs-service"
  task_definition                    = aws_ecs_task_definition.this.arn
  desired_count                      = 2
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  cluster                            = aws_ecs_cluster.this.name
  launch_type                        = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids_computing
    security_groups  = var.security_group_ids_computing
    assign_public_ip = false
  }

  load_balancer {
    container_name   = var.container_name
    container_port   = var.container_port
    target_group_arn = aws_lb_target_group.this.arn
  }


  platform_version       = "1.4.0"
  enable_execute_command = false
  wait_for_steady_state  = true

  tags = {
    Name        = "${var.base_name}-ecs-service"
    Terraform   = "true"
    Environment = "dev"
  }
}

# target group
resource "aws_lb_target_group" "this" {
  # AWSロードバランサにおけるターゲットグループがリスナーとしてロードバランサに登録されていると、 一度リスナー登録を削除しない限りターゲットグループを削除できない。
  # そのためcreate_before_destroyをtureにして、再作成時にdestroy前の名前と被らないようにnameをuniqにしている。
  name        = "${var.base_name}-alb-tg-fargate-${substr(uuid(), 0, 4)}"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 29
    unhealthy_threshold = 2
  }
  lifecycle {
    create_before_destroy = true
  }
  # deregistration_delay = 60
}

resource "aws_ecs_task_definition" "this" {
  container_definitions    = data.template_file.task_definition.rendered
  family                   = "${var.base_name}-ecs-service"
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

data "template_file" "task_definition" {
  template = file("${path.module}/task_definition.json.tmp")

  vars = {
    ecs_cluster_name = "${var.base_name}-ecs-cluster"
    ecs_service_name = "${var.base_name}-ecs-service"
    docker_image_url = "${var.aws_ecr_repository_url}:web_1"
    container_name   = var.container_name
    container_port   = var.container_port
    region           = var.aws_region
  }
}
