output "eplication_group" {
  value = aws_elasticache_replication_group.sample_redis
}

output "subnet_group" {
  value = aws_elasticache_subnet_group.sample_redis
}