data "aws_region" "current" {}

# acm remote state
data "terraform_remote_state" "acm" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "acm/ap-northeast-1/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

# route53 remote state
data "terraform_remote_state" "route53" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "route53/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

# ecr remote state
data "terraform_remote_state" "ecr" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "ecr/ap-northeast-1/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "template_file" "task_definition" {
  template = file("${path.module}/task_definitions/init_task_definition.json")

  vars = {
    ecs_cluster_name = local.ecs_cluster_name
    ecs_service_name = local.ecs_service_name
    docker_image_url = "${local.ecr_state.repository.repository_url}:1.0.0"
    container_name   = local.container_name
    container_port   = local.container_port
    region           = local.region
  }
}