# ********************************* #
# S3 bucket
# ref: https://github.com/terraform-aws-modules/terraform-aws-s3-bucket
# ********************************* #


# private bucket
module "tf-test-private-bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "tf-test-private-bucket"
  acl    = "private"

  versioning = {
    enabled = true
  }

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


# web hosting bucket
module "tf-test-hosting-bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "tf-test-hosting-bucket"
  acl    = "public-read"
  website = {
    index_document = "index.html"
    error_document = "error.html"
  }
  # policy
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "PublicRead",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : [
            "s3:GetObject",
            "s3:GetObjectVersion"
          ],
          "Resource" : [
            "${module.tf-test-hosting-bucket.s3_bucket_arn}",
            "${module.tf-test-hosting-bucket.s3_bucket_arn}/*"
          ]
        }
      ]
    }
  )

  # tag
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


# web hosting bucket via cloudfront 
module "tf-test-hosting-cloudfront-bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "tf-test-hosting-cloudfront-bucket"
  acl    = "public-read"
  website = {
    index_document = "index.html"
    error_document = "error.html"
  }
  # policy
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "PublicRead",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : [
            "s3:GetObject",
            "s3:GetObjectVersion"
          ],
          "Resource" : [
            "${module.tf-test-hosting-bucket.s3_bucket_arn}",
            "${module.tf-test-hosting-bucket.s3_bucket_arn}/*"
          ]
        }
      ]
    }
  )

  # tag
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}