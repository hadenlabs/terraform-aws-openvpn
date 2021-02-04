## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | >= 0.13 |
| aws       | >=3.2.0 |
| local     | >=1.3.0 |
| null      | >=0.1.0 |
| template  | >=1.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | >=3.2.0 |
| null | >=0.1.0 |

## Inputs

| Name              | Description                | Type     | Default         | Required |
| ----------------- | -------------------------- | -------- | --------------- | :------: |
| private_key       | private key                | `string` | n/a             |   yes    |
| public_key        | public key                 | `string` | n/a             |   yes    |
| admin_user        | admin user                 | `string` | `"openvpn"`     |    no    |
| https_cidr        | https cidr                 | `string` | `"0.0.0.0/0"`   |    no    |
| https_port        | port https                 | `number` | `443`           |    no    |
| instance_type     | type instance              | `string` | `"t2.micro"`    |    no    |
| ssh_cidr          | ssh cidr                   | `string` | `"0.0.0.0/0"`   |    no    |
| ssh_port          | port ssh                   | `number` | `22`            |    no    |
| ssh_user          | user ssh                   | `string` | `"ubuntu"`      |    no    |
| storage_path      | storage path keys to local | `string` | `"~/openvpn"`   |    no    |
| subnet_cidr_block | subnet cidr block          | `string` | `"10.0.0.0/16"` |    no    |
| tcp_cidr          | tcp cidr                   | `string` | `"0.0.0.0/0"`   |    no    |
| tcp_port          | port tcp                   | `number` | `943`           |    no    |
| udp_cidr          | udp cidr                   | `string` | `"0.0.0.0/0"`   |    no    |
| udp_port          | udp tcp                    | `number` | `1194`          |    no    |
| vpc_cidr_block    | vpc cidr block             | `string` | `"10.0.0.0/16"` |    no    |

## Outputs

| Name        | Description                               |
| ----------- | ----------------------------------------- |
| instance    | return instance openvpn                   |
| instance_ip | return instance openvpn elastic ip public |
| private_key | return filepath privatekey                |
