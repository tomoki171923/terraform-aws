# ********************************* #
# Subnet Group
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group
# ********************************* #


resource "aws_elasticache_subnet_group" "sample_redis" {
  name       = "sample-redis-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.vpc.vpc.elasticache_subnets
}
