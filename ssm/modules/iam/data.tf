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


/*
  fetch aws default policies
*/
data "aws_iam_policy" "ReadOnlyAccess" {
  name = "ReadOnlyAccess"
}
