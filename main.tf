module "tags" {
  source      = "hadenlabs/tags/null"
  version     = "0.1.1"
  namespace   = var.namespace
  environment = var.environment
  stage       = var.stage
  name        = var.name
  tags        = var.tags
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block

  tags = module.tags.tags
}

resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = true
  cidr_block              = var.subnet_cidr_block
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = module.tags.tags
}

resource "aws_route" "this" {
  route_table_id         = aws_vpc.this.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_key_pair" "this" {
  key_name   = module.tags.name
  public_key = file(var.public_key)
}

resource "aws_security_group" "this" {
  name        = module.tags.name
  description = "Allow traffic needed by openvpn"
  vpc_id      = aws_vpc.this.id

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

  tags = module.tags.tags
}

resource "aws_instance" "this" {
  depends_on = [
    aws_security_group.this,
  ]
  #checkov:skip=CKV_AWS_88:The instance is necessary have ip public.
  tags = module.tags.tags

  lifecycle {
    ignore_changes = [ami]
  }

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.this.key_name
  subnet_id              = aws_subnet.this.id
  vpc_security_group_ids = [aws_security_group.this.id]

  root_block_device {
    encrypted             = "true"
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = "true"
  }

  # metadata_options {
  #   http_endpoint = "disabled"
  #   http_tokens   = "required"
  # }

}

resource "aws_eip" "this" {
  instance   = aws_instance.this.id
  vpc        = true
  depends_on = [aws_internet_gateway.this]
  tags       = module.tags.tags
}
