# ********************************* #
# Elastic Container Registry
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository
# ********************************* #

resource "aws_ecr_repository" "myecr" {
  name                 = "myecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}