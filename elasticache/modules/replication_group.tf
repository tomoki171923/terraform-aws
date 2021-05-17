# ********************************* #
# Replication Group
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group
#      https://aws.amazon.com/elasticache/pricing/
# ********************************* #

locals {
  node_type = "cache.m6g.large"
}

resource "aws_elasticache_replication_group" "sample_redis" {
  replication_group_id          = "sample-redis"
  replication_group_description = "sample redis"
  node_type                     = local.node_type
  number_cache_clusters         = 2
  automatic_failover_enabled    = true
  engine                        = "redis"
  engine_version                = "6.x"
  parameter_group_name          = "default.redis6.x"
  snapshot_retention_limit      = 1
  port                          = 6379
  subnet_group_name             = aws_elasticache_subnet_group.sample_redis.name
  security_group_ids            = [data.terraform_remote_state.vpc.outputs.vpc.security_group.redis.id]

}