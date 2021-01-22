resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "openvpn"
  }
}

resource "aws_subnet" "vpn_subnet" {
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  cidr_block              = var.subnet_cidr_block
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Internet Gateway for openvpn"
  }
}

resource "aws_route" "internet_access_openvpn" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_key_pair" "openvpn" {
  key_name   = "openvpn-key"
  public_key = file(var.public_key)
}

resource "aws_security_group" "openvpn" {
  name        = "openvpn_sg"
  description = "Allow traffic needed by openvpn"
  vpc_id      = aws_vpc.main.id

  # ssh
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  # https
  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = [var.https_cidr]
  }

  # open vpn tcp
  ingress {
    from_port   = var.tcp_port
    to_port     = var.tcp_port
    protocol    = "tcp"
    cidr_blocks = [var.tcp_cidr]
  }

  # open vpn udp
  ingress {
    from_port   = var.udp_port
    to_port     = var.udp_port
    protocol    = "udp"
    cidr_blocks = [var.udp_cidr]
  }

  # all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "openvpn" {
  tags = {
    Name = "openvpn"
  }

  lifecycle {
    ignore_changes = [ami]
  }
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.openvpn.key_name
  subnet_id              = aws_subnet.vpn_subnet.id
  vpc_security_group_ids = [aws_security_group.openvpn.id]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = "true"
  }

}

resource "aws_eip" "openvpn" {
  instance   = aws_instance.openvpn.id
  vpc        = true
  depends_on = [aws_internet_gateway.gw]
}
