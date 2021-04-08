# ********************************* #
# IAM policy
# ref: https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/examples/iam-assumable-role/main.tf
# ********************************* #

/*
module "s3_full_access_iam_policy" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "s3-full-access"
  path        = "/"
  description = "s3-full-access"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
*/