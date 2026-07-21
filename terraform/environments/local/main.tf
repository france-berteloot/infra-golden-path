provider "kubernetes" {
  config_path    = pathexpand(var.kubeconfig_path)
  config_context = var.kubeconfig_context != "" ? var.kubeconfig_context : null
}

module "platform" {
  source = "../../modules/platform"

  namespace   = var.namespace
  environment = var.environment
  team        = var.team
  app_name    = "demo-app"
}
