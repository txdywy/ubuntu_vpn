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
rsync -P --rsh=ssh hk:~/android-studio-ide-162.3764568-linux.zip .

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
```
https://github.com/Nyr/openvpn-install
https://github.com/shadowsocks/shadowsocks/wiki/Connect-to-OpenVPN-over-Shadowsocks
```

# PAC Daily
```
https://github.com/pexcn/daily
https://github.com/pexcn/daily/raw/gh-pages/pac/whitelist.pac
```
