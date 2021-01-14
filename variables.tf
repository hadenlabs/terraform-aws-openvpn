variable "vpc_cidr_block" {
  type        = string
  description = "vpc cidr block"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  type        = string
  description = "subnet cidr block"
  default     = "10.0.0.0/16"
}

variable "public_key" {
  type        = string
  description = "public key"
}

variable "private_key" {
  type        = string
  description = "private key"
}

variable "ssh_user" {
  type        = string
  description = "user ssh"
  default     = "ubuntu"
}

variable "ssh_port" {
  type        = number
  description = "port ssh"
  default     = 22
}

variable "ssh_cidr" {
  type        = string
  description = "ssh cidr"
  default     = "0.0.0.0/0"
}

variable "https_port" {
  type        = number
  description = "port https"
  default     = 443
}

variable "https_cidr" {
  type        = string
  description = "https cidr"
  default     = "0.0.0.0/0"
}

variable "tcp_port" {
  type        = number
  description = "port tcp"
  default     = 943
}

variable "tcp_cidr" {
  type        = string
  description = "tcp cidr"
  default     = "0.0.0.0/0"
}

variable "udp_port" {
  type        = number
  description = "udp tcp"
  default     = 1194
}

variable "udp_cidr" {
  type        = string
  description = "udp cidr"
  default     = "0.0.0.0/0"
}

variable "instance_type" {
  type        = string
  description = "type instance"
  default     = "t2.micro"
}

variable "admin_user" {
  type        = string
  description = "admin user"
  default     = "openvpn"
}

variable "admin_password" {
  type        = string
  description = "admin password"
}

variable "region" {
  type        = string
  description = "region of aws"
  default     = "us-east-1"
}
