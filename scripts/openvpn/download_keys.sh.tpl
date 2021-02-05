#!/usr/bin/env bash

mkdir -p ${storage_path}/{public_ip}

scp -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    -i {private_key} {ssh_user}@{public_ip}:/home/{ssh_user}/*.ovpn {storage_path}/{public_ip}/
