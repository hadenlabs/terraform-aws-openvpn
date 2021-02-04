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
    inline = [
      "sudo apt-get update -y",
      "curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh",
      "chmod +x openvpn-install.sh",
      <<EOT
          sudo AUTO_INSTALL=y \
            APPROVE_INSTALL=y \
            APPROVE_IP=${aws_instance.openvpn.public_ip} \
            ENDPOINT=${aws_instance.openvpn.public_dns} \
            IPV6_SUPPORT=n \
            PORT_CHOICE=1 \
            CLIENT=${var.admin_user} \
            DNS=1 \
           ./openvpn-install.sh
EOT
      ,
    ]
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
    inline = [
      "curl -O https://raw.githubusercontent.com/dumrauf/openvpn-terraform-install/master/scripts/update_users.sh",
      "chmod +x ~/update_users.sh",
      format("sudo ~/update_users.sh %s", var.admin_user),
    ]
  }
}

#download ovpn configurations to use with openvpn client
resource "null_resource" "openvpn_download_configurations" {

  triggers = {
    provision_openvpn_adduser_id = null_resource.openvpn_adduser.id
  }

  depends_on = [null_resource.openvpn_adduser]

  provisioner "local-exec" {
    command = <<EOT
    mkdir -p ${var.storage_path}/${aws_eip.openvpn.public_ip};
    scp -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        -i ${var.private_key} ${var.ssh_user}@${aws_eip.openvpn.public_ip}:/home/${var.ssh_user}/*.ovpn ${var.storage_path}/${aws_eip.openvpn.public_ip}/
EOT

  }
}
