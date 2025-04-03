#!/usr/bin/env bash
set -x
curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
chmod +x openvpn-install.sh
sudo AUTO_INSTALL=y \
    APPROVE_INSTALL=y \
    APROVE_IP=${public_ip} \
    IPV6_SUPPORT=n \
    PORT_CHOICE=1 \
    CLIENT=${client} \
    DNS=1 \
    ./openvpn-install.sh
