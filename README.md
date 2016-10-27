# ubuntu_vpn
setup ubuntu vpc to support vpn via pptp, especially on aws ec2 ubuntu14.04 hvm

Need to setup security group for your ec2
```
e.g.
SSH
TCP
22
0.0.0.0/0
```
```
Custom TCP Rule
TCP
1723
0.0.0.0/0
```
```
All ICMP
All
N/A
0.0.0.0/0
```
p.s. user/password required during the install process

To setup vpn, you just need:
```
sh deploy.sh
```
# ubuntu_squid http proxy
Need to setup security group for your ec2
```
Custom TCP Rule
TCP
3128
0.0.0.0/0
```
p.s. user/password required during the install process

To setup proxy, you just need:
```
sh deploy_squid.sh
```
# ubuntu_node http-proxy
Need to setup security group for your ec2
```
Custom TCP Rule
TCP
8888
0.0.0.0/0
```
port 8888 was default in http.js, change it to anyone if you prefer and remember setup the firewall

p.s. no auth required with node; http/https worked fine

Env required
```
sudo apt-get install npm nodejs
sudo cp /usr/bin/nodejs /usr/bin/node
sudo npm install pm2 -g
cd ~/ubuntu_vpn/; npm install http-proxy
```
To setup proxy, you just need:
```
./start_8888
```
Just remember to stop it by:
```
./stop_8888
```
node process management by pm2

# ubuntu_python http(s) proxy
Get a free port e.g. 8888
```
python proxy.py --hostname 0.0.0.0 --port 8888

proxy.py [-h] [--hostname HOSTNAME] [--port PORT]
                [--log-level LOG_LEVEL
```
# shadowsocks proxy
Need to setup security group for your ec2
```
Custom TCP Rule
TCP
8388
0.0.0.0/0
```
To setup shadowsocks on server, you just need:
```
sh ss.sh
```
For client side you need a client app like ShadowsocksX for Mac
It will provide a socks5 proxy at client side as 
```
socks5:127.0.0.1:1080 
```
For socks2http conversion(Mac)
```
brew install polipo
polipo socksParentProxy=localhost:1080 proxyAddress=0.0.0.0
```
Established listening socket on port 8123.
A local http proxy at 127.0.0.1:8123 is hosted

# shadowsocks by pproxy
Python3.6 required
Need to setup security group for your ec2
```
Custom TCP Rule
TCP
1287
0.0.0.0/0
```
To setup shadowsocks on server by pproxy, you just need:
```
sh ppxy.sh
```
For mac user, make sure openssl installed and add there before make:
```
export CPPFLAGS=-I$(brew --prefix openssl)/include
export LDFLAGS=-L$(brew --prefix openssl)/lib
```
Run ```xcode-select --install``` to fix installation of Command Line Tools for Xcode working.

It will install python3.6

# IKEv2 vpn
Need to setup security group for your ec2
```
Custom UDP Rule
UDP
500
0.0.0.0/0
```
```
Custom UDP Rule
UDP
4500
0.0.0.0/0
```
To setup ikev2 vpn, you just need(~~root user required~~):
```shell
sh ikev2.sh
```
input your pass as the PSK(remote id is coded as "vpn")

# sshuttle
sshuttle is called poor's VPN
A ssh account is required ans just it for server side
For macOS，brew install sshuttle(python, use pip instead)
```
sudo sshuttle --dns -r user@server_ip 0.0.0.0/0
```
It required sudo password first, then ssh pass. And thats all, all traffic(TPC) goes over ssh.


