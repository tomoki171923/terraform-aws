# *********** Variables *********** #
variable "domain_name" {
  type    = string
  default = "sample"
}

variable "master_user_name" {
  type    = string
  default = "super"
}

variable "master_user_password" {
  type    = string
  default = "+kmBPjes7Be9"
}

variable "whitelist_ips" {
  type = list(string)
  default = [
    "111.111.111.111/32"
  ]
}