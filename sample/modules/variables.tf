# *********** Variables *********** #
variable "base_name" {
  type    = string
  default = "sample"
}
variable "nat_gateway" {
  type    = bool
  default = false
}
variable "vpc_endpoints" {
  type    = bool
  default = false
}
variable "ec2_single" {
  type    = bool
  default = false
}
variable "ec2_clb" {
  type    = bool
  default = false
}
variable "ec2_alb" {
  type    = bool
  default = false
}
variable "fargate_alb" {
  type    = bool
  default = false
}
