terraform {
  required_version = ">= 0.12.20, < 2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.2.0"
    }

    null = {
      source  = "hashicorp/null"
      version = ">=0.1.0"
    }

  }
}
