data "aws_region" "this" {}

/*
    reading policy files in json format
*/
data "template_file" "task_definition" {
  template = file("${path.module}/task_definitions/task_definition.json.template")
  vars = {
    ecs_cluster_name = var.cluster_name
    ecs_service_name = var.service_name
    docker_image_url = "${var.repository_url}:1.0.0"
    container_name   = var.container_name
    container_port   = var.container_port
    container_tag    = var.container_tag
    aws_region       = data.aws_region.this.name
  }
}
