#!/bin/bash
sudo pip install shadowsocks
python ss.py
sudo ssserver -c ss.json -d start
