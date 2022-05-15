# How to use this project

```hcl
  module "main" {
    source  = "hadenlabs/openvpn/aws"
    version = "0.3.0"

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

Full working examples can be found in [examples](./examples) folder.
