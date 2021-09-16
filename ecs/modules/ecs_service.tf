# ********************************* #
# ECS
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
# ********************************* #
/*
resource "aws_ecs_service" "ecs_service" {
  name            = local.ecs_service_name
  task_definition = local.ecs_service_name
  desired_count   = local.desired_task_number
  cluster         = data.terraform_remote_state.platform.outputs.ecs_cluster_name
  launch_type     = "FARGATE"

  network_configuration {
    # subnets           = [data.terraform_remote_state.platform.outputs.ecs_public_subnets]
    subnets           = data.terraform_remote_state.platform.outputs.ecs_public_subnets
    security_groups   = [aws_security_group.app_security_group.id]
    assign_public_ip  = true
  }

  load_balancer {
    container_name   = local.ecs_service_name
    container_port   = local.docker_container_port
    target_group_arn = aws_alb_target_group.ecs_app_target_group.arn
  }
}



resource "aws_alb_target_group" "ecs_app_target_group" {
  name        = "${local.ecs_service_name}-TG"
  port        = local.docker_container_port
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.platform.outputs.vpc_id
  target_type = "ip"

  health_check {
    path                = "/actuator/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = "60"
    timeout             = "30"
    unhealthy_threshold = "3"
    healthy_threshold   = "3"
  }

  tags = {
    Name = "${local.ecs_service_name}-TG"
  }
}

resource "aws_alb_listener_rule" "ecs_alb_listener_rule" {
  listener_arn = data.terraform_remote_state.platform.outputs.ecs_alb_listener_arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ecs_app_target_group.arn
  }

  condition {
    host_header {
      values = ["${lower(local.ecs_service_name)}.${data.terraform_remote_state.platform.outputs.ecs_domain_name}"]
    }
  }
}

resource "aws_cloudwatch_log_group" "springbootapp_log_group" {
  name = "${local.ecs_service_name}-LogGroup"
}

*/