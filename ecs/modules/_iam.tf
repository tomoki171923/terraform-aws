/*
  for ecs cluster
*/

resource "aws_iam_role" "ecs_cluster_role" {
  name = "${local.ecs_cluster_name}-iam-role"

  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
 {
   "Effect": "Allow",
   "Principal": {
     "Service": ["ecs.amazonaws.com", "ec2.amazonaws.com", "application-autoscaling.amazonaws.com"]
   },
   "Action": "sts:AssumeRole"
  }
  ]
 }
EOF
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_iam_role_policy" "ecs_cluster_policy" {
  name = "${local.ecs_cluster_name}-iam-policy"
  role = aws_iam_role.ecs_cluster_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:*",
        "ec2:*",
        "elasticloadbalancing:*",
        "ecr:*",
        "dynamodb:*",
        "cloudwatch:*",
        "s3:*",
        "rds:*",
        "sqs:*",
        "sns:*",
        "logs:*",
        "ssm:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}


/*
  for ecs service
*/

resource "aws_iam_role" "fargate_iam_role" {
  name = "${local.ecs_service_name}-iam-role"

  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
 {
   "Effect": "Allow",
   "Principal": {
     "Service": ["ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
   },
   "Action": "sts:AssumeRole"
  }
  ]
 }
EOF
}

resource "aws_iam_role_policy" "fargate_iam_policy" {
  name = "${local.ecs_service_name}-iam-role"
  role = aws_iam_role.fargate_iam_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:*",
        "ecr:*",
        "logs:*",
        "cloudwatch:*",
        "elasticloadbalancing:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}