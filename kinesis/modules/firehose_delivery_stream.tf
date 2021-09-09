# ********************************* #
# Kinesis Firehose Delivery Stream
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream
# ********************************* #

resource "aws_kinesis_firehose_delivery_stream" "dist_es" {
  for_each = local.dev

  name        = "deliver_${each.key}_to_es"
  destination = "elasticsearch"
  tags = {
    Name        = "deliver_${each.key}_to_es"
    Terraform   = "true"
    Environment = "env"
  }

  elasticsearch_configuration {
    domain_arn            = local.es_state.aa              #TODO: 
    role_arn              = aws_iam_role.firehose_role.arn #TODO: 
    index_name            = each.value.index_name
    buffering_interval    = each.value.buffer_interval
    buffering_size        = each.value.buffer_size
    index_rotation_period = "OneDay"
    retry_duration        = each.value.retry_duration
    s3_backup_mode        = "FailedDataOnly"
    cloudwatch_logging_options {
      enabled = false
    }
  }

  s3_configuration {
    role_arn           = aws_iam_role.firehose.arn #TODO: 
    bucket_arn         = local.s3_state.bucket.tf-test-private-bucket.s3_bucket_arn
    prefix             = "firehose/${each.value.index_name}/"
    buffer_size        = each.value.buffer_size
    buffer_interval    = each.value.buffer_interval
    compression_format = "GZIP"
  }
}