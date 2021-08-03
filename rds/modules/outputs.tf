output "instance" {
  value = {
    sample-single = aws_instance.sample-single
  }
}


output "alb" {
  value = {
    alb           = aws_lb.alb
    listener      = aws_lb_listener.lb_listener
    listener_rule = aws_lb_listener_rule.lb_listener_rule
    target_group  = aws_lb_target_group.tg
  }
}


output "autoscaling_group" {
  value = {
    launch_configuration = aws_launch_configuration.sample-cluster
    autoscaling_group    = aws_autoscaling_group.asg
    autoscaling_policy   = aws_autoscaling_policy.memory-hot
  }
}
