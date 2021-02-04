output "instance" {
  description = "return instance openvpn"
  value       = aws_instance.openvpn
}

output "instance_ip" {
  description = "return instance openvpn elastic ip public"
  value       = aws_eip.openvpn.public_ip
}

output "private_key" {
  description = "return filepath privatekey"
  value       = var.private_key
}
