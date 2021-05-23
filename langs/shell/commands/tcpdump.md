# tcpdump

## 简介

tcpdump 是一款 Linux 平台上的被广泛使用的抓包工具，它可以抓取覆盖整个TCP/IP协议族的数据包，支持多种类型的过滤条件以及逻辑语句。

tcpdump 内部主要依赖 libpcap 和 LibreSSL 来实现。

相关软件库：libnet、libpcap

## 命令参数

```sh
➜ tcpdump -h
tcpdump version tcpdump version 4.9.3 -- Apple version 83.200.3
libpcap version 1.9.1
LibreSSL 2.2.7
Usage: tcpdump [-aAbdDefhHIJKlLnNOpqStuUvxX#] [ -B size ] [ -c count ]
                [ -C file_size ] [ -E algo:secret ] [ -F file ] [ -G seconds ]
                [ -i interface ] [ -j tstamptype ] [ -M secret ] [ --number ]
                [ -Q in|out|inout ]
                [ -r file ] [ -s snaplen ] [ --time-stamp-precision precision ]
                [ --immediate-mode ] [ -T type ] [ --version ] [ -V file ]
                [ -w file ] [ -W filecount ] [ -y datalinktype ] [ -z postrotate-command ]
                [ -g ] [ -k ] [ -o ] [ -P ] [ -Q meta-data-expression]
                [ --apple-tzo offset] [--apple-truncate]
                [ -Z user ] [ expression ]

```

* -A 只使用 ASCII 打印报文的全部数据，不要和 -X 一起使用，获取 http 可以用 tcpdump -nSA port 80
* -b 在数据链路层上选择协议，包括 ip, arp, rarp, ipx 等
* -c 指定要抓取包的数量
* -D 列出操作系统所有可以用于抓包的接口
* -e 输出链路层报头
* -i 指定监听的网卡，-i any 显示所有网卡
* -n 表示不解析主机名，直接用 IP 显示，默认是用 hostname 显示
* -nn 表示不解析主机名和端口，直接用端口号显示，默认显示是端口号对应的服务名
* -p 关闭接口的混杂模式
* -P 指定抓取的包是流入的包还是流出的，可以指定参数 in, out, inout 等，默认是 inout
* -q 快速打印输出，即只输出少量的协议相关信息
* -s len 设置要抓取数据包长度为 len，默认只会截取前 96bytes 的内容，-s 0 的话，会截取全部内容。
* -S 将 TCP 的序列号以绝对值形式输出，而不是相对值
* -t 不要打印时间戳
* -vv 输出详细信息（比如 tos、ttl、checksum等）
* -X 同时用 hex 和 ascii 显示报文内容
* -XX 同 -X，但同时显示以太网头部

tcpdump 支持参数对抓包行为进行控制，同时也支持导入和导出文件

## 过滤器

过滤器简单可分为三类：协议（proto）、传输方向（direction）和类型（type）

一般命令格式：

```
tcpdump [options] [not] [proto] [direction] [type]
```

proto: ip, arp, rarp, tcp, udp, icmp, ether，可选，默认为全部
direction: src, dst, src or dst, src and dst，可选，默认为 src or dst
type: host, net, port, portrange，可选，默认为 host

### 常用过滤操作

1. 抓取指定主机（host）的数据包，包括收发

抓取主机上所有收到（DST_IP）和发出（SRC_IP）的数据包

```sh
tcpdump host 192.168.0.1
```

指定网络接口

```sh
tcpdump -i eth0 host 192.168.0.1
```

指定方向

```sh
tcpdump -i eth0 src host 192.168.0.1
```

```sh
tcpdump -i eth0 dst host 192.168.0.1
```

```sh
tcpdump -i eth0 src or dst host 192.168.0.1
```

2. 抓取指定端口（port）上的数据包

```sh
tcpdump port 22
```

```sh
tcpdump -i eth0 port 22
```

```sh
tcpdump -i eth0 src port 22
```

```sh
tcpdump -i eth0 dst port 22
```

3. 抓取指定网络（网段）的数据包

```sh
tcpdump -i eth0 net 172.18.82
```

```sh
tcpdump -i eth0 src net 172.18.82
```

```sh
tcpdump -i eth0 dst net 172.18.82
```

tcpdump -i eth0 dst port 80


1. 抓取指定协议的数据包

