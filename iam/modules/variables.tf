# *********** Variables *********** #
variable "aws_default_policies" {
  default = {
    # Admin
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
    AWSSupportAccess    = "arn:aws:iam::aws:policy/AWSSupportAccess"

    # IAM
    IAMUserChangePassword = "arn:aws:iam::aws:policy/IAMUserChangePassword"

    # API Gateway
    AmazonAPIGatewayAdministrator = "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator"

    # Lambda
    AWSLambda_FullAccess     = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
    AWSLambdaExecute         = "arn:aws:iam::aws:policy/AWSLambdaExecute"
    AWSLambdaRole            = "arn:aws:iam::aws:policy/service-role/AWSLambdaRole"
    AWSLambda_ReadOnlyAccess = "arn:aws:iam::aws:policy/AWSLambda_ReadOnlyAccess"

    # DynamoDB
    AmazonDynamoDBFullAccess     = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
    AmazonDynamoDBReadOnlyAccess = "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"

    # S3
    AmazonS3FullAccess     = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    AmazonS3ReadOnlyAccess = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"

    # Cloud watch
    CloudWatchFullAccess           = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
    CloudWatchLogsFullAccess       = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
    CloudWatchEventsReadOnlyAccess = "arn:aws:iam::aws:policy/CloudWatchEventsReadOnlyAccess"
    CloudWatchReadOnlyAccess       = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"

    # CloudFront
    CloudFrontFullAccess = "arn:aws:iam::aws:policy/CloudFrontFullAccess"

    # DataPipeline
    AWSDataPipeline_FullAccess = "arn:aws:iam::aws:policy/AWSDataPipeline_FullAccess"

    # SES
    AmazonSESFullAccess = "arn:aws:iam::aws:policy/AmazonSESFullAccess"

    # SQS
    AmazonSQSFullAccess = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
  }
}
