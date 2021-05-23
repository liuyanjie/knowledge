# 网络问题诊断

1. 网卡驱动层

* Ring Buffer溢出
https://www.sdnlab.com/17530.html

物理介质上的数据帧到达后首先由NIC（网络适配器）读取，写入设备内部缓冲区 Ring Buffer 中，再由中断处理程序触发 Softirq 从中消费，Ring Buffer 的大小因网卡设备而异。当网络数据包到达（生产）的速率快于内核处理（消费）的速率时，Ring Buffer很快会被填满，新来的数据包将被丢弃。

通过 ethtool 或/proc/net/dev可以查看因 Ring Buffer 满而丢弃的包统计，在统计项中以fifo标识：

* netdev_max_backlog 溢出

netdev_max_backlog 是内核从 NIC 收到包后，交由协议栈（如IP、TCP）处理之前的缓冲队列。每个CPU核都有一个 backlog 队列，与 Ring Buffer 同理，当接收包的速率大于内核协议栈处理的速率时，CPU的 backlog 队列不断增长，当达到设定的 netdev_max_backlog 值时，数据包将被丢弃。

```sh
# cat /proc/net/softnet_stat
0a3f4401 00000000 00000016 00000000 00000000 00000000 00000000 00000000 00000000 00000000
65e48c23 00000000 0000232c 00000000 00000000 00000000 00000000 00000000 00000000 166ac905
6c181790 00000000 000023a9 00000000 00000000 00000000 00000000 00000000 00000000 1714d653
6d392085 00000000 000025ba 00000000 00000000 00000000 00000000 00000000 00000000 1703301d
6490037b 00000000 0000225d 00000000 00000000 00000000 00000000 00000000 00000000 167403f7
688f24f7 00000000 00002199 00000000 00000000 00000000 00000000 00000000 00000000 16a06d51
68fe693b 00000000 00002254 00000000 00000000 00000000 00000000 00000000 00000000 17050d6a
693dc945 00000000 0000205f 00000000 00000000 00000000 00000000 00000000 00000000 16ff0369
```

每一行代表每个 CPU 核的状态统计，从 CPU0 依次往下；
每一列代表一个 CPU 核的各项统计：第一列代表中断处理程序收到的包总数；第二列即代表由于 netdev_max_backlog 队列溢出而被丢弃的包总数。
从上面的输出可以看出，这台服务器统计中，并没有因为 netdev_max_backlog 导致的丢包。

```sh
# sysctl -a | grep "net.core.netdev_max_backlog"
net.core.netdev_max_backlog = 1000

# sysctl -w net.core.netdev_max_backlog=2000
```

```sh
# sysctl -a | grep "net.core.netdev_budget"

```

查看网卡流量

https://github.com/vgropp/bwm-ng

https://www.binarytides.com/linux-commands-monitor-network/1396760712/

* 反向路由过滤

```sh
cat /proc/sys/net/ipv4/conf/eth0/rp_filter
1
```

```
$ sysctl -w net.ipv4.conf.all.rp_filter=2

$ sysctl -w net.ipv4.conf.eth0.rp_filter=2
```


* 查看半连接队列

```
netstat -ant | grep SYN_RECV | wc -l
```

```
sysctl -a | grep "net.ipv4.tcp_max_syn_backlog"
net.ipv4.tcp_max_syn_backlog = 4096

sysctl -w net.ipv4.tcp_max_syn_backlog
```

netstat -s | grep -e "passive connections rejected because of time stamp" -e "packets rejects in established connections because of timestamp"

netstat -s | grep socket


https://www.cnblogs.com/derekchen/archive/2011/02/26/1965839.html


netstat -apA inet


https://www.cnblogs.com/mauricewei/p/10502300.html
https://blog.packagecloud.io/eng/2016/06/22/monitoring-tuning-linux-networking-stack-receiving-data/
https://blog.csdn.net/fanren224/article/details/89849276
https://zhuanlan.zhihu.com/p/63841157
http://road2ai.info/2017/08/15/Linux-RingBuffer/
https://topic.alibabacloud.com/a/ss-command-and-recv-q-and-send-q-states_8_8_31266407.html
https://102.alibaba.com/detail?id=140
https://zhuanlan.zhihu.com/p/52397230
https://www.sdnlab.com/17530.html
http://jm.taobao.org/2017/05/25/525-1/
https://ylgrgyq.github.io/2017/07/23/linux-receive-packet-1/

https://wsgzao.github.io/post/lvs/
https://wsgzao.github.io/post/keepalived/

http://arthurchiao.art/blog/deep-dive-into-iptables-and-netfilter-arch-zh/
https://www.qikqiak.com/post/how-to-use-ipvs-in-kubernetes/
https://vincent.bernat.ch/en/blog/2014-tcp-time-wait-state-linux
https://blog.yangx.site/2018/07/03/tcp-ip-time-wait/

lvs keepalive VRRP ipvs netfilter/iptables nginx haproxy httpd

https://wiki.linuxchina.net/index.php/Tcp_tw_recycle%E6%89%93%E5%BC%80%E5%AF%BC%E8%87%B460s%E5%86%85%E4%B8%8D%E8%83%BD%E4%B8%A4%E4%B8%AA%E7%94%A8%E6%88%B7%E5%90%8C%E6%97%B6%E7%99%BB%E5%BD%95
https://wangtaox.github.io/2016/10/14/tcp-tw-recycle.html
https://www.cnblogs.com/sjjg/p/5830009.html
https://www.cnblogs.com/sjjg/p/5830082.html


https://blog.csdn.net/yangguosb/article/details/89853045
