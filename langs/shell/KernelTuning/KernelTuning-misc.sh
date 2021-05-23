#!/usr/bin/env bash
mpstat -I SUM -P ALL 1

#超过5000/秒 有点繁忙， 1万-2万/秒相当高了。

#运行如下命令来确认那个设备/项目导致负载：

mpstat -I CPU -P ALL 1

#这个输出很难被阅读，但是你可以跟踪正确的列用来确认哪个中断导致负载，例如：15，19，995. 你也可以定义你想查看的cpu

mpstat -I CPU -P 3 1 # 3 在top,htop中可以定位不同的cpu。（top和mpstat都是从0开始，htop是从1开始计数）

ss -s

netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'

netstat -s | grep "times the listen queue of a socket overflowed"

netstat -nat | grep "192.168.0.1:22" | awk '{print $5}'| awk -F: '{print $1}'|sort|uniq -c|sort -nr|head -20

apt-get install atop
apt-get install htop
apt-get install sysstat
apt-get install nmon
apt-get install memstat

vmstat -s

# 原来的优化项目
echo "kernel.sysrq = 0" >> /etc/sysctl.conf
echo "kernel.core_uses_pid = 1" >> /etc/sysctl.conf
echo "kernel.msgmnb = 65536" >> /etc/sysctl.conf
echo "kernel.msgmax = 65536" >> /etc/sysctl.conf
echo "kernel.shmmax = 68719476736" >> /etc/sysctl.conf
echo "kernel.shmall = 4294967296" >> /etc/sysctl.conf

echo "net.core.wmem_default = 8388608" >> /etc/sysctl.conf
echo "net.core.rmem_default = 8388608" >> /etc/sysctl.conf
echo "net.core.rmem_max = 16777216" >> /etc/sysctl.conf
echo "net.core.wmem_max = 16777216" >> /etc/sysctl.conf
echo "net.core.netdev_max_backlog = 262144" >> /etc/sysctl.conf
#echo "net.core.somaxconn = 262144" >> /etc/sysctl.conf
echo "net.core.somaxconn = 2048" >> /etc/sysctl.conf

echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf

echo "net.ipv4.tcp_max_tw_buckets = 6000" >> /etc/sysctl.conf
echo "net.ipv4.tcp_sack = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_window_scaling = 1" >> /etc/sysctl.conf

echo "net.ipv4.tcp_mem = 94500000 915000000 927000000" >> /etc/sysctl.conf
echo "net.ipv4.tcp_rmem = 4096 87380 4194304" >> /etc/sysctl.conf
echo "net.ipv4.tcp_wmem = 4096 16384 4194304" >> /etc/sysctl.conf

echo "net.ipv4.tcp_max_orphans = 3276800" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_syn_backlog = 262144" >> /etc/sysctl.conf
echo "net.ipv4.tcp_timestamps = 0" >> /etc/sysctl.conf
echo "net.ipv4.tcp_synack_retries = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_syn_retries = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_tw_recycle = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_tw_reuse = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_fin_timeout = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_time = 30" >> /etc/sysctl.conf
echo "net.ipv4.ip_local_port_range = 1024 65000" >> /etc/sysctl.conf

net.ipv4.tcp_syncookies = 1
#表示开启SYN Cookies。当出现SYN等待队列溢出时，启用cookies来处理，可防范少量SYN攻击，默认为0，表示关闭
net.ipv4.tcp_fin_timeout = 30
#表示如果套接字由本端要求关闭，这个参数决定了它保持在FIN-WAIT-2状态的时间。
net.ipv4.tcp_max_syn_backlog = 8192
#表示SYN队列的长度，默认为1024，加大队列长度为8192，可以容纳更多等待连接的网络连接数。
net.ipv4.tcp_max_tw_buckets = 5000
#表示系统同时保持TIME_WAIT套接字的最大数量，如果超过这个数字，TIME_WAIT套接字将立刻被清除并打印警告信息。默认为180000，改为 5000。对于Apache、Nginx等服务器，上几行的参数可以很好地减少TIME_WAIT套接字数量，但是对于Squid，效果却不大。此项参数可以控制TIME_WAIT套接字的最大数量，避免Squid服务器被大量的TIME_WAIT套接字拖死。
