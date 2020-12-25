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
  default     = "openvpnas"
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

variable "route53_zone_name" {
  type        = string
  description = "route 53 zone name"
}

variable "subdomain_name" {
  type        = string
  description = "subdomain_name for route 53"
}

variable "subdomain_ttl" {
  type        = string
  description = "subdomain_name for route 53"
  default     = "60"
}

variable "ami" {
  type        = string
  description = "ami for aws"
  default     = "ami-f53d7386" // ubuntu xenial openvpn ami in eu-west-1
}

variable "instance_type" {
  type        = string
  description = "type instance"
  default     = "t2.medium"
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

variable "certificate_email" {
  type        = string
  description = "certificate email"
}