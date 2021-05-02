resource "null_resource" "provision_openvpn" {
  triggers = {
    user        = var.ssh_user
    port        = var.ssh_port
    private_key = var.private_key
    host        = aws_eip.this.public_ip
  }

  depends_on = [aws_instance.this, aws_eip.this, aws_security_group.this]

  connection {
    type        = "ssh"
    user        = self.triggers.user
    port        = self.triggers.port
    private_key = file(self.triggers.private_key)
    host        = self.triggers.host
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
    user        = var.ssh_user
    port        = var.ssh_port
    private_key = var.private_key
    host        = aws_eip.this.public_ip
  }
  depends_on = [null_resource.provision_openvpn]
  connection {
    type        = "ssh"
    user        = self.triggers.user
    port        = self.triggers.port
    private_key = file(self.triggers.private_key)
    host        = self.triggers.host
  }

  provisioner "remote-exec" {
    inline = [data.template_file.vpn_install.rendered]
  }
}

#adding user to connect to vpn through third party script by dumrauf you can check it out here: https://github.com/dumrauf
resource "null_resource" "openvpn_adduser" {

  triggers = {
    user        = var.ssh_user
    port        = var.ssh_port
    private_key = var.private_key
    host        = aws_eip.this.public_ip
  }

  depends_on = [null_resource.openvpn_install]

  connection {
    type        = "ssh"
    user        = self.triggers.user
    port        = self.triggers.port
    private_key = file(self.triggers.private_key)
    host        = self.triggers.host
  }

  provisioner "remote-exec" {
    inline = [data.template_file.vpn_update_user.rendered]
  }
}

#download ovpn configurations to use with openvpn client
resource "null_resource" "openvpn_download_configurations" {

  triggers = {
    user        = var.ssh_user
    port        = var.ssh_port
    private_key = var.private_key
    host        = aws_eip.this.public_ip
  }

  depends_on = [null_resource.openvpn_adduser, aws_eip.this]

  provisioner "local-exec" {
    command = <<EOT
    mkdir -p ${var.storage_path}/${self.triggers.host};
    scp -o StrictHostKeyChecking=no \
      -o UserKnownHostsFile=/dev/null \
      -i ${self.triggers.private_key} ${self.triggers.user}@${self.triggers.host}:/home/${self.triggers.user}/*.ovpn ${var.storage_path}/${self.triggers.host}/
EOT
  }
}
