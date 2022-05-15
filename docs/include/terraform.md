<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.20, < 2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.2.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >=0.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=3.2.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >=0.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | hadenlabs/tags/null | >0.1 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [null_resource.openvpn_adduser](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.openvpn_download_configurations](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.openvpn_install](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.provision_core](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.provision_openvpn](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | admin user | `string` | `"openvpn"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | type instance | `string` | `"t2.micro"` | no |
| <a name="input_is_test"></a> [is\_test](#input\_is\_test) | implement when is execute a test | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Solution name, e.g. 'app' or 'jenkins' | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | private key | `string` | n/a | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | public key | `string` | n/a | yes |
| <a name="input_rules_ingress"></a> [rules\_ingress](#input\_rules\_ingress) | list rule for security group | <pre>list(object({<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_ssh_cidr"></a> [ssh\_cidr](#input\_ssh\_cidr) | ssh cidr | `string` | `"0.0.0.0/0"` | no |
| <a name="input_ssh_port"></a> [ssh\_port](#input\_ssh\_port) | port ssh | `number` | `22` | no |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | user ssh | `string` | `"ubuntu"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_storage_path"></a> [storage\_path](#input\_storage\_path) | storage path keys to local | `string` | `"~/openvpn"` | no |
| <a name="input_subnet_cidr_block"></a> [subnet\_cidr\_block](#input\_subnet\_cidr\_block) | subnet cidr block | `string` | `"10.0.0.0/16"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | vpc cidr block | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance"></a> [instance](#output\_instance) | return instance openvpn |
| <a name="output_instance_ip"></a> [instance\_ip](#output\_instance\_ip) | return instance openvpn elastic ip public |
| <a name="output_private_key"></a> [private\_key](#output\_private\_key) | return filepath privatekey |
<!-- END_TF_DOCS -->