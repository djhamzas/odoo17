#!/bin/bash
# Script to configure static IP on a guest VM (Ubuntu using netplan)

# Variables
VM_IP="192.168.10.20"
NETMASK="24"           # CIDR notation
GATEWAY="192.168.10.1"
DNS="8.8.8.8"

# Get VM console access using virsh
echo "Connecting to VM $VM_NAME via virsh console..."
echo "You must be logged in as root or sudo user inside the VM to apply changes."

# Instructions for inside the VM:
echo "---- Inside VM ----"
echo "1. Create or edit netplan config:"
echo "sudo nano /etc/netplan/01-netcfg.yaml"

cat <<EOF | sudo tee /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    ens3:                 # Change ens3 to your VM's interface name
      dhcp4: no
      addresses: [$VM_IP/$NETMASK]
      gateway4: $GATEWAY
      nameservers:
        addresses: [$DNS]
EOF

echo "2. Apply the netplan config:"
echo "sudo netplan apply"

echo "3. Verify with 'ip a' or 'ping 8.8.8.8'"
