# Linux 内核参数优化

http://www.chengweiyang.cn/2017/02/18/linux-connect-timeout/
http://blog.qiusuo.im/blog/2014/03/19/tcp-timeout/

## TIME_WAIT

TIME_WAIT 状态是主动关闭的一方在 close 之后最终进入的状态，如果服务器端是主动关闭的，那么服务器端需要关注 TIME_WAIT 状态过多的问题，如果服务器端是被动关闭的，则不会出现 TIME_WAIT 过多。如果服务器端是被动关闭的，TIME_WAIT 仍然很大，则在服务器端存在 主动发起的调用并且最后还主动关闭了，如网络爬虫等。

TIME_WAIT 的作用：

1. 防止前一个连接延迟的数据被后面复用的连接错误的接收；
2. 可靠的关闭TCP连接；

TIME_WAIT 过多的影响：

内核维护连接状态哈希表，如果 TIME_WAIT 过多，将会占用一定内存，同时每次找到一个随机端口的时间需要遍历，消耗一定的CPU

TIME_WAIT 很多，既占内存又耗CPU，但其实进一步研究，1万条TIME_WAIT连接，也就多消耗 1M 左右的内存，对于现在的服务器来说已经不算什么。至于CPU，也不至于因为1万多的hash item就担忧。最起码在 TIME_WAIT 达到几千的量级上不必过多紧张，因为 TIME_WAIT 所占用的内存很少很少，同时记录和寻找可用的 local port 所消耗的CPU也基本可以忽略。

## TIME_WAIT 优化

```
net.ipv4.tcp_tw_reuse = 1    # reuse TIME_WAIT
net.ipv4.tcp_tw_recycle = 1  # 快速回收 TIME_WAIT
net.ipv4.tcp_timestamps = 1  # 上述两项生效的前提是TCP连接两端都要启用TCP时间戳
```

开启 net.ipv4.tcp_tw_recycle 的副作用：

在 客户端 -> 服务端 1:1 连接时是没有问题的

在 客户端 * N -> NAT -> 服务端 N:1 连接时，当客户端 IP 是经过 NAT 转换过的地址，或是服务器在 NAT模式 的负载均衡后面时，源地址为同一IP恰巧先后两次连接源端口相同（快速回收，相同的概率会提高），服务器先后收到两个来源相同（IP:PORT）的包，第二个到达的包的时间戳可能比第一个到达的小，这被认为是过期的包，服务器基于PAWS，认为是重复的报文，丢弃，并不会回ACK包。

一般用作客户端的服务更有可能面对 TIME_WAIT 过多的问题，主动关闭的服务端 也会面临同样问题。
在优化过程中，客户端还面临调用链路是否穿越 NAT 的问题，如果经过 NAT，则要慎重进行快速回收的优化。
一般内网服务器访问公网很可能会经过 NAT 网关，目标服务也可能部署在 NAT 模式的负载均衡之后。

LVS 支持 NAT TUN DR 模式的负载均衡

查询因时间戳过期而被丢弃的报文：

```sh
netstat -s | grep timestamp
packets rejects in established connections because of timestamp
```

如何配置 net.ipv4.tw_recycle

方案一：负载均衡服务器首先关闭连接

在这种情况下，因为负载均衡服务器对 Web 服务器的连接（注意，负载均衡器向Web服务器发起的主动连接），TIME_WAIT大都出现在负载均衡服务器上

负载均衡服务器上的配置：

```
net.ipv4.tcp_tw_reuse = 1   // 尽量复用连接
net.ipv4.tcp_tw_recycle = 0 // 不能保证客户端不在NAT的网络
```

在Web服务器上的配置为：

```
net.ipv4.tcp_tw_reuse = 1     // 这个配置主要影响的是Web服务器到DB服务器的连接复用
net.ipv4.tcp_tw_recycle = 0   // 设置成1和0都没有任何意义。想一想，在负载均衡和它的连接中，它是服务端，但是 TIME_WAIT 出现在负载均衡服务器上；它和DB的连接，它是客户端，recycle对它并没有什么影响，关键是 reuse
```

方案二：WEB 服务器首先关闭来自负载均衡服务器的连接

在这种情况下，Web 服务器变成 TIME_WAIT 的重灾区。负载均衡对Web服务器的连接，由Web服务器首先关闭连接，TIME_WAIT出现在Web服务器上；Web服务器对DB服务器的连接，由Web服务器关闭连接，TIME_WAIT也出现在它身上。

负载均衡服务器上的配置：

```
net.ipv4.tcp_tw_reuse = 0  // 或者 1 都行，都没有实际意义
net.ipv4.tcp_tw_recycle= 0 // 一定是关闭recycle
```

在Web服务器上的配置：

```
net.ipv4.tcp_tw_reuse = 1 // 这个配置主要影响的是Web服务器到DB服务器的连接复用
net.ipv4.tcp_tw_recycle=1 // 由于在负载均衡和Web服务器之间并没有NAT的网络，可以考虑开启recycle，加速由于负载均衡和Web服务器之间的连接造成的大量TIME_WAIT
```

https://tools.ietf.org/html/rfc793
https://blog.oldboyedu.com/tcp-wait/


TIME_WAIT 按 2MSL 回收，约 60s。客户端端口不重用，则 60000/60 = 1000QPS

NOTE: net.ipv4.tcp_tw_recycle has been removed from Linux 4.12.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4396e46187ca5070219b81773c4e65088dac50cc
