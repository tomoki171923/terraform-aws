module "codebuild_policy" {
  # remote module
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "coudebuild_base_policy_${var.build_project_name}_${data.aws_region.current.name}"
  path        = "/service-role/"
  description = "Policy used in trust relationship with CodeBuild"

  policy = data.template_file.codebuild_policy.rendered
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "codebuild_role" {
  # remote module
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_services = [
    "codebuild.amazonaws.com"
  ]
  create_role       = true
  role_name         = "CodeBuildBaseRole_${var.build_project_name}_${data.aws_region.current.name}"
  role_description  = "CodeBuildBaseRole for ${var.build_project_name} Project in ${data.aws_region.current.name} region."
  role_requires_mfa = false

  custom_role_policy_arns = [
    module.codebuild_policy.arn
  ]
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
