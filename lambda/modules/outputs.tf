output "function" {
  value = {
    hello_world           = module.function_hello_world
    hello_world_alias_dev = module.alias_hello_world_dev
    hello_world_alias_st  = module.alias_hello_world_st
    hello_world_alias_pro = module.alias_hello_world_pro
  }
}

output "layer" {
  value = {
    base = module.layer_base
  }
}

