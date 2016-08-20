#!/bin/bash
if [ -f /usr/local/bin/pip ] || [ -f /usr/bin/pip ];
then
    echo "pip exists"
else
    echo "Installing pip"
    wget https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py
fi
sudo pip install shadowsocks
python ss.py
sudo ssserver -c ss.json -d start
