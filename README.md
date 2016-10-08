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
To setup shadowsocks, you just need:
```
sh ss.sh
```
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


