# setup new vpc
startup bbr
```
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh

```

install pproxy
```
pip3 install pproxy[accelerated]
```

pproxy cmd
```
pproxy -vv -l ss://encrypt:pass@:port -ul ss://encrypt:pass@:port
```

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
For client side you need a client app like ShadowsocksX-ng for Mac(1.3.1 latest)
It will provide a socks5 proxy at client side as 
```
socks5:127.0.0.1:1080 
```
For socks2http conversion(Mac)
```
brew install polipo
polipo socksParentProxy=localhost:1080 proxyAddress=0.0.0.0
```
```
$ export http_proxy=http://polipo.example.org:8123
$ export https_proxy=http://polipo.example.org:8123
$ export RSYNC_PROXY=polipo.example.org:8123
```
Established listening socket on port 8123.
A local http proxy at 127.0.0.1:8123 is hosted

Proxifier is a all traffic proxy client solution on Windows and Mac(unstable) 

ProxyChains-ng for mac (https://github.com/rofl0r/proxychains-ng) works with shell

For linux/shell user, ssh over nc is another solution.
(https://en.wikibooks.org/wiki/OpenSSH/Cookbook/Proxies_and_Jump_Hosts#ProxyCommand_with_Netcat)
```
ssh -o ProxyCommand="nc -X 5 -x localhost:9150 %h %p" server.example.org
```

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

For ubuntu:
```
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils \
libgdbm-dev libc6-dev openssl libffi-dev
```
More linux reference go to:
```
https://github.com/yyuu/pyenv/wiki/Common-build-problems
```

It will install python3.6
 e.g. pproxy -i ss://aes-256-cfb:pass@:port -vv

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
sshuttle is called poor's VPN.
Only a ssh account is required and thats all for server side.
For macOS，use brew install sshuttle(python, use pip instead). sudo required.
```
sudo sshuttle --dns -r user@server_ip 0.0.0.0/0
```
It required sudo password first, then ssh pass. And thats all, all traffic(TCP) goes over ssh.
For macOS user, if you want to access your ssh config, make sure copy your ssh config and keys from user home to /var/root/.ssh/ which makes sudo work. This solution is safe to your traffic which is ssh encryption ensured but download speed is not as fast as ss.

# lets encrypt
https://github.com/txdywy/scripts/blob/f94e20080aa24719d4001a0b3b9f946b7334ecec/lets-encrypt/README-CN.md

# scp/rsync
```
rsync -P --rsh=ssh hk:~/android-studio-ide-162.3764568-linux.zip .
```

# install python 2
First, install some dependencies:
```
sudo apt-get install build-essential checkinstall
sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
```
Then download using the following command:

version=2.7.13
```
cd ~/Downloads/
wget https://www.python.org/ftp/python/$version/Python-$version.tgz
```
Extract and go to the directory:
```
tar -xvf Python-$version.tgz
cd Python-$version
```
Now, install using the command you just tried, using checkinstall instead to make it easier to uninstall if needed:
```
./configure
make
sudo checkinstall
```

# ubuntu with old source
https://ubuntuforums.org/showthread.php?t=2382832
```
## EOL upgrade sources.list
# Required
deb http://old-releases.ubuntu.com/ubuntu/ zesty main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu/ zesty-updates main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu/ zesty-security main restricted universe multiverse
```

#Install pyenv
https://github.com/pyenv/pyenv-installer
```
$ curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
```

# Set Permanently ulimit -n / open files in ubuntu
https://medium.com/@muhammadtriwibowo/set-permanently-ulimit-n-open-files-in-ubuntu-4d61064429a

# Docker
```
sudo docker run -d \
    -e 'PASSWORD=xxxxxxxx' \
    -e 'METHOD=chacha20-ietf-poly1305' \
    -e 'ARGS=--plugin obfs-server --plugin-opts obfs=http;failover=ms.com' \
    -p 6792:6792/tcp -p 6792:6792/udp \
    txdywy/ss-obfs
```

# iptables
```
sudo iptables -t nat -A PREROUTING -p tcp --dport LOCAL_PORT -j DNAT --to REMOTE_IP:REMOTE_PORT
sudo iptables -t nat -A POSTROUTING -d REMOTE_IP -p tcp --dport LOCAL_PORT -j MASQUERADE
sudo iptables-save > firewall.txt
sudo iptables -t nat -L
```

# openVPN
OpenVPN one-click scripte:
https://github.com/Nyr/openvpn-install

Client socks proxy tunnel extra config:
https://github.com/shadowsocks/shadowsocks/wiki/Connect-to-OpenVPN-over-Shadowsocks

Official Mac Client is trash, does not support socks-proxy.
(pproxy socks may cause peer mtu err)

TunnelBlick:
https://tunnelblick.net/

```
socks-proxy 127.0.0.1 1080
route SHADOWSOCKS_SERVER_IP 255.255.255.255 net_gateway
```
net_gateway means ip excluded

# PAC Daily
https://github.com/pexcn/daily

https://github.com/pexcn/daily/raw/gh-pages/pac/whitelist.pac

chrome extension switch

# Caddy for Lets Encrypt
```
c.xxxx86.com
{
  log ./caddy.log
  proxy /ray localhost:10000 {
    websocket
    header_upstream -Origin
  }
}
```

# Gost
```
sudo ./gost -L "http2://user:pass@:443?cert=/home/user/.caddy/acme/acme-v02.api.letsencrypt.org/sites/c.x86.com/c.x86.com.crt&key=/home/user/.caddy/acme/acme-v02.api.letsencrypt.org/sites/c.x86.com/c.x86.com.key&&probe_resist=code:404"
```

# Issue a cert for TLS and QUIC
```
curl https://get.acme.sh | sh
~/.acme.sh/acme.sh --issue --dns dns_cf -d mydomain.me
```
(root required --force)

```
export CF_Email="2017@gmail.com"
export CF_Key="xxxxxxxa"
```
Cloudflare Required Keys

# tcpdump for checking network
```
sudo tcpdump -vvv -n port xxxxx
```

# Self signed key/cer
```
openssl genrsa -des3 -out server.key 2048
openssl req -new -key server.key -out server.csr
cp server.key server.key.org
openssl rsa -in server.key.org -out server.key
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
```

# Python3 Simple HTTP Server
```
python3 -m http.server 8000 --bind 127.0.0.1
```

# One Cert
https://github.com/flotwig/the-one-cert


# SWAP MEM
https://linuxize.com/post/how-to-add-swap-space-on-ubuntu-18-04/
```
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo vim /etc/fstab
+   /swapfile swap swap defaults 0 0
```

# iptables
```
iptables -I INPUT 1 --protocol tcp --src 103.69.152.226/24 --dport 8880 --jump ACCEPT
iptables -I INPUT 1 --protocol tcp --src 117.136.0.239/8 --dport 8880 --jump ACCEPT
iptables -I INPUT 1 --protocol tcp --src 223.104.3.53/24 --dport 8880 --jump ACCEPT
iptables -A INPUT --protocol tcp --dport 8880 --jump DROP
```

# wireguard
GCP:
```
apt install resolvconf
wget https://raw.githubusercontent.com/atrandys/wireguard/master/wireguard_install_ubuntu.sh && chmod +x wireguard_install_ubuntu.sh && ./wireguard_install_ubuntu.sh
```
random port#

# vless
https://github.com/v2fly/v2ray-examples


# koolshare
https://github.com/hq450/fancyss_history_package/tree/master/fancyss_X64

# check self-signed cert
```
curl -svo /dev/null --resolve hk06.hackx86.com:2087:35.241.92.190 https://hk06.hackx86.com:2087/
```

# kinto
https://github.com/yeahwu/kinto

# ibm lite
https://github.com/CCChieh/IBMYes

# iptables ttl
```
iptables -A INPUT -m ttl --ttl-gt 80 -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -s 103.69.152.0/24 -j ACCEPT
iptables -A INPUT -s 117.0.0.0/8 -j ACCEPT
iptables -A INPUT -s 219.143.155.0/24 -j ACCEPT
iptables -A INPUT -s 223.104.3.0/24 -j ACCEPT
iptables -I INPUT -s 122.97.175.243/24 -j ACCEPT
iptables -A INPUT -j DROP    
```
add log at /var/log/kern.log
```
sudo iptables -I INPUT 5 -m limit --limit 5/min -j LOG --log-prefix "iptables denied: " --log-level 7
```

# gost
https://github.com/ginuerzh/gost/releases/tag/v2.11.1
```
gost -L=ss+ws://aes-128-gcm:q1@:80?path=/
```
