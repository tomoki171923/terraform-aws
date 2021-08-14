
output "function" {
  value = {
    hello_world = {
      setting = module.function_hello_world
      alias   = module.alias_hello_world
    }
  }
}

output "layer" {
  value = {
    base = module.layer_base
  }
}

