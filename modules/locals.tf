locals {
  es_state = data.terraform_remote_state.es.outputs.es.aws_elasticsearch_domain #TODO: 
  s3_state = data.terraform_remote_state.s3.outputs.s3                          #TODO: 

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