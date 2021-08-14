output "cloudwatch" {
  value = {
    event = module.cloudwatch.event
  }
}
