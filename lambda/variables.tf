# *********** Variables *********** #
variable "aws_region" {}
variable "aws_profile" {}

variable "alias" {
  description = "Please select lambda alias between [dev, st, pro]."
  validation {
    condition     = var.alias == "dev" || var.alias == "st" || var.alias == "pro"
    error_message = "Please select an alias just between [dev, st ,pro]."
  }
}
