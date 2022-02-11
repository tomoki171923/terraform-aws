output "aws_launch_configuration" {
  value = aws_launch_configuration.this
}

output "aws_autoscaling_group" {
  value = aws_autoscaling_group.this
}

output "aws_lb_target_group" {
  value = aws_lb_target_group.this
}

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
