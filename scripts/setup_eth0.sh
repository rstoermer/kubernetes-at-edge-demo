# Paste this on the machine

# Define the IP addresses for eth0 on each host
IP="192.168.2.3"
IGW="192.168.2.1"
FILE="99-custom-eth0.yaml"

# Inform the user which IP is currently being configured
echo "Updating Netplan configuration with IP $IP"

# Use a heredoc to write the Netplan configuration
sudo tee /etc/netplan/$FILE > /dev/null << EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - $IP/24
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
      routes:
        - to: 0.0.0.0/0
          via: $IGW
EOF

sudo chmod 0600 /etc/netplan/$FILE

# Apply the netplan to make the changes take effect
sudo netplan apply --debug

echo "Netplan configuration updated for IP $IP."