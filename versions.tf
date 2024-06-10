terraform {
  required_version = "~> 1.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.36.1"
    }
    sdm = {
      source  = "strongdm/sdm"
      version = "10.1.0"
    }
  }
}
