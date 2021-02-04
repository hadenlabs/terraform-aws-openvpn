data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

data "template_file" "vpn_install" {
  template = file(format("%s/%s", path.module, "scripts/openvpn_install.sh.tpl"))

  vars = {
    public_ip  = aws_instance.openvpn.public_ip
    public_dns = aws_instance.openvpn.public_dns
    client     = var.admin_user
  }
}

data "template_file" "vpn_update_user" {
  template = file(format("%s/%s", path.module, "scripts/openvpn_update_user.sh.tpl"))

  vars = {
    client = var.admin_user
  }
}

data "template_file" "vpn_download_keys" {
  template = file(format("%s/%s", path.module, "scripts/openvpn_download_keys.sh.tpl"))

  vars = {
    ssh_user     = var.ssh_user
    storage_path = var.storage_path
    public_ip    = aws_eip.openvpn.public_ip
    private_key  = var.private_key
  }
}
