output "firehose" {
  value = {
    delivery_stream = aws_kinesis_firehose_delivery_stream.dist_es
  }
}
