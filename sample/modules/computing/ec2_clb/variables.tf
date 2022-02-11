# *********** Variables *********** #
variable "base_name" {
  type = string
}
variable "subnet_ids_lb" {
  type = list(string)
}
variable "subnet_ids_computing" {
  type = list(string)
}
variable "security_group_ids_lb" {
  type = list(string)
}
variable "security_group_ids_computing" {
  type = list(string)
}
variable "instance_profile" {
  type = string
}
variable "instance_ami" {
  type = string
}
variable "instance_type" {
  type = string
}
