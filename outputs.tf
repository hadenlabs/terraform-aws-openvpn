output "instance" {
  description = "return instance openvpn"
  value = aws_instance.openvpn
}

output "instance_ip" {
  description = "return instance openvpn public ip"
  value = aws_instance.openvpn.public_ip
}

output "private_key" {
  description = "return filepath privatekey"
  value = var.private_key
}
