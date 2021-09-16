resource "aws_iam_policy" "KinesisFirehoseServicePolicy" {
  name        = "KinesisFirehoseServicePolicy"
  path        = "/service-role/"
  description = "Kinesis Firehose Service Policy"
  policy      = data.template_file.policy.rendered
}
