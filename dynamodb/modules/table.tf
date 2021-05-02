# ********************************* #
# DynamoDB Table
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
# ********************************* #

resource "aws_dynamodb_table" "nuancebook" {
  name         = "Nuancebook"
  billing_mode = "PAY_PER_REQUEST"
  # partition key
  hash_key = "jword"
  # sort key
  range_key = "eword"

  attribute {
    name = "jword"
    type = "S"
  }

  attribute {
    name = "eword"
    type = "S"
  }

  attribute {
    name = "hiragana"
    type = "S"
  }

  attribute {
    name = "summary"
    type = "S"
  }

  #ttl {
  #  attribute_name = "TimeToExist"
  #  enabled        = false
  #}

  local_secondary_index {
    name               = "jword-eword-index"
    range_key          = "eword"
    projection_type    = "INCLUDE"
    non_key_attributes = ["date"]
  }

  local_secondary_index {
    name               = "jword-hiragana-index"
    range_key          = "hiragana"
    projection_type    = "INCLUDE"
    non_key_attributes = ["date"]
  }

  local_secondary_index {
    name               = "jword-summary-index"
    range_key          = "summary"
    projection_type    = "INCLUDE"
    non_key_attributes = ["date"]
  }

  point_in_time_recovery {
    enabled = false
  }

  tags = {
    Terraform   = "true"
    Environment = "pro"
  }
}