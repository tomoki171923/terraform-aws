output "aws_lb" {
  value = aws_lb.this
}

output "aws_lb_listener" {
  value = aws_lb_listener.this
}

output "aws_lb_listener_rule" {
  value = {
    forward_tg = aws_lb_listener_rule.forward_tg
  }
}

output "aws_ecs_cluster" {
  value = aws_ecs_cluster.this
}

output "aws_ecs_service" {
  value = aws_ecs_service.this
}

output "aws_lb_target_group" {
  value = aws_lb_target_group.this
}

output "aws_ecs_task_definition" {
  value = aws_ecs_task_definition.this
}

output "aws_cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.this
}
