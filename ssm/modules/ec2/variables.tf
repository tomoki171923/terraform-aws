variable "base_name" {
  type = string
}


variable "iam_instance_profile" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}
