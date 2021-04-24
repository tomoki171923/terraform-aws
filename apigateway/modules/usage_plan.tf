# ********************************* #
# Usage Plans on API Gateway
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_usage_plan
# ********************************* #


/*
    Sample API Usage Plans
*/

resource "aws_api_gateway_usage_plan" "sample_free" {
  name        = "${aws_api_gateway_rest_api.sample.name}-free"
  description = "${aws_api_gateway_rest_api.sample.name} API 開発・テスト環境用使用プラン"
  #product_code = "MYCODE"

  api_stages {
    api_id = aws_api_gateway_rest_api.sample.id
    stage  = aws_api_gateway_stage.sample_dev.stage_name
  }

  api_stages {
    api_id = aws_api_gateway_rest_api.sample.id
    stage  = aws_api_gateway_stage.sample_st.stage_name
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
  name        = "${aws_api_gateway_rest_api.sample.name}-basic"
  description = "${aws_api_gateway_rest_api.sample.name} API 本番環境用使用プラン(Basic)"
  #product_code = "MYCODE"

  api_stages {
    api_id = aws_api_gateway_rest_api.sample.id
    stage  = aws_api_gateway_stage.sample_pro.stage_name
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
  name        = "${aws_api_gateway_rest_api.sample.name}-flex"
  description = "${aws_api_gateway_rest_api.sample.name} API 本番環境用使用プラン(Flex)"
  #product_code = "MYCODE"

  api_stages {
    api_id = aws_api_gateway_rest_api.sample.id
    stage  = aws_api_gateway_stage.sample_pro.stage_name
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
  name        = "${aws_api_gateway_rest_api.sample.name}-premium"
  description = "${aws_api_gateway_rest_api.sample.name} API 本番環境用使用プラン(Premium)"
  #product_code = "MYCODE"

  api_stages {
    api_id = aws_api_gateway_rest_api.sample.id
    stage  = aws_api_gateway_stage.sample_pro.stage_name
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