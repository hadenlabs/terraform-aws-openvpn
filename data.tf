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
  template = file(format("%s/%s", path.module, "scripts/openvpn/install.tpl.sh"))

  vars = {
    public_ip = aws_eip.this.public_ip
    client    = var.admin_user
  }
}

data "template_file" "vpn_update_user" {
  template = file(format("%s/%s", path.module, "scripts/openvpn/update_user.tpl.sh"))

  vars = {
    client = var.admin_user
  }
}
