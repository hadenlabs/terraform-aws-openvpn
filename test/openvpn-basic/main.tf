module "main" {
  source       = "../.."
  namespace    = var.namespace
  stage        = var.stage
  name         = var.name
  tags         = var.tags
  public_key   = var.public_key
  private_key  = var.private_key
  admin_user   = var.admin_user
  storage_path = var.storage_path
  is_test      = var.is_test
}