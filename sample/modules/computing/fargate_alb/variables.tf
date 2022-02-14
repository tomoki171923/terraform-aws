# *********** Variables *********** #
variable "base_name" {
  type = string
}
variable "vpc_id" {
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
variable "aws_ecr_repository_url" {
  type = string
}
variable "aws_region" {
  type = string
}
variable "execution_role_arn" {
  type = string
}
variable "task_role_arn" {
  type = string
}
variable "container_name" {
  type = string
}
variable "container_port" {
  type = number
}
