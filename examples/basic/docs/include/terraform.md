<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.2.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >=1.3.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >=0.1.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | >=1.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main"></a> [main](#module\_main) | ../ |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | username of admin | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | region of aws | `string` | n/a | yes |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | path of private key | `string` | n/a | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | path of public key | `string` | n/a | yes |
| <a name="input_storage_path"></a> [storage\_path](#input\_storage\_path) | storage path | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance"></a> [instance](#output\_instance) | show instance module |
| <a name="output_instance_ip"></a> [instance\_ip](#output\_instance\_ip) | show ip of instance |
<!-- END_TF_DOCS -->