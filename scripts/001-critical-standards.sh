#!/bin/bash
echo "Applying critical security configurations..."
# Example: Disable root login
sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart sshd
