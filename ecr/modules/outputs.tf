output "repository" {
  value = aws_ecr_repository.myecr
}

output "lifecycle_policy" {
  value = aws_ecr_lifecycle_policy.myecr
}
