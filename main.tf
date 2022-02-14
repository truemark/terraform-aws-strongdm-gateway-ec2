locals {
  listen_address = var.listen_address == null ? "${var.name}.${var.zone}:${var.gateway_port}" : var.listen_address
}

data "aws_ami" "this" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "sdm_node" "this" {
  count = var.create ? 1 : 0
  gateway {
    name = var.name
    listen_address = local.listen_address
  }
}

resource "aws_security_group" "this" {
  count = var.create ? 1 : 0
  name = var.name
  vpc_id = var.vpc_id
  ingress {
    from_port = var.gateway_port
    to_port   = var.gateway_port
    protocol  = "tcp"
    cidr_blocks = var.gateway_port_ingress_cidr_blocks
    ipv6_cidr_blocks = var.gateway_port_ingress_cidr_blocks_ipv6
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol  = "tcp"
    cidr_blocks = var.ssh_allowed_cidr_blocks
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    cidr_blocks = var.egress_cidr_blocks
    ipv6_cidr_blocks = var.egress_cidr_blocks_ipv6
  }
  tags = merge(var.security_group_tags, merge(var.tags, {
    Name = var.name
  }))
}

resource "aws_instance" "this" {
  count = var.create ? 1 : 0
  ami = var.ami == null ? data.aws_ami.this.id : var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.this[count.index].id]
  subnet_id = var.subnet_id
  disable_api_termination = false
  key_name = var.key_name
  root_block_device {
    delete_on_termination = true
    encrypted = true
    volume_type = "gp3"
    volume_size = 20
  }
  user_data = templatefile("${path.module}/init.sh.tpl", {
    ssh_keys = var.ssh_keys
    token = sdm_node.this[count.index].gateway[0].token
  })
  depends_on = [sdm_node.this]
  tags = merge(var.instance_tags, merge(var.tags, {
    Name = var.name
  }))
}

data "aws_route53_zone" "this" {
  count = var.create && var.zone != null ? 1 : 0
  name = var.zone
}

resource "aws_route53_record" "this" {
  count = var.create && var.zone != null ? 1 : 0
  name    = var.name
  type    = "A"
  zone_id = data.aws_route53_zone.this[count.index].zone_id
  ttl = 30
  records = [
    aws_instance.this[count.index].public_ip
  ]
}



