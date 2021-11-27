/*
    reading policy files in json format
*/
data "template_file" "cloudwatchagt_basic" {
  template = file("${path.module}/cloudwatchagent/cloudwatchagt_basic.json")
  vars = {
    instane_name = "SampleSSMInstance"
  }
}
