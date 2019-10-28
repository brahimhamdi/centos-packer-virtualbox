#!/bin/bash

# set -e
set -x

# Cleanup network devices
echo "Cleaning up network devices"
sudo rm -f /etc/edev/rules.d/70-persistent-net.rules
sudo find /var/lib/dhclient -type f -exec rm -f '{}' +

# Remove hostname
echo "Clearing out /etc/hostname"
sudo cat /dev/null > /etc/hostname

# Tune Linux vm.dirty_background_bytes
echo "Setting vm.dirty_background_bytes"
sudo echo "vm.dirty_background_bytes=100000000" >> /etc/sysctl.conf

# Cleanup files
echo "Cleaning up build files"
sudo rm -rf /root/anaconda-ks.config
sudo rm -rf /tmp/ks-scripts*
sudo rm -rf /var/log/anaconda
sudo yum --enablerepo=epel clean all

# Zero out the rest of the free space using dd, then delete the written file.
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY