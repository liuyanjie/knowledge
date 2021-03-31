# IKEv2

安装脚本使用：[one-key-ikev2-vpn](https://github.com/quericy/one-key-ikev2-vpn)

## 安装服务器

目前，VPN服务安装在 `op.mo` 服务器上，所以以下安装过程是在 `op.mo` 服务器上进行的。

## 安装步骤

备份防火墙配置：

```sh
iptables-save > path/to/backup-file
```

工作目录

```sh
$ pwd
/root
$ cd one-key-ikev2
$ pwd
/root/one-key-ikev2
```

下载并执行安装脚本

```sh
wget --no-check-certificate https://raw.githubusercontent.com/quericy/one-key-ikev2-vpn/master/one-key-ikev2.sh
chmod +x one-key-ikev2.sh
bash one-key-ikev2.sh
./one-key-ikev2.sh
```

```sh
Preparing, Please wait a moment...
#############################################################
# Install IKEV2 VPN for CentOS6.x/7 (32bit/64bit) or Ubuntu or Debian7/8.*
# Intro: https://quericy.me/blog/699
#
# Author:quericy
#
# Version:1.2.0
#############################################################
please choose the type of your VPS(Xen、KVM: 1  ,  OpenVZ: 2):
your choice(1 or 2):1
```

```sh
please input the ip (or domain) of your VPS:
ip or domain(default_value:47.105.125.227):
```

```sh
Would you want to import existing cert? You NEED copy your cert file to the same directory of this script
yes or no?(default_value:no):no
please input the cert country(C):
C(default value:com):
please input the cert organization(O):
O(default value:myvpn):
please input the cert common name(CN):
CN(default value:VPN CA):
####################################
Please confirm the information:

the type of your server: [Xen、KVM]
the ip(or domain) of your server: [47.105.125.227]
the cert_info:[C=com, O=myvpn]
```

中间是一大段源码编译输出

```sh
configure the pkcs12 cert password(Can be empty):
Enter Export Password:
Verifying - Enter Export Password:
####################################
Cert copy completed
Use SNAT could implove the speed,but your server MUST have static ip address.
yes or no?(default_value:no):
* Applying /usr/lib/sysctl.d/00-system.conf ...
* Applying /usr/lib/sysctl.d/10-default-yama-scope.conf ...
kernel.yama.ptrace_scope = 0
* Applying /etc/sysctl.d/10-ipsec.conf ...
net.ipv4.ip_forward = 1
* Applying /usr/lib/sysctl.d/50-default.conf ...
kernel.sysrq = 16
kernel.core_uses_pid = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.promote_secondaries = 1
net.ipv4.conf.all.promote_secondaries = 1
fs.protected_hardlinks = 1
fs.protected_symlinks = 1
* Applying /etc/sysctl.d/99-sysctl.conf ...
vm.swappiness = 0
net.ipv4.neigh.default.gc_stale_time = 120
net.ipv4.conf.all.rp_filter = 0
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.default.arp_announce = 2
net.ipv4.conf.lo.arp_announce = 2
net.ipv4.conf.all.arp_announce = 2
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 1024
net.ipv4.tcp_synack_retries = 2
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
kernel.sysrq = 1
* Applying /etc/sysctl.conf ...
vm.swappiness = 0
net.ipv4.neigh.default.gc_stale_time = 120
net.ipv4.conf.all.rp_filter = 0
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.default.arp_announce = 2
net.ipv4.conf.lo.arp_announce = 2
net.ipv4.conf.all.arp_announce = 2
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 1024
net.ipv4.tcp_synack_retries = 2
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
kernel.sysrq = 1
```

```sh
Do you use firewall in CentOS7 instead of iptables?
yes or no?(default_value:no):no
ip address info:
    inet 127.0.0.1/8 scope host lo
    inet 172.31.197.4/20 brd 172.31.207.255 scope global dynamic eth0
The above content is the network card information of your VPS.
[Important]Please enter the name of the interface which can be connected to the public network.
Network card interface(default_value:eth0):
The service command supports only basic LSB actions (start, stop, restart, try-restart, reload, force-reload, status). For other actions, please try to use systemctl.
Stopping strongSwan IPsec failed: starter is not running
Starting strongSwan 5.5.1 IPsec [starter]...
#############################################################
#
# [Install Complete]
# Version:1.2.0
# There is the default login info of your IPSec/IkeV2 VPN Service
# UserName: myUserName
# PassWord: myUserPass
# PSK: myPSKkey
# you should change default username and password in /usr/local/etc/ipsec.secrets
# you cert: /root/my_key/ca.cert.pem
# you must copy the cert to the client and install it.
#
#############################################################
```

至此，IKEv2 VPN 已经搭建完成，相关信息如上。

IPSec VPN 会监听 `500(UDP),4500(UDP)` 端口：

  Ref: [vowfi中IPSEC port 500、4500端口解释](https://zhuanlan.zhihu.com/p/46495201)

  1. UDP:500 是 Internet Security Association and Key Management Protocol (ISAKMP）端口号
  2. UDP:4500 是 UDP-encapsulated ESP and IKE端口号

查看端口是否监听，正确启动后端口监听：

```sh
[root@iZm5e6ke9g2f41bhbztxeoZ ~]# lsof -i:500
COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
charon  20903 root   10u  IPv6  82315      0t0  UDP *:isakmp
charon  20903 root   12u  IPv4  82317      0t0  UDP *:isakmp
[root@iZm5e6ke9g2f41bhbztxeoZ ~]# lsof -i:4500
COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
charon  20903 root   11u  IPv6  82316      0t0  UDP *:ipsec-nat-t
charon  20903 root   13u  IPv4  82318      0t0  UDP *:ipsec-nat-t
[root@iZm5e6ke9g2f41bhbztxeoZ ~]#
```

探测UDP端口通不通，使用如下参数：

```sh
nc -vuz 112.91.151.10 4500
```

如果通，显示如下：

```
[112.91.151.10] 500 (isakmp) open
```

```sh
$ nc -vuz 112.91.151.10 500
found 0 associations
found 1 connections:
     1: flags=82<CONNECTED,PREFERRED>
        outif (null)
        src 172.20.10.7 port 51475
        dst 120.76.224.147 port 500
        rank info not available

Connection to 112.91.151.10 port 500 [udp/isakmp] succeeded!

$ nc -vuz 112.91.151.10 4500
found 0 associations
found 1 connections:
     1: flags=82<CONNECTED,PREFERRED>
        outif (null)
        src 172.20.10.7 port 54767
        dst 120.76.224.147 port 4500
        rank info not available

Connection to 112.91.151.10 port 4500 [udp/ipsec-msft] succeeded!
```

如果端口不通，显示如下：

```
112.91.151.10: inverse host lookup failed: 
(UNKNOWN) [112.91.151.10] 4500 (ipsec-nat-t) : Connection refused
```

因为，防火墙需要允许 `500/4500` 端口访问，所以，安装过程中，安装脚本会修改防火墙配置，修改后的配置如下：

注意：安装前需要备份iptables

备份路径：`/root/iptables-backup`

```sh
$ tree iptable-backup
iptable-backup
├── iptables.backup.190102
└── iptables-ikev2.2019-01-22

0 directories, 2 files
```

备份命令：

```sh
iptables-save > path/to/backup-file
```

恢复命令：

```sh
iptables-restore < path/to/backup-file
```

```sh
[root@iZm5e6ke9g2f41bhbztxeoZ ~]# iptables -nvL
Chain INPUT (policy ACCEPT 339 packets, 361K bytes)
 pkts bytes target     prot opt in     out     source               destination
    0     0 ACCEPT     esp  --  eth0   *       0.0.0.0/0            0.0.0.0/0
    2  1264 ACCEPT     udp  --  eth0   *       0.0.0.0/0            0.0.0.0/0            udp dpt:500
    0     0 ACCEPT     tcp  --  eth0   *       0.0.0.0/0            0.0.0.0/0            tcp dpt:500
 1880  362K ACCEPT     udp  --  eth0   *       0.0.0.0/0            0.0.0.0/0            udp dpt:4500
    0     0 ACCEPT     udp  --  eth0   *       0.0.0.0/0            0.0.0.0/0            udp dpt:1701
    0     0 ACCEPT     tcp  --  eth0   *       0.0.0.0/0            0.0.0.0/0            tcp dpt:1723

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination
 3222 2489K ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
    0     0 ACCEPT     all  --  *      *       10.31.0.0/24         0.0.0.0/0
    0     0 ACCEPT     all  --  *      *       10.31.1.0/24         0.0.0.0/0
  329 20992 ACCEPT     all  --  *      *       10.31.2.0/24         0.0.0.0/0

Chain OUTPUT (policy ACCEPT 2403 packets, 2526K bytes)
 pkts bytes target     prot opt in     out     source               destination
```

## 故障处理

如果VPN服务运行中出现问题，或者因为更新系统导致VPN无法连接（出现过），进而导致其他服务主机无法远程登录，需要重新安装VPN服务，因为系统无法登录，需要在阿里云管理控制台重启系统，重启后可以登录是因为 iptables 在重启后还原成默认的。

重启服务器：

重启服务器后，需要设置以下 iptables 规则后，VPN 才能工作

```sh
iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -s 10.31.0.0/24  -j ACCEPT
iptables -A FORWARD -s 10.31.1.0/24  -j ACCEPT
iptables -A FORWARD -s 10.31.2.0/24  -j ACCEPT
iptables -A INPUT -i eth0 -p esp -j ACCEPT
iptables -A INPUT -i eth0 -p udp --dport 500 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --dport 500 -j ACCEPT
iptables -A INPUT -i eth0 -p udp --dport 4500 -j ACCEPT
iptables -A INPUT -i eth0 -p udp --dport 1701 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --dport 1723 -j ACCEPT
```

```sh
iptables -t nat -A POSTROUTING -s 10.31.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.31.1.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.31.2.0/24 -o eth0 -j MASQUERADE
```

故障情形有很多种，如有遇到需要根据具体情形具体处理

## 改进

1. 安装到专有VPN服务器上
2. 不使用自签证书
