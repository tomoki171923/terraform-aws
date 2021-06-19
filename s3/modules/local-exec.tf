# ********************************* #
# execute comamnd on local.
# ref: https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource
#      https://www.terraform.io/docs/language/resources/provisioners/local-exec.html
#      https://www.terraform.io/docs/language/resources/provisioners/syntax.html#how-to-use-provisioners
# ********************************* #

locals {
  objects_root_path  = "${path.module}/objects"
  target_bauckt_id   = module.tf-test-hosting-bucket.s3_bucket_id
  target_bauckt_id2  = module.tf-test-hosting-cloudfront-bucket.s3_bucket_id
}

# upload s3 objects to s3 backets.
resource "null_resource" "upload_objects" {
  # exec command each time objects are modified.
  triggers = {
    file_hashes = jsonencode({
      for fn in fileset(local.objects_root_path, "**") :
      fn => filesha256("${local.objects_root_path}/${fn}")
    })
  }
  provisioner "local-exec" {
    on_failure = fail
    command    = <<EOF
aws s3 rm s3://${local.target_bauckt_id}/ --recursive
aws s3 cp ${local.objects_root_path} s3://${local.target_bauckt_id}/ --recursive --acl public-read 
EOF
  }
  provisioner "local-exec" {
    on_failure = fail
    command    = <<EOF
aws s3 rm s3://${local.target_bauckt_id2}/ --recursive
aws s3 cp ${local.objects_root_path} s3://${local.target_bauckt_id2}/ --recursive
EOF
  }
}


