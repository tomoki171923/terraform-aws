variable "api_name" {
  default = {
    sample  = "sample"
    saviola = "saviola"
  }
}

variable "stage_name" {
  default = {
    develop    = "dev"
    staging    = "st"
    production = "pro"
  }
}