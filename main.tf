locals {
  defaults = {
    rules_ingress = [
      {
        type        = "ingress"
        from_port   = var.ssh_port
        to_port     = var.ssh_port
        protocol    = "tcp"
        cidr_blocks = [var.ssh_cidr]
      },
      {
        type        = "ingress"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        type        = "ingress"
        from_port   = 943
        to_port     = 943
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        type        = "ingress"
        from_port   = 1194
        to_port     = 1194
        protocol    = "udp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }

  input = {
    rules_ingress = try(var.rules_ingress, [])
  }

  generated = {
    rules_ingress = concat(local.defaults.rules_ingress, local.input.rules_ingress)
  }

  outputs = {
    rules_ingress = local.generated.rules_ingress
  }

}

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
  #checkov:skip=CKV_AWS_130:Public IP required in public subnet
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

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "this" {
  name        = module.tags.name
  description = "Allow traffic needed by openvpn"
  vpc_id      = aws_vpc.this.id
  tags        = module.tags.tags

  lifecycle {
    create_before_destroy = true
  }
}

#AWS security group rule ingress
resource "aws_security_group_rule" "ingress" {
  depends_on = [
    aws_security_group.this,
  ]

  count             = length(local.outputs.rules_ingress)
  description       = format("Ingress %s", module.tags.name)
  security_group_id = aws_security_group.this.id
  type              = try(lookup(local.outputs.rules_ingress[count.index], "type"), "ingress")
  from_port         = lookup(local.outputs.rules_ingress[count.index], "from_port")
  to_port           = lookup(local.outputs.rules_ingress[count.index], "to_port")
  protocol          = lookup(local.outputs.rules_ingress[count.index], "protocol")
  cidr_blocks       = lookup(local.outputs.rules_ingress[count.index], "cidr_blocks")
}

#AWS security group rule egress
resource "aws_security_group_rule" "egress" {
  depends_on = [
    aws_security_group.this,
  ]

  for_each = {
    "openvpn" = aws_security_group.this.id,
  }
  description       = format("Egress %s: %s", module.tags.name, each.key)
  security_group_id = each.value
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
}

resource "aws_instance" "this" {
  #checkov:skip=CKV_AWS_88: The instance is necessary have ip public.
  depends_on = [
    aws_security_group_rule.ingress,
    aws_security_group_rule.egress,
    aws_security_group.this,
  ]
  tags = module.tags.tags

  lifecycle {
    ignore_changes = [ami]
  }

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.this.key_name
  subnet_id              = aws_subnet.this.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.this.id]
  ebs_optimized = true
  monitoring = true

  root_block_device {
    encrypted             = "true"
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = "true"
  }

  metadata_options {
       http_endpoint = "enabled"
       http_tokens   = "required"
  }
}

resource "aws_eip" "this" {
  instance   = aws_instance.this.id
  vpc        = true
  depends_on = [aws_internet_gateway.this]
  tags       = module.tags.tags
}
