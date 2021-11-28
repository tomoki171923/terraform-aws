data "aws_caller_identity" "this" {}
data "aws_region" "this" {}

/*
    reading policy files in json format
*/
data "template_file" "ssm_start_session" {
  template = file("${path.module}/policies/ssm_start_session.json")
  vars = {
    aws_account     = data.aws_caller_identity.this.account_id
    aws_region      = data.aws_region.this.name
    environment_tag = "dev"
  }
}
data "template_file" "kms_core" {
  template = file("${path.module}/policies/kms_core.json")
  vars = {
    aws_account = data.aws_caller_identity.this.account_id
    aws_region  = data.aws_region.this.name
  }
}


/*
  fetch aws default policies
*/
data "aws_iam_policy" "ReadOnlyAccess" {
  name = "ReadOnlyAccess"
}
data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  name = "AmazonSSMManagedInstanceCore"
}
data "aws_iam_policy" "CloudWatchAgentServerPolicy" {
  name = "CloudWatchAgentServerPolicy"
}
data "aws_iam_policy" "AmazonSSMPatchAssociation" {
  name = "AmazonSSMPatchAssociation"
}
data "aws_iam_policy" "AmazonECSTaskExecutionRolePolicy" {
  name = "AmazonECSTaskExecutionRolePolicy"
}
data "aws_iam_policy" "AmazonS3FullAccess" {
  name = "AmazonS3FullAccess"
}
