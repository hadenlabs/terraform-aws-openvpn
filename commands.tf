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

# provision core templates
resource "null_resource" "provision_core" {
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
    inline = [
      format("%s %s", "rm -rf ", local.templates_path),
      format("%s %s", "mkdir -p ", local.templates_path),
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
  depends_on = [null_resource.provision_core]
  connection {
    type        = "ssh"
    user        = self.triggers.user
    port        = self.triggers.port
    private_key = file(self.triggers.private_key)
    host        = self.triggers.host
  }

  provisioner "file" {
    destination = local.templates.vpn.install.file
    content     = templatefile(local.templates.vpn.install.template, local.templates.vpn.install.vars)
  }

  provisioner "remote-exec" {
    inline = [
      format("%s %s", "sudo chmod a+x", local.templates.vpn.install.file),
      format("%s %s", "sudo ", local.templates.vpn.install.file),
    ]
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

  provisioner "file" {
    destination = local.templates.vpn.update_user.file
    content     = templatefile(local.templates.vpn.update_user.template, local.templates.vpn.update_user.vars)
  }

  provisioner "remote-exec" {
    inline = [
      format("%s %s", "sudo chmod a+x", local.templates.vpn.update_user.file),
      format("%s %s", "sudo ", local.templates.vpn.update_user.file),
    ]
  }
}

#download ovpn configurations to use with openvpn client
resource "null_resource" "openvpn_download_configurations" {
  count = var.is_test ? 0 : 1

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
