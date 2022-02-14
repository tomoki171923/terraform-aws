# ********************************* #
# Elastic Container Registry
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository
# ********************************* #

resource "aws_ecr_repository" "this" {
  name                 = "${var.base_name}-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 10 images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["${var.base_name}_"],
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Expire untagged images older than 7 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 7
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
