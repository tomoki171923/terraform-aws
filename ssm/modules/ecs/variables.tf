variable "base_name" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

variable "ecr_repository_url" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_port" {
  type = string
}

variable "container_tag" {
  type = string
}
