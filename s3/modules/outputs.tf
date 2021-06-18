output "bucket" {
  value = {
    tf-test-private-bucket            = module.tf-test-private-bucket
    tf-test-hosting-bucket            = module.tf-test-hosting-bucket
    tf-test-hosting-cloudfront-bucket = module.tf-test-hosting-cloudfront-bucket
  }
}

output "object" {
  value = null_resource.upload_objects
}