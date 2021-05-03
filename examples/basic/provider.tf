provider "aws" {
  region = var.aws_region
}

provider "template" {}

provider "null" {}

provider "local" {}
