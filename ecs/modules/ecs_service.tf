# ********************************* #
# ECS
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service
# ********************************* #

resource "aws_ecs_service" "sample" {
  name            = local.ecs_service_name
  task_definition = aws_ecs_task_definition.sample.arn
  desired_count   = local.desired_task_number
  cluster         = aws_ecs_cluster.sample.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.private-a.id, aws_subnet.private-c.id]
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = false
  }

  load_balancer {
    container_name   = local.container_name
    container_port   = local.container_port
    target_group_arn = aws_alb_target_group.tg.arn
  }

  tags = {
    Name        = local.ecs_service_name
    Terraform   = "true"
    Environment = "dev"
  }

  #depends_on = [aws_ecs_task_definition.sample]

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }
}



/*
resource "aws_cloudwatch_log_group" "springbootapp_log_group" {
  name = "${local.ecs_service_name}-LogGroup"
}
*/