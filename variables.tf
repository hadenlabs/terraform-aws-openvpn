variable "namespace" {
  type        = string
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
  default     = null
}

variable "environment" {
  type        = string
  description = "Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT'"
  default     = null
}

variable "stage" {
  type        = string
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
  default     = null
}

variable "name" {
  type        = string
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
  default     = {}
}

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

variable "storage_path" {
  type        = string
  description = "storage path keys to local"
  default     = "~/openvpn"
}

variable "is_test" {
  type        = bool
  description = "implement when is execute a test"
  default     = false
}
