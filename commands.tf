resource "null_resource" "provision_openvpn" {
  triggers = {
    instance_openvpn_id = aws_instance.openvpn.id
  }
  depends_on = [aws_instance.openvpn, aws_eip.openvpn]
  connection {
    type        = "ssh"
    user        = var.ssh_user
    port        = var.ssh_port
    private_key = file(var.private_key)
    host        = aws_eip.openvpn.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get install -y curl vim git libltdl7 python3 python3-pip python software-properties-common unattended-upgrades",
      "touch ~/provisioned", # Troll
    ]
  }
}

#installing openvpn through third-party openvpn script by dumrauf you can check it out here: https://github.com/dumrauf
resource "null_resource" "openvpn_install" {
  triggers = {
    provision_openvpn_id = null_resource.provision_openvpn.id
  }
  depends_on = [null_resource.provision_openvpn]
  connection {
    type        = "ssh"
    user        = var.ssh_user
    port        = var.ssh_port
    private_key = file(var.private_key)
    host        = aws_eip.openvpn.public_ip
  }

  provisioner "remote-exec" {
    inline = [data.template_file.vpn_install.rendered]
  }
}

#adding user to connect to vpn through third party script by dumrauf you can check it out here: https://github.com/dumrauf
resource "null_resource" "openvpn_adduser" {

  triggers = {
    provision_openvpn_install_id = null_resource.openvpn_install.id
  }

  depends_on = [null_resource.openvpn_install]

  connection {
    type        = "ssh"
    user        = var.ssh_user
    port        = var.ssh_port
    private_key = file(var.private_key)
    host        = aws_eip.openvpn.public_ip
  }

  provisioner "remote-exec" {
    inline = [data.template_file.vpn_update_user.rendered]
  }
}

#download ovpn configurations to use with openvpn client
resource "null_resource" "openvpn_download_configurations" {

  triggers = {
    provision_openvpn_adduser_id = null_resource.openvpn_adduser.id
  }

  depends_on = [null_resource.openvpn_adduser]

  provisioner "local-exec" {
    command = data.template_file.vpn_download_keys.rendered

  }
}
