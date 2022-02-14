# AWS strongDM Gateway on EC2

This Terraform module creates a strongDM gateway and provisions an EC2 instance
with the configured sdm daemon on it.

Example Usage
```hcl
module "gateway" {
  source  = "truemark/strongdm-gateway-ec2/aws"
  version = "0.0.1"
  name = "mygateway"
  zone = "example.com"
  ssh_allowed_cidr_blocks = local.ssh_allowed
  vpc_id = "<VPC ID>"
  subnet_id = "<SUBNET ID>"
  ssh_keys = [
      "ssh-rsa <SSH_KEY>",
      "ssh-rsa <SSH_KEY>",
  ]
}
```
