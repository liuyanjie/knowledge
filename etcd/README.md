# Etcd

[高可用分布式存储 etcd 的实现原理](https://draveness.me/etcd-introduction)

vim /etc/etcd/etcd.conf

```sh
$ /export/etcd/etcd \
  --name infra0 \
  --initial-advertise-peer-urls http://192.168.16.227:2380 \
  --listen-peer-urls http://192.168.16.227:2380 \
  --listen-client-urls http://192.168.16.227:2379,http://127.0.0.1:2379 \
  --advertise-client-urls http://192.168.16.227:2379 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster infra0=http://192.168.16.227:2380,infra1=http://192.168.16.228:2380,infra2=http://192.168.16.229:2380 \
  --initial-cluster-state new
```

```sh
$ /export/etcd/etcd \
  --name infra1 \
  --initial-advertise-peer-urls http://192.168.16.228:2380 \
  --listen-peer-urls http://192.168.16.228:2380 \
  --listen-client-urls http://192.168.16.228:2379,http://127.0.0.1:2379 \
  --advertise-client-urls http://192.168.16.228:2379 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster infra0=http://192.168.16.227:2380,infra1=http://192.168.16.228:2380,infra2=http://192.168.16.229:2380 \
  --initial-cluster-state new
```

```sh
$ /export/etcd/etcd \
  --name infra2 \
  --initial-advertise-peer-urls http://192.168.16.229:2380 \
  --listen-peer-urls http://192.168.16.229:2380 \
  --listen-client-urls http://192.168.16.229:2379,http://127.0.0.1:2379 \
  --advertise-client-urls http://192.168.16.229:2379 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster infra0=http://192.168.16.227:2380,infra1=http://192.168.16.228:2380,infra2=http://192.168.16.229:2380 \
  --initial-cluster-state new
```
