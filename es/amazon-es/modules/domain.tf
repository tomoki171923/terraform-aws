# ********************************* #
# Elasticsearch Domain
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain
# ********************************* #

resource "aws_elasticsearch_domain" "sample" {
  domain_name           = var.domain_name
  elasticsearch_version = "7.10"

  cluster_config {
    dedicated_master_count   = 0
    dedicated_master_enabled = false
    instance_count           = 1
    instance_type            = "t3.medium.elasticsearch"
    warm_enabled             = false
    zone_awareness_enabled   = false # multi az
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  ebs_options {
    ebs_enabled = true
    iops        = 0
    volume_size = 10
    volume_type = "gp2"
  }

  node_to_node_encryption {
    enabled = true
  }

  snapshot_options {
    automated_snapshot_start_hour = 10
  }

  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain_name}/*"
        }
    ]
}
CONFIG

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = true
  }

  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = var.master_user_name
      master_user_password = var.master_user_password
    }
  }

  encrypt_at_rest {
    enabled = true
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}