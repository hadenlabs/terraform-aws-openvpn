terraform {
  required_version = ">=0.13.0"
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = ">=3.2.0"
    }

    template = {
      source  = "hashicorp/template"
      version = ">=1.0.0"
    }

    null = {
      source  = "hashicorp/null"
      version = ">=0.1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = ">=1.3.0"
    }

  }
}
