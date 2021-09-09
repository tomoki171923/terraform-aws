module "amazon-es" {
  source        = "./modules"
  whitelist_ips = var.whitelist_ips
}