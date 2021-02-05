#!/usr/bin/env bash
set -x
curl -O https://raw.githubusercontent.com/dumrauf/openvpn-terraform-install/master/scripts/update_users.sh
chmod +x update_users.sh
sudo ./update_users.sh ${client}