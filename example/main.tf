module "main" {
  source = "git://github.com/hadenlabs/terraform-aws-openvpn.git?ref=0.1.0"
  providers = {
    aws = aws.main
  }
  public_key     = "/etc/keys/pub/key.pub"
  private_key    = "/etc/keys/pub/key.pem"
  region         = var.aws_region
  admin_user     = "slovacus"
  admin_password = "password-sensible implement with sops"
}