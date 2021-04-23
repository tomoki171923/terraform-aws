# ********************************* #
# Usage Plans on API Gateway
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_usage_plan
# ********************************* #


/*
    Sample API Usage Plans
*/

resource "aws_api_gateway_usage_plan" "sample_free" {
  name        = "${var.api_name.sample}-free"
  description = "${var.api_name.sample} API 開発・テスト環境用使用プラン"
  #product_code = "MYCODE"

  api_stages {
    api_id = data.aws_api_gateway_rest_api.sample.id
    stage  = var.stage_name.develop
  }

  api_stages {
    api_id = data.aws_api_gateway_rest_api.sample.id
    stage  = var.stage_name.staging
  }

  throttle_settings {
    burst_limit = 20
    rate_limit  = 40
  }

  quota_settings {
    limit  = 1000
    period = "DAY"
  }
}

resource "aws_api_gateway_usage_plan" "sample_basic" {
  name        = "${var.api_name.sample}-basic"
  description = "${var.api_name.sample} API 本番環境用使用プラン(Basic)"
  #product_code = "MYCODE"

  api_stages {
    api_id = data.aws_api_gateway_rest_api.sample.id
    stage  = var.stage_name.production
  }

  throttle_settings {
    burst_limit = 20
    rate_limit  = 40
  }

  quota_settings {
    limit  = 1000
    period = "DAY"
  }
}

resource "aws_api_gateway_usage_plan" "sample_flex" {
  name        = "${var.api_name.sample}-flex"
  description = "${var.api_name.sample} API 本番環境用使用プラン(Flex)"
  #product_code = "MYCODE"

  api_stages {
    api_id = data.aws_api_gateway_rest_api.sample.id
    stage  = var.stage_name.production
  }

  throttle_settings {
    burst_limit = 100
    rate_limit  = 200
  }

  quota_settings {
    limit  = 5000
    period = "DAY"
  }
}

resource "aws_api_gateway_usage_plan" "sample_premium" {
  name        = "${var.api_name.sample}-premium"
  description = "${var.api_name.sample} API 本番環境用使用プラン(Premium)"
  #product_code = "MYCODE"

  api_stages {
    api_id = data.aws_api_gateway_rest_api.sample.id
    stage  = var.stage_name.production
  }

  throttle_settings {
    burst_limit = 400
    rate_limit  = 200
  }

  quota_settings {
    limit  = 10000
    period = "DAY"
  }
}