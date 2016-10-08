#!/bin/bash
sudo apt-get update
sudo apt-get install strongswan-starter
sudo cp ./ipsec.conf /etc/ipsec.conf
read -p "Please specify your ikev2 pass: " pass
sudo echo : PSK $pass > ./ipsec.secrets
sudo cp ./ipsec.secrets /etc/.
sudo cp ./strongswan.conf /etc/.
sudo apt-get install iptables
sudo su - root -c "sh /home/ubuntu/ubuntu_vpn/ikev2_ip.sh"
sudo ipsec restart

sudo apt-get install vnstat
sudo vnstat -u -i eth0
sudo chown -R vnstat:vnstat /var/lib/vnstat



