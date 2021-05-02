variable "aws_region" {
  description = "region of aws"
  type        = string
}

variable "public_key" {
  description = "path of public key"
  type        = string
}

variable "private_key" {
  description = "path of private key"
  type        = string
}

variable "admin_user" {
  description = "username of admin"
  type        = string
}

variable "storage_path" {
  description = "storage path"
  type        = string
}
