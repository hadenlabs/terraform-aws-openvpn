terraform {
  required_version = ">=0.13.0"
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = ">=3.2.0"
    }

    template = {
      source  = "hashicorp/template"
      version = ">=1.0.0"
    }

    null = {
      source  = "hashicorp/null"
      version = ">=0.1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = ">=1.3.0"
    }

  }
}

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