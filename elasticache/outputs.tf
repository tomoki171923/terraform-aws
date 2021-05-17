output "elasticache" {
  value = {
    eplication_group = module.elasticache.eplication_group
    subnet_group     = module.elasticache.subnet_group

  }
}
