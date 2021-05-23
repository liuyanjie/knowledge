# 架构设计

* [软件架构模式](http://colobu.com/2015/04/08/software-architecture-patterns/)
* [10种常见的软件架构模式](https://www.cnblogs.com/IcanFixIt/p/7518146.html)
* [秒杀系统架构分析与实战](http://hackjutsu.com/2016/01/25/秒杀系统架构分析与实战)
* [秒杀系统设计思路](https://blog.bcmeng.com/post/miaosha.html)

* [开发人员如何成为架构师](https://www.ibm.com/developerworks/cn/webservices/ws-soa-proarch1.html)
* [三种软件工程师——编码员、程序师和架构师](http://www.techug.com/post/3-kind-of-software-engineer.html)
* [如何成为一名高薪架构师？](https://cn.100offer.com/blog/posts/163)

* [从苦逼到牛逼，详解Linux运维工程师的打怪升级之路](http://www.yunweipai.com/archives/22629.html)
* [轻松监控上万台服务器：企业运维监控平台架构设计与实践指南](http://www.yunweipai.com/archives/7554.html)
* [监控体系建设（完整）](http://www.yunweipai.com/archives/15189.html)

* [进大厂必须掌握的50个微服务面试问题](https://cloud.tencent.com/developer/article/1346868)
* [简单聊聊SOA和微服务](https://juejin.im/post/592f87feb123db0064e5ef7c)

## 架构图

* https://en.wikipedia.org/wiki/The_Open_Group_Architecture_Framework
* https://www.opengroup.org/togaf
* https://c4model.com/
* [如何画出一张合格的技术架构图？](https://www.jiqizhixin.com/articles/2019-04-11-22)
* [架构设计实践五部曲](https://www.infoq.cn/profile/1671085/publish)
* http://www.woshipm.com/pmd/1065960.html
* https://cloud.tencent.com/developer/article/1073501
* https://www.freedgo.com/

## 高并发

## LB & Proxy

### HAProxy

### Nginx

### Varnish

## 高可用

### KeepAlive

Keepalived 是一个基于VRRP协议来实现的LVS服务高可用方案，可以利用其来避免单点故障。实现IP漂移。

多个物理路由构成一个组，对外表现为一个虚拟IP和虚拟MAC，其中一台为Master，其余为Backup。虚拟MAC地址格式为`00-00-5E-00-01-[VRID]`，这个地址同一时间只被一个路由器使用。在虚拟路由器里面的物理路由器组里面通过多播IP地址 224.0.0.18 来定时发送通告消息。优先级最高的路由器即为Master，所以可以通过调节优先级来调整Master节点。多个物理路由器之间通过VRRP协议协商，VRRP通告(advertisement)。

MASTER其中一个职责就是响应VIP的arp包，将VIP和mac地址映射关系告诉局域网内其他主机，同时，它还会以多播的形式（目的地址224.0.0.18）向局域网中发送VRRP通告，告知自己的优先级。网络中的所有BACKUP节点只负责处理MASTER发出的多播包，当发现MASTER的优先级没自己高，或者没收到MASTER的VRRP通告时，BACKUP将自己切换到MASTER状态，然后做MASTER该做的事：1.响应arp包，2.发送VRRP通告。

Heartbeat、Corosync

* [Keepalived原理与实战精讲](http://xstarcd.github.io/wiki/sysadmin/keepalived_Principles.html)
* [小谈keepalived vip漂移原理与VRRP协议](http://hugnew.com/?p=745)
* [VRRP协议介绍](http://www.361way.com/vrrp/5206.html)
* [Nginx+Keepalived实现站点高可用](http://seanlook.com/2015/05/18/nginx-keepalived-ha/)
* [keepalived + nginx 初步实现高可用](https://klionsec.github.io/2017/12/23/keepalived-nginx/)

## 日志

## 监控

## 服务发现
