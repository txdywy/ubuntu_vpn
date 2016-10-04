#!/bin/bash
sudo apt-get update
sudo apt-get install strongswan-starter
sudo cp ./ipsec.conf /etc/ipsec.conf
read -p "Please specify your ikev2 pass: " pass
sudo echo : PSK $pass > /etc/ipsec.secrets
sudo apt-get install iptables
sudo iptables -A INPUT -p udp --dport 500 -j ACCEPT
sudo iptables -A INPUT -p udp --dport 4500 -j ACCEPT
sudo echo 1 > /proc/sys/net/ipv4/ip_forward
sudo iptables -t nat -A POSTROUTING -s 10.99.1.0/24 -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -s 10.99.1.0/24 -j ACCEPT

sudo apt-get install vnstat
sudo vnstat -u -i eth0
sudo chown -R vnstat:vnstat /var/lib/vnstat



