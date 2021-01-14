#!/usr/bin/env bash
set -x
/usr/bin/apt-get update -y
curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
chmod +x openvpn-install.sh
export AUTO_INSTALL=y
./openvpn-install.sh