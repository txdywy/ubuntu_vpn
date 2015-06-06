#!/bin/bash
sudo apt-get update
sudo apt-get install pptpd
sudo cp ./pptpd.conf /etc/pptpd.conf
read -p "Please specify your pptp username: " username
read -p "Please specify your pptp password: " password
sudo echo $username pptpd $password '*' > ./chap-secrets
sudo cp ./chap-secrets /etc/ppp/chap-secrets
sudo cp ./pptpd-options /etc/ppp/pptpd-options
sudo cp ./sysctl.conf /etc/sysctl.conf
sudo sysctl -p
sudo /etc/init.d/pptpd restart
sudo apt-get install iptables
sudo iptables -t nat -A POSTROUTING -s 192.168.117.0/24 -o eth0 -j MASQUERADE
sudo cp ./rc.local /etc/init.d/rc.local
sudo cp ./ufw /etc/default/ufw

sudo apt-get install vnstat
sudo vnstat -u -i eth0
sudo chown -R vnstat:vnstat /var/lib/vnstat



sudo reboot
