# 网络

网络虚拟化的本质是实现对底层物理网络的抽象，能够在逻辑上进行更细粒度的资源管理和划分，从而满足各类不同网络需求。

device -> LAN -> WAN -> ISP -> Internet

三层网络架构：接入交换机、汇聚交换机、核心交换机

核心层：核心层是网络的高速交换主干，对整个网络的连通起到至关重要的作用。核心层应该具有如下几个特性：可靠性、高效性、冗余性、容错性、可管理性、适应性、低延时性等。因为核心层是网络的枢纽中心，重要性突出。核心层设备采用双机冗余热备份是非常必要的，也可以使用负载均衡功能，来改善网络性能。
汇聚层：汇聚层是网络接入层和核心层的“中介”，就是在有线终端接入核心层前先做汇聚，以减轻核心层设备的负荷。汇聚层必须能够处理来自接入层设备的所有通信量，并提供到核心层的上行链路，因此汇聚层交换机与接入层交换机比较，需要更高的性能，更少的接口和更高的交换速率。在汇聚层中，应该采用支持三层交换技术和VLAN的交换机，以达到网络隔离和分段的目的。
接入层：通常将网络中直接面向用户连接或访问网络的部分称为接入层，接入层目的是允许终端用户连接到网络，因此接入层交换机具有低成本和高端口密度特性。我们在接入层设计上主张使用性能价格比高的设备。接入层是最终用户与网络的接口，它应该提供即插即用的特性，同时应该非常易于使用和维护。一般POE交换机是直接接终端供电，所以POE交换机是作为接入层交换机。

[Linux虚拟网络设备](https://morven.life/notes/networking-2-virtual-devices/)
[DockOne技术分享（五）：Docker网络详解及Libnetwork前瞻](https://community.qingcloud.com/topic/390/DockOne技术分享（五）：Docker网络详解及Libnetwork前瞻)
[流量控制](https://feisky.gitbooks.io/sdn/linux/tc.html)
[eBPF](https://feisky.gitbooks.io/sdn/linux/bpf/)
[XDP](https://feisky.gitbooks.io/sdn/linux/XDP/)
[Linux网络](https://feisky.gitbooks.io/sdn/linux/)
[Macvlan](https://juejin.im/post/5ca183ad6fb9a05e5343a7e8)

[什么是VXLAN](https://support.huawei.com/enterprise/zh/doc/EDOC1100087027)
[什么是EVPN](https://support.huawei.com/enterprise/zh/doc/EDOC1100164807)
[数据中心架构ToR和EoR【总结】](https://www.cnblogs.com/anker/p/8998904.html)

[VXLAN之VTEP网关旁挂式方案部署（二）](https://zhuanlan.zhihu.com/p/105678126)

[软件定义网络](https://www.zhihu.com/column/software-defined-network)
[攻城狮小站](https://www.zhihu.com/column/Network-GongChengShi)

[单播、多播（组播）和广播的区别](https://www.jianshu.com/p/164ab8a6e6a9)

https://cshihong.github.io/2018/04/15/VXLAN%E5%9F%BA%E6%9C%AC%E6%A6%82%E8%BF%B0/
https://www.sdnlab.com/17843.html
https://zhuanlan.zhihu.com/p/78018424
https://zhuanlan.zhihu.com/p/78025180
https://zhuanlan.zhihu.com/p/78033556
https://zhuanlan.zhihu.com/p/78054438

https://zhuanlan.zhihu.com/p/35616289

[隧道和网络虚拟化:NVGRE vs VXLAN](https://www.sdnlab.com/11819.html)
[云数据中心网络虚拟化——大二层技术巡礼之NVo3技术端到端隧道](https://www.sdnlab.com/15820.html)

## WAN 广域网

## LAN 局域网

### VLAN 虚拟局域网

### VxLAN 扩展虚拟局域网

### 构建大型二层网络

为什么需要构建大型二层网络？

1. 传统的二层网络规模太小？

如何构建大型二层网络？

为什么需要使用 VxLAN 构建大型二层网络？

underlay vs overlay network？
