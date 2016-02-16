#!/bin/bash
sudo apt-get update
sudo apt-get install -y npm
sudo apt-get install -y nodejs
npm install http-proxy --save
npm install url --save

#sudo apt-get install vnstat
#sudo vnstat -u -i eth0
#sudo chown -R vnstat:vnstat /var/lib/vnstat

