# *********** Variables *********** #
variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "aws_profile" {
  type        = string
  description = "AWS profile name"
}

variable "alias" {
  type        = string
  description = "Please select lambda alias between [dev, st, pro]."
  validation {
    condition     = var.alias == "dev" || var.alias == "st" || var.alias == "pro"
    error_message = "Please select an alias just between [dev, st ,pro]."
  }
}
