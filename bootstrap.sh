#!/usr/bin/env bash

cp /vagrant/hosts /etc/hosts
cp /vagrant/resolv.conf /etc/resolv.conf
cp /vagrant/selinux_config /etc/selinux/config
yum install ntp -y
yum install net-tools -y
service ntpd start
#service iptables stop
mkdir -p /root/.ssh; chmod 600 /root/.ssh; cp /home/vagrant/.ssh/authorized_keys /root/.ssh/

#Again, stopping iptables
# /etc/init.d/iptables stop

# Set Timezone
sudo timedatectl set-timezone Asia/Bangkok

# Increasing swap space
sudo dd if=/dev/zero of=/swapfile bs=1024 count=1024k
sudo mkswap /swapfile
sudo swapon /swapfile
echo "/swapfile       none    swap    sw      0       0" >> /etc/fstab

#sudo cp /vagrant/insecure_private_key /root/ec2-keypair
#sudo chmod 600 /root/ec2-keypair

sudo sysctl vm.swappiness=5

sudo sh -c "echo 'vm.swappiness=5' >> /etc/sysctl.conf"

sudo sh -c "echo never > /sys/kernel/mm/transparent_hugepage/defrag"
sudo sh -c "echo 'echo never > /sys/kernel/mm/transparent_hugepage/defrag' >> /etc/rc.local"

sudo sh -c "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
sudo sh -c "echo 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' >> /etc/rc.local"

#sudo sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
#sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
#reboot

#Disable SE 
sudo setenforce 0