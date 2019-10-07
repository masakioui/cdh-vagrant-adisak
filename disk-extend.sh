#!/bin/bash
sudo parted /dev/sda mkpart primary 68.7GB 100% set 3 lvm on quit
sudo pvcreate /dev/sda3
sudo pvs
sudo vgextend centos /dev/sda3
sudo lvextend /dev/mapper/centos-root -rl +100%FREE
sudo xfs_growfs /dev/centos/root