# ubuntu_vpn
setup ubuntu vpc to support vpn via pptp, especially on aws ec2 ubuntu14.04 hvm

Need to setup security group for your ec2
e.g.
SSH
TCP
22
0.0.0.0/0

Custom TCP Rule
TCP
1723
0.0.0.0/0

All ICMP
All
N/A
0.0.0.0/0

p.s. user/password required during the install process


# ubuntu_squid http proxy
Need to setup security group for your ec2
Custom TCP Rule
TCP
3128
0.0.0.0/0

p.s. user/password required during the install process
