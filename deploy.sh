#!/bin/bash
sudo apt-get update
if [ -f /usr/local/bin/pip ] || [ -f /usr/bin/pip ];
then
    echo "pip exists"
else
    echo "Installing pip"
    wget https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py
fi
sudo pip install fabric
sudo apt-get install pptpd
sudo cp ./pptpd.conf /etc/pptpd.conf
sudo python setup_chap.py
sudo cp ./chap-secrets /etc/ppp/chap-secrets
sudo cp ./pptpd-options /etc/ppp/pptpd-options
sudo cp ./sysctl.conf /etc/sysctl.conf
sudo sysctl -p
sudo /etc/init.d/pptpd restart
sudo apt-get install iptables
sudo iptables -t nat -A POSTROUTING -s 192.168.117.0/24 -o eth0 -j MASQUERADE
sudo cp ./rc.local /etc/init.d/rc.local
sudo cp ./ufw /etc/default/ufw
sudo reboot
