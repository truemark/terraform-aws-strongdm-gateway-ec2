variable "name" {
  type = string
  description = "Name of the relay"
}

variable "create" {
  default = true
  type = bool
  description = "Set to false to not create any resources in this stack"
}

variable "instance_type" {
  default = "t3a.medium"
  type = string
  description = "EC2 instance type to use for the gateway"
}

variable "zone" {
  default = null
  type = string
  description = "Optional Route53 zone to create DNS record in for the relay"
}

variable "gateway_port" {
  default = 5000
  type = number
  description = "Port used by the gateway"
}

variable "gateway_port_ingress_cidr_blocks" {
  default = ["0.0.0.0/0"]
  type = list(string)
  description = "Default allowed CIDRs for ingress to the gateway port"
}

variable "gateway_port_ingress_cidr_blocks_ipv6" {
  default = ["::/0"]
  type = list(string)
  description = "Default allowed IPv6 CIDRs for ingress to the gateway port"
}

variable "ssh_allowed_cidr_blocks" {
  default = []
  type = list(string)
  description = "Default allowed CIDRs to access SSH on this EC2 instance"
}

variable "egress_cidr_blocks" {
  default = ["0.0.0.0/0"]
  type = list(string)
  description = "Default allowed CIDRs for egress"
}

variable "egress_cidr_blocks_ipv6" {
  default = ["::/0"]
  type = list(string)
  description = "Default allowed CIDRs for egress"
}

variable "listen_address" {
  default = null
  type = string
  description = "Optional listen address for the gateway. Default is \"name.zone:port\""
}

variable "vpc_id" {
  type = string
  description = "ID of the VPC to provision the EC2 instance in"
}

variable "subnet_id" {
  type = string
  description = "The subnet to provision the EC2 instance in"
}

variable "ami" {
  default = null
  type = string
  description = "Optional AMI to use. Default is to use the latest Ubuntu 20.04 amd64 image"
}

variable "key_name" {
  default = null
  type = string
  description = "SSH key pair to use"
}

variable "ssh_keys" {
  default = []
  type = list(string)
  description = "List of SSH public keys to be added to the authorized_keys file"
}

variable "tags" {
  default = {}
  type = map(string)
  description = "Additional tags for all resources"
}

variable "instance_tags" {
  default = {}
  type = map(string)
  description = "Additional tags for the EC2 instance"
}

variable "security_group_tags" {
  default = {}
  type = map(string)
  description = "Additional tags for the Security group"
}
