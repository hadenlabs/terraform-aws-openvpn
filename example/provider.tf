provider "aws" {
  region = var.aws_region
  alias  = "main"
}

provider "template" {}

provider "null" {}

provider "local" {}