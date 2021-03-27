### common

```hcl
    module "main" {
      source  = "hadenlabs/openvpn/aws"
      version = "0.2.0"

      providers = {
        aws = aws
        template = template
        local = local
      }

      public_key = local.auth_public_key
      private_key = local.auth_private_key
      admin_user = "slovacus"
      storage_path = "~/openvpn"

    }

```