```sh
tcpdump -i eth0 icmp
tcpdump -i eth0 ip
tcpdump -i eth0 tcp
tcpdump -i eth0 udp
tcpdump -i eth0 arp
```

5. 过滤逻辑表达式

https://cloud.tencent.com/developer/article/1432605
https://cloud.tencent.com/developer/article/1464243
https://www.hi-linux.com/posts/5198.html

```sh
nstat -z -t 1 | grep -e TcpExtTCPSynRetrans -e TcpRetransSegs  -e TcpOutSegs -e TcpInSegs
```

```sh
ss -anti | grep -B 1 retrans
```

lnstat

tcpreplay TCP重放工具

pfctl

tcpdump -vv -i eth0 -s0 tcp port 80 -w tcpdump.pcap

tcpdump -i eth0 -s0 -G 3 -W 1 -Z root tcp port 80 -w tcpdump.pcap
tcpdump -i eth0 -s0 -G 30 -W 1 -Z root tcp port 80 -w tcpdump.pcap

tcpdump -i eth0 'tcp port 80 and tcp[tcpflags] & tcp-syn != 0'
tcpdump -i eth0 'tcp port 80 and tcp[tcpflags] & tcp-ack != 0'
tcpdump -i eth0 'tcp port 80 and (tcp[tcpflags] & tcp-syn != 0 AND tcp[tcpflags] & tcp-ack != 0)'
tcpdump -i eth0 'tcp port 80 and (tcp[tcpflags] & tcp-syn != 0 or tcp[tcpflags] & tcp-ack != 0)'

https://www.cnblogs.com/chenpingzhao/p/9108570.html

抓包 5 分钟
tcpdump -s0 -G 300 -W 1 -Z root -vv -i eth0 'tcp port 80 or port 443' -w tcpdump-$(date +"%Y%m%d-%H%M%S").pcap
tcpdump -i eth0 'tcp port 80 or port 443'

抓包 10 分钟
tcpdump -s0 -G 600 -W 1 -Z root -vv -i eth0 tcp port 80 -w /data/home/ulyssesliu/package-tcpdump-$(date +"%Y%m%d-%H%M%S").pcap

tcpdump -s0 -G 600 -W 1 -Z root -vv -i eth0 'tcp port 80 or port 443' -w tcpdump-$(hostname)-$(date +"%Y%m%d-%H%M%S").pcap

抓包 30 分钟
tcpdump -s0 -G 1800 -W 1 -Z root -vv -i eth0 'tcp port 80 or port 443' -w tcpdump-$(date +"%Y%m%d-%H%M%S").pcap

抓包 60 分钟
tcpdump -s0 -G 3600 -W 1 -Z root -vv -i eth0 'tcp port 80 or port 443' -w tcpdump-$(date +"%Y%m%d-%H%M%S").pcap

(ip.dst_host == 9.77.160.167 && tcp.dstport == 80) || (ip.src_host == 9.77.160.167 && tcp.dstport != 80)
(ip.dst_host == 9.77.160.167 && tcp.dstport == 443) || (ip.src_host == 9.77.160.167 && tcp.dstport != 443)

tcpdump -s0 -G 600 -W 1 -Z root -vv -i eth0 'tcp port 80 or port 443' -w tcpdump-$(hostname)-$(date +"%Y%m%d-%H%M%S").pcap
tcpdump -s0 -G 6 -W 1 -Z root -vv -i eth0 'tcp port 80 or port 443' -w tcpdump-$(hostname)-$(date +"%Y%m%d-%H%M%S").pcap


TCP三次握手故障分析
握手失败一般分两种类型，要么被拒绝，要么是丢包了。用两道过滤表达式可以定位出大多数失败的握手。

表达式1：`(tcp.flags.reset == 1) && (tcp.seq == 1)` 过滤出Seq号为1，且含有Reset标志的包，在启用 `Relative Sequence Numbers` 以后，就可以用来过滤握手请求被对方拒绝的数据。再通过 `Follow TCP Stream` 就可以把失败的全过程显示出来。

表达式2：`(tcp.flags.syn == 1) && tcp.analysis.retransmission` 这道表达式可以过滤出重传的握手请求。一个握手请求之所以要重传，往往是因为对方没收到，或者对方回复的确认包丢了。同样通过 `Follow TCP Stream` 就可以把失败的全过程显示出来。
