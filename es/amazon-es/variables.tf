# *********** Variables *********** #
variable "aws_region" {}
variable "aws_profile" {}

variable "whitelist_ips" {
  type = list(string)
}