# ********************************* #
# Elastic Container Registry Lifecycle Policy
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy
# ********************************* #

resource "aws_ecr_lifecycle_policy" "myecr" {
  repository = aws_ecr_repository.myecr.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 10 images for development environment.",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["dev_"],
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Keep last 30 images for production environment.",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["pro_"],
                "countType": "imageCountMoreThan",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
