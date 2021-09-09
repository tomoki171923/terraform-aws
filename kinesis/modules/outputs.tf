output "firehose" {
  value = {
    delivery_stream = aws_kinesis_firehose_delivery_stream.dist_es
  }
}

output "iam" {
  value = {
    policy = aws_iam_policy.KinesisFirehoseServicePolicy
    role   = module.KinesisFirehoseServiceRole
  }
}
