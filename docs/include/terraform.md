<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.2.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >=1.3.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >=0.1.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | >=1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=3.2.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >=0.1.0 |
| <a name="provider_template"></a> [template](#provider\_template) | >=1.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [null_resource.openvpn_adduser](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.openvpn_download_configurations](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.openvpn_install](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.provision_openvpn](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [template_file.vpn_install](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.vpn_update_user](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_https_port"></a> [https\_port](#input\_https\_port) | port https | `number` | `443` | no |
| <a name="input_ssh_port"></a> [ssh\_port](#input\_ssh\_port) | port ssh | `number` | `22` | no |
| <a name="input_tcp_port"></a> [tcp\_port](#input\_tcp\_port) | port tcp | `number` | `943` | no |
| <a name="input_udp_port"></a> [udp\_port](#input\_udp\_port) | udp tcp | `number` | `1194` | no |
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | admin user | `string` | `"openvpn"` | no |
| <a name="input_https_cidr"></a> [https\_cidr](#input\_https\_cidr) | https cidr | `string` | `"0.0.0.0/0"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | type instance | `string` | `"t2.micro"` | no |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | private key | `string` | n/a | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | public key | `string` | n/a | yes |
| <a name="input_ssh_cidr"></a> [ssh\_cidr](#input\_ssh\_cidr) | ssh cidr | `string` | `"0.0.0.0/0"` | no |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | user ssh | `string` | `"ubuntu"` | no |
| <a name="input_storage_path"></a> [storage\_path](#input\_storage\_path) | storage path keys to local | `string` | `"~/openvpn"` | no |
| <a name="input_subnet_cidr_block"></a> [subnet\_cidr\_block](#input\_subnet\_cidr\_block) | subnet cidr block | `string` | `"10.0.0.0/16"` | no |
| <a name="input_tcp_cidr"></a> [tcp\_cidr](#input\_tcp\_cidr) | tcp cidr | `string` | `"0.0.0.0/0"` | no |
| <a name="input_udp_cidr"></a> [udp\_cidr](#input\_udp\_cidr) | udp cidr | `string` | `"0.0.0.0/0"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | vpc cidr block | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance"></a> [instance](#output\_instance) | return instance openvpn |
| <a name="output_instance_ip"></a> [instance\_ip](#output\_instance\_ip) | return instance openvpn elastic ip public |
| <a name="output_private_key"></a> [private\_key](#output\_private\_key) | return filepath privatekey |
<!-- END_TF_DOCS -->