#!/usr/bin/env bash
set -x
sudo apt-get update -y
curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
chmod +x openvpn-install.sh
export AUTO_INSTALL=y
export APPROVE_INSTALL=y
export APROVE_IP={public_ip} 
export ENDPOINT={public_dns} 
export IPV6_SUPPORT=n 
export PORT_CHOICE=1 
export CLIENT={client} 
export  DNS=1
./openvpn-install.sh