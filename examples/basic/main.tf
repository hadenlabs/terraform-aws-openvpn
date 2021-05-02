module "main" {
  providers = {
    aws      = aws.main
    template = template
    local    = local
  }
  source       = "../"
  public_key   = "/etc/keys/pub/key.pub"
  private_key  = "/etc/keys/pub/key.pem"
  admin_user   = "slovacus"
  storage_path = "~/openvpn"
}
