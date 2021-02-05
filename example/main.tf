module "main" {
  source = "git://github.com/hadenlabs/terraform-aws-openvpn.git?ref=0.2.0"
  providers = {
    aws      = aws.main
    template = template
    local    = local
  }
  public_key   = "/etc/keys/pub/key.pub"
  private_key  = "/etc/keys/pub/key.pem"
  admin_user   = "slovacus"
  storage_path = "~/openvpn"
}