
output "function" {
  value = {
    hello_world = {
      setting = module.function_hello_world
      alias = {
        dev = module.alias_hello_world_dev
        st  = module.alias_hello_world_st
        pro = module.alias_hello_world_pro
      }
    }
  }
}

output "layer" {
  value = {
    base = module.layer_base
  }
}

