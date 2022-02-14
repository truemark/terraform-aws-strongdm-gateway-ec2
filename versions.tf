terraform {
  required_version = ">= 1.1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.15"
    }
    sdm = {
      source  = "strongdm/sdm"
      version = "1.0.39"
    }
  }
}
