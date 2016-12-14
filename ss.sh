#!/bin/bash
if [ -f /usr/local/bin/pip ] || [ -f /usr/bin/pip ];
then
    echo "pip exists"
else
    echo "Installing pip"
    wget https://bootstrap.pypa.io/get-pip.py
    if [ -f /usr/bin/python ];
    then
        sudo python get-pip.py
    else
        sudo python3 get-pip.py
    fi
fi
sudo pip install shadowsocks
if [ -f /usr/bin/python ];
then
    python ss.py
else
    python3 ss.py
fi
sudo ssserver -c ss.json -d start
