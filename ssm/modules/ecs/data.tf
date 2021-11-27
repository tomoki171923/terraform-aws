data "aws_region" "current" {}

/*
    reading policy files in json format
*/
data "template_file" "task_definition" {
  template = file("${path.module}/task_definitions/task_definition.json.template")
  vars = {
    ecs_cluster_name = local.ecs_cluster_name
    ecs_service_name = local.ecs_service_name
    docker_image_url = "${local.ecr_state.repository.repository_url}:1.0.0"
    container_name   = local.container_name
    container_port   = local.container_port
    aws_region       = data.aws_region.this.name
  }
}
