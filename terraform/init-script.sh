#!/bin/bash
sudo apt update -y
# fix ubuntu listening on port 53
sudo mkdir -p /etc/systemd/resolved.conf.d
touch /etc/systemd/resolved.conf.d/adguardhome.conf
# writes 3 lines into the file to disable the DNSStubListener
sudo tee /etc/systemd/resolved.conf.d/adguardhome.conf > /dev/null <<EOF
[Resolve]
DNS=127.0.0.1
DNSStubListener=no
EOF
# Activate another resolv.conf file:
sudo mv /etc/resolv.conf /etc/resolv.conf.backup
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
# Restart DNSStubListener
sudo systemctl reload-or-restart systemd-resolved
# download and install adguard home
curl -s -S -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v
