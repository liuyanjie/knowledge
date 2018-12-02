# 数据库

[db-engines](https://db-engines.com/en/)

## MySQL

## MongoDB

## Redis

* [天下无难试之Redis面试题刁难大全](https://zhuanlan.zhihu.com/p/32540678)
* [Redis应用场景](https://www.scienjus.com/redis-use-case/)
* [pubsub](http://redisbook.readthedocs.io/en/latest/feature/pubsub.html)
* [史上最全Redis面试题及答案。](https://www.jianshu.com/p/85d55f2ffd0a)
* [深入剖析 redis 主从复制](http://daoluan.net/linux/学习总结/网络编程/2014/04/22/decode-redis-replication.html)
* [Redis的主从复制集群实现](https://blog.csdn.net/qq_27754983/article/details/78007438)

* Redis持久化，快照（RDB文件）和追加式文件（AOF文件），SAVE，BGSAVE
* Redis高可用，Redis-Sentinel

单节点主备

服务端分片 redis-cluster
中间件分片 twemproxy、codis
客户端分片 

哨兵 redis-sentinel

### etcd

Ralf算法 vs Paxos协议

在Raft中，问题分解为：领导选取、日志复制、安全和成员变化。

强一致性(Ralf算法)、高可用

* [ETCD应用场景](https://tonydeng.github.io/2015/10/19/etcd-application-scenarios/)
* [etcd 服务注册与发现](http://ralphbupt.github.io/2017/05/04/etcd-服务注册与发现/)
* [Etcd 架构与实现解析](http://jolestar.com/etcd-architecture/)
