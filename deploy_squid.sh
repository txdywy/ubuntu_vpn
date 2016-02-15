#!/bin/bash
sudo apt-get update
sudo apt-get install -y squid
sudo apt-get install -y apache2-utils
read -p "Please specify your http proxy username: " username
sudo htpasswd -c /etc/squid3/passwords $username
sudo cp ./squid.conf /etc/squid3/.
sudo service squid3 restart

#sudo apt-get install vnstat
#sudo vnstat -u -i eth0
#sudo chown -R vnstat:vnstat /var/lib/vnstat

