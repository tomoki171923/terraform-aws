locals {
  es_state = data.terraform_remote_state.es.outputs.amazon-es
  s3_state = data.terraform_remote_state.s3.outputs.s3

  dev = {
    users = {
      index_name      = "users"
      buffer_size     = 5   # MB
      buffer_interval = 60  # sec
      retry_duration  = 300 # sec
    },
    items = {
      index_name      = "items"
      buffer_size     = 5   # MB
      buffer_interval = 60  # sec
      retry_duration  = 300 # sec
    }
  }
}