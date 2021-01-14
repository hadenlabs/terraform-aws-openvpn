output "instance" {
  value = aws_instance.openvpn
}

output "instance_ip" {
  value = aws_instance.openvpn.public_ip
}

output "private_key" {
  value = var.private_key
}
