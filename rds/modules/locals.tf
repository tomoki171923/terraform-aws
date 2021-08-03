locals {
  base_name = "sample"
  vpc_state = data.terraform_remote_state.vpc.outputs.vpc
}
