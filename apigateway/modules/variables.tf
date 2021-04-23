variable "api_name" {
  default = {
    sample = "sample"
  }
}

variable "stage_name" {
  default = {
    development = "dev"
    staging     = "st"
    production  = "pro"
  }
}