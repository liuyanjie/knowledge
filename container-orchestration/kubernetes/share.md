# Kubernetes Knowledge

* 主要涉及 Kubernetes 安装部署、架构、概念等
* 本文档也只能起到入门作用，进一步学习需要实践
* 为了能够将内容记录下来，以下文档中的文字比较多

## 参考内容

Article:

* [What is Kubernetes?](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)
* [Kubernetes中文手册](https://www.kubernetes.org.cn/k8s)
* [KUB/Kubernetes](https://wiki.shileizcc.com/display/KUB/Kubernetes)
* [Kubernetes 指南](https://www.gitbook.com/book/feisky/kubernetes/details)
* [开源容器集群管理系统Kubernetes架构及组件介绍](https://segmentfault.com/a/1190000002620946)
* [十分钟带你理解Kubernetes核心概念](http://dockone.io/article/932)
* [理解Kubernetes核心概念](https://www.hi-linux.com/posts/3592.html)
* [Kubernetes基础篇：主要特性、基本概念与总体架构](http://shiyanjun.cn/archives/1671.html)
* [玩转Docker Network](http://dockone.io/article/393)
* [kubernetes之网络分析](http://blog.cuicc.com/blog/2017/04/30/kubernetes-network/)
* [netfilter/iptables简介](https://segmentfault.com/a/1190000009043962)
* [iptables 详解](https://www.zfl9.com/iptables.html)
* [iptables](http://vcpu.me/iptables/)
* [Kubernetes网络原理及方案](http://www.youruncloud.com/blog/131.html)
* [图解Kubernetes网络（一）](http://dockone.io/article/3211)
* [Kubernetes Nginx Ingress 教程](https://mritd.me/2017/03/04/how-to-use-nginx-ingress/)
* [详解Kubernetes高可用负载均衡与集群外服务访问实践](http://www.qingpingshan.com/m/view.php?aid=333074)
* [什么是服务网格以及为什么我们需要服务网格？](http://www.infoq.com/cn/news/2017/11/WHAT-SERVICE-MESH-WHY-NEED)
* [模式之服务网格，服务啮合层](http://www.infoq.com/cn/articles/pattern-service-mesh)
* [什么是Service Mesh（服务网格）](https://jimmysong.io/posts/what-is-a-service-mesh/)
* [Service Mesh服务网格新生代--Istio](http://dockone.io/article/2731)

Blogs:

* [Jimmy Song（宋净超）](https://jimmysong.io/)
* [tonybai](http://tonybai.com/)

## 简介

### 功能用途

Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications.

Kubernetes是一个开源系统，用于 `容器化应用程序` 的 自动化部署、扩展、管理。

> It groups containers that make up an application into logical units for easy management and discovery. Kubernetes builds upon 15 years of experience of running production workloads at Google, combined with best-of-breed ideas and practices from the community.

> 它将组成应用程序的容器分组为逻辑单元，以便于管理和发现。Kubernetes建立在 Google 15年运行生产工作负载的经验基础上，结合社区最佳的创意和实践。

Kubernetes: Finally… A True Cloud Platform

Kubernetes Features：

* Automatic binpacking
* Self-healing 自愈的
* Horizontal scaling 水平伸缩
* Service discovery and load balancing 服务发现和负载均衡
* Automated rollouts and rollbacks 自动发布和回滚
* Secret and configuration management 私密信息和配置信息管理
* Storage orchestration 存储编排
* Batch execution 批量执行

### 发展历史

Kubernetes建立在15年在Google上运行生产工作负载的经验基础上，结合了社区最佳的创意和实践。

在Docker作为容器引擎快速发展的同时，Google也开始将自身在容器技术及集群方面的积累贡献出来。在Google内部，容器技术已经应用了很多年，Borg系统运行管理着成千上万的容器应用，在它的支持下，无论是谷歌搜索、GMail还是谷歌地图，可以轻而易举地从庞大的数据中心中获取技术资源来支撑服务运行。

Borg是集群的管理器，在它的系统中，运行着众多集群，而每个集群可由成千上万的服务器联接组成，Borg每时每刻都在处理来自众多应用程序所提交的成百上千的Job, 对这些Job进行接收、调度、启动、停止、重启和监控。正如Borg论文中所说，Borg提供了3大好处:

1. 隐藏资源管理和错误处理，用户仅需要关注应用的开发。
2. 服务高可用、高可靠。
3. 可将负载运行在由成千上万的机器联合而成的集群中。

Kubernetes项目来源于Borg，可以说是集结了Borg设计思想的精华，并且吸收了Borg系统中的经验和教训。

作为Google的竞争技术优势，Borg理所当然的被视为商业秘密隐藏起来，但当Tiwtter的工程师精心打造出属于自己的Borg系统（Mesos）时， Google也审时度势地推出了来源于自身技术理论的新的开源工具。

2014年6月，谷歌云计算专家埃里克·布鲁尔（Eric Brewer）在旧金山的发布会为这款新的开源工具揭牌，它的名字Kubernetes在希腊语中意思是船长或领航员，这也恰好与它在容器集群管理中的作用吻合，即作为装载了集装箱（Container）的众多货船的指挥者，负担着全局调度和运行监控的职责。

Kubernetes作为容器集群管理工具，于2015年7月22日迭代到v1.0并正式对外公布，这意味着这个开源容器编排系统可以正式在生产环境使用。与此同时，谷歌联合Linux基金会及其他合作伙伴共同成立了CNCF基金会(Cloud Native Computing Foundation)，并将Kuberentes作为首个编入CNCF管理体系的开源项目，助力容器技术生态的发展进步。Kubernetes项目凝结了Google过去十年间在生产环境的经验和教训，从Borg的多任务Alloc资源块到Kubernetes的多副本Pod，从Borg的Cell集群管理，到Kubernetes设计理念中的联邦集群，在Docker等高级引擎带动容器技术兴起和大众化的同时，为容器集群管理提供独了到见解和新思路。

Kubernetes已经成为容器编排调度的实际标准，不论Docker官方还是Mesos都已经支持Kubernetes，Docker公司在2017年10月16日至19日举办的DockerCon EU 2017大会上宣布支持Kubernetes调度，就在这不久前Mesos的商业化公司Mesosphere的CTO Tobi Knaup也在官方博客中宣布Kubernetes on DC/OS。而回想下2016年时，我们还在为Swarm、Mesos、Kubernetes谁能够在容器编排调度大战中胜出而猜测时，而经过不到一年的发展，Kubernetes就以超过70%的市场占有率（据TheNewStack的调研报告）将另外两者遥遥的甩在了身后，其已经在大量的企业中落地，还有一些重量级的客户也宣布将服务迁移到Kubernetes上，比如GitHub（见Kubernetes at GitHub），还有eBay、彭博社等。

Kubernetes自2014年由Google开源以来，至今已经发展到了1.9版本，下面是Kubernetes的版本发布路线图：

* 2014年10月由Google正式开源。
* 2015年7月22日发布1.0版本，在OSCON（开源大会）上发布了1.0版本。
* 2015年11月16日发布1.1版本，性能提升，改进了工具并创建了日益强大的社区。
* 2016年4月16日发布1.2版本，更多的性能升级加上简化应用程序部署和管理。
* 2016年7月22日发布1.3版本，对接了云原生和企业级工作负载。
* 2016年9月26日发布1.4版本，该版本起Kubernetes开始支持不同的运行环境，并使部署变得更容易。
* 2016年12月13日发布1.5版本，该版本开始支持生产级别工作负载。
* 2017年3月28日发布1.6版本，该版本支持多租户和在集群中自动化部署不同的负载。
* 2017年6月29日发布1.7版本，该版本的kubernetes在安全性、存储和可扩展性方面有了很大的提升。
* 2017年9月28日发布1.8版本，该版本中包括了一些功能改进和增强，并增加了项目的成熟度，将强了kubernetes的治理模式，这些都将有利于kubernetes项目的持续发展。
* 2017年12月15日发布1.9版本，该版本最大的改进是Apps Workloads API成为稳定版本，这消除了很多潜在用户对于该功能稳定性的担忧。还有一个重大更新，就是测试支持了Windows了，这打开了在kubernetes中运行Windows工作负载的大门。

Kubernetes的架构做的足够开放，通过系列的接口，如CRI（Container Runtime Interface）作为Kubelet与容器之间的通信接口、CNI（Container Networking Interface)来管理网络、而持久化存储通过各种Volume Plugin来实现，同时Kubernetes的API本身也可以通过CRD（Custom Resource Define）来扩展，还可以自己编写Operator和Service Catalog来基于Kubernetes实现更高级和复杂的功能。

虽然Google推出Kubernetes的目的之一是推广其周边的计算引擎（Google Compute Engine）和谷歌应用引擎（Google App Engine）。但Kubernetes的出现能让更多的互联网企业可以享受到连接众多计算机成为集群资源池的好处。

Kubernetes对计算资源进行了更高层次的抽象，通过将容器进行细致的组合，将最终的应用服务交给用户。Kubernetes在模型建立之初就考虑了容器跨机连接的要求，支持多种网络解决方案，同时在Service层次构建集群范围的SDN（Software Defined Network）网络。其目的是将服务发现和负载均衡放置到容器可达的范围，这种透明的方式便利了各个服务间的通信，并为微服务架构的实践提供了平台基础。而在Pod层次上，作为Kubernetes可操作的最小对象，其特征更是对微服务架构的原生支持。

### 云原生应用

* [CNCF(Cloud Native Computing Foundation)](https://www.cncf.io/)
* [cloud-native](https://pivotal.io/cn/cloud-native)
* [云原生（Cloud Native）](https://feisky.xyz/cloud/native/)
* [The cloud native concepts 云原生概念](http://www.bt91.net/articles/The-cloud-native-concepts(云原生概念)/)
* [什么是云原生应用程序](http://dockone.io/article/591)
* [Kubernetes与云原生应用概览](https://jimmysong.io/posts/kubernetes-and-cloud-native-app-overview/)

云原生应用，是指原生为在云平台上部署运行而设计开发的应用。
通常情况下，大多数传统的应用，不做任何改动，都是可以在云平台运行起来的，只要云平台支持这个传统应用所运行的计算机架构和操作系统。不过这种运行模式，仅仅是把虚拟机当物理机一样使用，本质上并没有太大变化，不能够真正利用起来云平台的能力。

云原生不是一个产品，而是一套技术体系和一套方法论。云原生包括DevOps、持续交付、微服务、敏捷基础设施、康威定律等，以及根据商业能力对公司进行重组的能力，既包含技术、也包含管理，可以说是一系列云技术和企业管理方法的集合，通过实践及与其他工具相结合更好地帮助用户实现数字化转型。

云原生能帮助企业高效、快速、稳定、大量地完成软件交付工作。持续交付、DevOps、微服务是云原生的关键。云原生既有利于塑造团结信任的企业文化，又能有效利用自动化提升工作效率，让良好的运营促进公司更快更稳定地发展。

CNCF(云原生计算基金会)认为云原生系统需包含的属性：

1. 容器化封装：以容器为基础，提高整体开发水平，形成代码和组件重用，简化云原生应用程序的维护。在容器中运行应用程序和进程，并作为应用程序部署的独立单元，实现高水平资源隔离。
2. 自动化管理：统一调度和管理中心，从根本上提高系统和资源利用率，同时降低运维成本。
3. 面向微服务：通过松耦合方式，提升应用程序的整体敏捷性和可维护性。

在Kubernetes出现之前，就已经有人提出了云原生的概念，如2010年 Paul Fremantle 就在他的博客中提出了云原生的核心理念，但是还没有切实的技术解决方案。而那时候PaaS才刚刚出现，PaaS平台提供商Heroku提出了12因素应用的理念，为构建SaaS应用提供了方法论，该理念在云原生时代依然适用。

现如今云已经可以为我们提供稳定的可以唾手可得的基础设施，但是业务上云成了一个难题，Kubernetes的出现与其说是从最初的容器编排解决方案，倒不如说是为了解决应用上云（即云原生应用）这个难题。CNCF中的托管的一系列项目即致力于云原生应用整个生命周期的管理，从部署平台、日志收集、服务网格、服务发现、分布式追踪、监控以及安全等各个领域通过开源的软件为我们提供一揽子解决方案。

### [文档](https://kubernetes.io/docs/home/)

* `Setup` 安装部署Kubernetes集群的说明
* `Concepts` 这部分内容集中讲解Kubernetes中概念，概念非常多。每个概念后边通常会包含概念的应用示例，内容包含在 `Tasks`。
* `Tasks` 这部分内容包含一系列的任务，每个任务都只做一件事情，任务中会涉及多个概念，会链接到 `Concepts`。
* `Tutorials` 教程展示了如何实现比单个任务更大的目标。也会链接到 `Concepts`、`Tasks` 部分
* `Reference` API Reference && CLI Reference && Config Reference ...

文档内容多，内容散，在阅读文档的过程中，经常需要链接到其他地方，去了解其他概念。在阅读文档的初期，很多概念还不是熟悉和了解，就很被大量的概念绕的很晕。但是随着文档的深入阅读，逐步了解了文档的结构，相关文档知道知道在什么位置。更重要的是对文档的内容更加的熟悉，就逐渐的在头脑中构建起了Kubernetes的知识体系。所以在阅读文档的时候需要极大的耐心，一点点的拨云见日。

除官方文档之外，网上还可以找到大量的翻译文档、博客文章及教程可以参考，但是建议以官方文档为主，其他文档辅助学习理解，因为官方文档最新最全最权威。


## Kubernetes Architecture

* https://jimmysong.io/kubernetes-handbook/concepts/
* [Kubernetes设计架构](https://www.kubernetes.org.cn/kubernetes设计架构)

![architecture](https://raw.githubusercontent.com/kubernetes/kubernetes/release-1.2/docs/design/architecture.png)

### Kubernetes Components

#### etcd

etcd 保存了整个集群的状态，所有master的持续状态都存在etcd的一个实例中。因为有watch(观察者)的支持，各部件协调中的改变可以很快被察觉。

[etcd：从应用场景到实现原理的全方位解读](http://www.infoq.com/cn/articles/etcd-interpretation-application-scenario-implement-principle)

#### [kubelet](https://kubernetes.io/docs/reference/generated/kubelet/)

在kubernetes集群中，每个Node节点都需要运行 `kubelet` 服务。

kubelet会在API Server上注册节点信息，定期向 Master 汇报节点资源使用情况，并通过内置cAdvisor监控容器和节点资源。可以把kubelet理解成Server-Agent架构中的Agent。
kubelet 根据 PodSpec 的描述工作，Kubelet获得通过各种机制提供的一组PodSpecs并确保这些PodSpec中描述的容器运行正常。

`kubelet` 提供了一个非常方便的接口来管理容器。Kubelet有一个清单（manifest）字典，每20秒会默认监控一次以更新pod的manifest文件。

除了来自 apiserver 的 PodSpec 之外，容器 manifest 可以通过三种方式提供给Kubelet：

  * File: Path passed as a flag on the command line.
  * HTTP endpoint: HTTP endpoint passed as a parameter on the command line.
  * HTTP server: The kubelet can also listen for HTTP and respond to a simple API to submit a new manifest.

#### kube-apiserver

apiserver提供了资源操作的唯一入口，并提供认证、授权、访问控制、API注册和发现等机制；

#### kube-scheduler

scheduler负责资源的调度，按照预定的调度策略将Pod调度到相应的机器上；即负责 `Pod:Node` 绑定。

#### kube-controller-manager

controller-manager负责维护集群的状态，比如故障检测、自动扩展、滚动更新等；

#### cloud-controller-manager

#### kube-proxy

每一个节点也运行一个简单的网络代理和负载均衡，负责为Service提供cluster内部的服务发现和负载均衡；


## 安装部署

通过 `apt|yum` 安装Kubernetes后会安装以下二进制程序：

* kubeadm
* kubelet

启动 Kubernetes 集群的实际上就是 配置 `kubelet.service` 服务并启动，需要先启动 `docker.service`。
最新的安装方式中不建议直接安装 `etcd` `kube-apiserver` `kube-proxy` 等其他组件，所以这些组件也不再通过 `apt|yum` 源分发，而是打包成Docker镜像，通过容器仓库分发，以容器的方式运行。这种安装方式简化了安装部署过程，不需要启动一系列的服务，更新也更加容易。

`kubeadm` 是一个工具包，可帮助我们按最佳实践一步步启动Kubernetes群集。kubeadm正在活动的开发当中，目前还是 Bata 版本，2018年会发布 GA 版本。通过 `kubeadm` 启动一个 Master 节点之后，可能需要按自己的需求修改默认的配置参数。

集群部署完成之后需要访问集群，需要用到客户端工具：

* kubectl
* [打造高效的Kubernetes命令行终端](https://jimmysong.io/posts/configuring-efficient-kubernetes-cli-terminal/)

### Picking the Right Solution

See: https://kubernetes.io/docs/setup/pick-right-solution

`kubernetes.tar.gz` 中有个 `kubernetes/cluster/kube-up.sh`，实现了文档中列举的全部的部署方案。可以通过参数 `provider` 指定选用的方案。

所有的方案就是 `安装部署方式` 和 `安装部署环境` 的组合，某些方式只在 某些环境下才有。

测试集群搭建方案：

* minikube
* Setting up a kubernetes cluster with Vagrant and Virtualbox
* Setting up a kubernetes cluster on Cloud Server

### Bootstrapping Clusters with kubeadm

* [Setup-k8s-on-centos](./setup-k8s-on-centos.md)

遇到的问题的解决方法：首先要仔细阅读安装文档，避免操作错误，安装过程中观察 `kubeadm`、`kubelet`、`kube-apiserver` 的日志，日志当中会包含错误信息，常见问题google一下很容易就找到解决方案了。

### Building High-Availability Clusters

![General architecture](https://raw.githubusercontent.com/kubernetes/kubernetes/release-1.2/docs/design/architecture.png)

![Building High-Availability architecture](http://d33wubrfki0l68.cloudfront.net/2555d34e3008aab4b049ca5634cfabc2078ccf92/3269a/images/docs/ha.svg)

高可用集群的核心内容：

* High-Availability Etcd
* High-Availability Kubernetes Master

高可用集群架构中，在多个 `kube-apiserver` 前增加了 `LoadBalancer`。

### Cluster Federation

完整的集群联邦允许将在 不同地区运行的Kubernetes集群 或 不同的云提供商提供的Kubernetes集群 组合到一起。然而，许多用户只是想在其单个云提供商的多个区域中运行更多可用的Kubernetes集群。集群联邦可以提供更高级别的可用性。

## 运维

部署到Kubernetes集群上的服务高度依赖一个高度稳定可靠的Kubernetes集群，如果Kubernetes集群自身不够稳定，在其上运行的服务也很容易楚翔问题。

* 集群监控及健康检查
* 集群资源的管理及分配，计算资源、网络资源、存储资源
* 集群安全
* 集群版本更新
* 其他...

## Hardware Resource

* CPU/MEM计算资源 Node
* Storage存储资源 CSI
* NetWork网络资源 CNI

### Node

```sh
➜  ~ kubectl get nodes/k8s-master1 -o yaml
apiVersion: v1
kind: Node
metadata:
  annotations:
    flannel.alpha.coreos.com/backend-data: '{"VtepMAC":"52:9e:39:7e:e8:73"}'
    flannel.alpha.coreos.com/backend-type: vxlan
    flannel.alpha.coreos.com/kube-subnet-manager: "true"
    flannel.alpha.coreos.com/public-ip: 10.10.157.9
    node.alpha.kubernetes.io/ttl: "0"
    volumes.kubernetes.io/controller-managed-attach-detach: "true"
  creationTimestamp: 2018-01-12T03:20:47Z
  labels:
    beta.kubernetes.io/arch: amd64
    beta.kubernetes.io/os: linux
    kubernetes.io/hostname: k8s-master1
    node-role.kubernetes.io/master: ""
  name: k8s-master1
  resourceVersion: "5747962"
  selfLink: /api/v1/nodes/k8s-master1
  uid: 9502cc4d-f747-11e7-a1e0-525400364556
spec:
  externalID: k8s-master1
  podCIDR: 10.244.0.0/24
  taints:
  - effect: NoSchedule
    key: node-role.kubernetes.io/master
status:
  addresses:
  - address: 10.10.157.9
    type: InternalIP
  - address: k8s-master1
    type: Hostname
  allocatable:
    cpu: "2"
    memory: 3780044Ki
    pods: "110"
  capacity:
    cpu: "2"
    memory: 3882444Ki
    pods: "110"
  conditions:
  - lastHeartbeatTime: 2018-03-05T02:47:35Z
    lastTransitionTime: 2018-01-12T03:20:43Z
    message: kubelet has sufficient disk space available
    reason: KubeletHasSufficientDisk
    status: "False"
    type: OutOfDisk
  - lastHeartbeatTime: 2018-03-05T02:47:35Z
    lastTransitionTime: 2018-01-12T03:20:43Z
    message: kubelet has sufficient memory available
    reason: KubeletHasSufficientMemory
    status: "False"
    type: MemoryPressure
  - lastHeartbeatTime: 2018-03-05T02:47:35Z
    lastTransitionTime: 2018-01-12T03:20:43Z
    message: kubelet has no disk pressure
    reason: KubeletHasNoDiskPressure
    status: "False"
    type: DiskPressure
  - lastHeartbeatTime: 2018-03-05T02:47:35Z
    lastTransitionTime: 2018-01-12T05:55:25Z
    message: kubelet is posting ready status
    reason: KubeletReady
    status: "True"
    type: Ready
  daemonEndpoints:
    kubeletEndpoint:
      Port: 10250
  images:
  - names:
    - gcr.io/google_containers/kube-apiserver-amd64@sha256:f70af327840f10eb0b47b95a9848593958ead9d875f7a01bd7287fc70478e069
    - gcr.io/google_containers/kube-apiserver-amd64:v1.9.1
    sizeBytes: 210386553
  - names:
    - gcr.io/google_containers/etcd-amd64@sha256:28cf78933de29fd26d7a879e51ebd39784cd98109568fd3da61b141257fb85a6
    - gcr.io/google_containers/etcd-amd64:3.1.10
    sizeBytes: 192743523
  nodeInfo:
    architecture: amd64
    bootID: 8b6c7df0-07a1-4b66-97e4-f98ab79124c8
    containerRuntimeVersion: docker://1.12.6
    kernelVersion: 3.10.0-327.22.2.el7.x86_64
    kubeProxyVersion: v1.9.1
    kubeletVersion: v1.9.1
    machineID: f180f4f45ab34cdc85a5a7b5b599b20e
    operatingSystem: linux
    osImage: CentOS Linux 7 (Core)
    systemUUID: 953162D7-58B5-403B-B4CC-B08179094B4C
```

## Kubernetes Api Access

[api](./api.md)

![](https://d33wubrfki0l68.cloudfront.net/673dbafd771491a080c02c6de3fdd41b09623c90/50100/images/docs/admin/access-control-overview.svg)

### Accessing the API

1. 认证 [Authentication](https://kubernetes.io/docs/admin/authentication/)

一旦TLS连接建立成功，HTTP请求进入到认证阶段。

集群的 创建脚本 或者 集群管理 配置 ApiServer 运行一个或多个认证模块

认证模块包括：`Client Certificates`, `Password`, `Plain Tokens`, `Bootstrap Tokens`, `JWT Tokens` .

认证模块可以同时制定多个，在这种情况下，按顺序逐个验证，直到有一个验证通过。

如果请求认证不通过，将会拒绝请求，并返回401状态码。否则，这个用户被认证为 特定的 `username`，并且这个 `username` 被用于后续的决策使用。有些认证模块还提供了用户的 `group` 成员信息，用于后续决策使用。

Kubernetes内部没有 User Object 并且也不存储用户相关信息。

2. 授权 [Authorization](https://kubernetes.io/docs/admin/authorization/)

当请求被鉴定为某个特定的用户之后，将会进入授权阶段，请求必须被授权。

一个请求必须包含请求者的用户名，请求的动作，动作影响的主体对象。请求会被授权执行，如果存在一个策略(`Policy`)声明这个用户有权限执行这个动作。

Kubernetes支持多种授权模块, 如：`ABAC Mode`, `RBAC Mode`, `Webhook Mode`。当创建一个Kubernetes集群，需要配置相应的授权模块。当配置多个授权模块时，任意一个模块授权这个请求，这个请求就可以被执行。如果所有模块都拒绝对这个请求授权，请求将被拒绝，并返回`403`。

3. [Admission Control](https://kubernetes.io/docs/admin/admission-controllers/)

准入控制模块是可以修改请求或拒绝请求的软件模块。除了授权模块可以访问的属性之外，准入控制模块还可以访问将要创建或更新的对象的内容。

准入控制被用做于创建、更新、删除、链接上，但是不用于读取上。

准入控制模块同样支持配置多个，他们将会被依次调用。与授权和认证模块不同，任意一个模块拒绝，请求将会被立刻拒绝执行。

除了拒绝请求之外，准入控制模块将会为对象内容设置复杂的默认值。

### Authenticating

Kubernetes集群有两种类别的用户：`serviceaccount`、`normal users`。

普通用户由外部独立的服务管理，在这种情况下，Kubernetes没有表示普通用户账户的对象存在。普通用户不能通过Api调用添加到集群当中。

相比之下，`serviceaccount` 可以通过 ApiServer 管理，他们绑定到特定的 `namespace` 下，由 Kubernetes 自动创建，也可以通过 Api 调用手动创建。

`serviceaccount` 绑定一组证书并存储到 `Secrets` 中，`Secrets` 会被挂载到 Pods 中允许集群中的进程调用 ServerApi。

Api 请求会被绑定到一个 `normal users`，或者 `serviceaccount`，或者被视为 `anonymous requests`。这就意味着不论是在集群的内部或外部，不论从哪里发出的请求，都需要被认证，或者被当做一个匿名用户。

### Authentication strategies

1. X509 Client Certs `--client-ca-file=SOMEFILE`
2. Static Token File `--token-auth-file=SOMEFILE`
3. Bootstrap Tokens [beta] `--enable-bootstrap-token-auth`
4. Static Password File `--basic-auth-file=SOMEFILE`
5. Service Account Tokens
6. OpenID Connect Tokens
7. Webhook Token Authentication
8. Authenticating Proxy
9. Keystone Password

#### Service Account Tokens

服务帐户是一个自动启用的身份验证器，它使用 被签名的 `bearer tokens` 来验证请求，有两个可选的参数：

```
--service-account-key-file A file containing a PEM encoded key for signing bearer tokens. If unspecified, the API server’s TLS private key will be used.
--service-account-lookup If enabled, tokens which are deleted from the API will be revoked.
```

服务帐户通常由ApiServer自动创建，并且通过 Admission Controller 与运行中的 pods 关联。

Bearer tokens are mounted into pods at well-known locations, and allow in-cluster processes to talk to the API server. Accounts may be explicitly associated with pods using the serviceAccountName field of a PodSpec.

手动创建 serviceaccount

```sh
$ kubectl create serviceaccount jenkins
serviceaccount "jenkins" created
$ kubectl get serviceaccounts jenkins -o yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  # ...
secrets:
- name: jenkins-token-1yvwg

$ kubectl get secret jenkins-token-1yvwg -o yaml
apiVersion: v1
data:
  ca.crt: (APISERVERS CA BASE64 ENCODED)
  namespace: ZGVmYXVsdA==
  token: (BEARER TOKEN BASE64 ENCODED)
kind: Secret
metadata:
  # ...
type: kubernetes.io/service-account-token
```

http://tonybai.com/2017/03/03/access-api-server-from-a-pod-through-serviceaccount/
http://tonybai.com/2016/11/25/the-security-settings-for-kubernetes-cluster/

service account token 存储在 Secret 中，任何有权限读取 这些 secret 的用户都能够用 service account 认证，所以需要很小心的授予 权限。

### Authorization

在Kubernetes中，你必须被认证之后才能被授权。

Kubernetes期望通用的属性。

#### Determine Whether a Request is Allowed or Denied

Kubernetes通过ApiServer对请求进行授权。它根据所有策略评估请求的所有属性，允许或拒绝请求。

一个API请求的所有部分都必须被一些策略所允许才能继续。这意味着权限被默认拒绝。

当配置多个授权模块时，授权模块将会被按顺序逐个检查，如果任何一个授权模块批准或拒绝，决策将会立即返回，其他授权模块不会被考虑。

#### Review Your Request Attributes

* user - The user string provided during authentication.
* group - The list of group names to which the authenticated user belongs.
* “extra” - A map of arbitrary string keys to string values, provided by the authentication layer.
* API - Indicates whether the request is for an API resource.
* Request path - Path to miscellaneous non-resource endpoints like /api or /healthz.
* API request verb - API verbs get, list, create, update, patch, watch, proxy, redirect, delete, and deletecollection are used for resource requests. To * determine the request verb for a resource API endpoint, see Determine the request verb below.
* HTTP request verb - HTTP verbs get, post, put, and delete are used for non-resource requests.
* Resource - The ID or name of the resource that is being accessed (for resource requests only) – For resource requests using get, update, patch, and delete verbs, you must provide the resource name.
* Subresource - The subresource that is being accessed (for resource requests only).
* Namespace - The namespace of the object that is being accessed (for namespaced resource requests only).
* API group - The API group being accessed (for resource requests only). An empty string designates the core API group.

#### Determine the Request Verb

#### Authorization Modules

* Node - 一种特殊用途授权者，根据他们pod被调度授予kubelet权限。
* ABAC - 基于角色的访问控制，ABAC被一些人称为是权限系统设计的未来，用户属性（如用户年龄），环境属性（如当前时间），操作属性（如读取）和对象属性（如一篇文章，又称资源属性），所以理论上能够实现非常灵活的权限控制，几乎能满足所有类型的需求。`--authorization-mode=ABAC --authorization-policy-file=SOME_FILENAME`
* RBAC - 基于属性的访问控制，用户，组，角色，资源|对象，权限。`--authorization-mode=RBAC`
* Webhook - A WebHook is an HTTP callback

### Admission Control

## Kubernetes Api Object

[api-concepts](https://kubernetes.io/docs/reference/api-concepts/)

REST API 是 Kubernetes 的基本结构。组件之间的所有操作和通信都是由 APIServer 处理的 REST API 调用，包括外部用户的命令。因此，Kubernetes 平台中的所有内容都被视为 API Object，并在 API 中具有相应的入口。

大多数操作都可以通过 `kubectl` 命令行接口 或 其他命令行工具 如 `kubeadm` 执行。也可以直接通过 REST API 直接访问，如 `curl`。

也有其他客户端库可以使用，如果想在应用程序中访问 Kubernetes Api。

[API Conventions](https://github.com/kubernetes/community/blob/master/contributors/devel/api-conventions.md)

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
    - name: nginx
status:
```

```yaml
apiVersion: v1
kind: List
metadata:
  resourceVersion: ""
  selfLink: ""
items:
  -
  -
```

### Field: `apiVersion`

Kubernetes 支持多版本的 Api，这些 Api 在不同的路径上。

Api Path：

* `/api/v1`
* `/apis/extensions/v1beta1`

版本是 Api 级别的版本，而不是资源或字段级别的版本，确保 Api 清晰且保持一致。

不同的 Api 版本意味着不同级别的稳定性和支持

* Alpha level，名称中包含 `alpha`, 如 `v1alpha1`，可能有很多Bugs，默认关闭，未来可能会被修改甚至移除，推荐只用在短声明周期的测试环境
* Beta level，名称中包含 `beta`, 如 `v1beta1`，经过很全面的测试，默认开启，未来可能会进行一些小的改动，推荐用在不重要的商业逻辑中就，邀请测试提供反馈
* Stable level，`vX`

通常 `alpha` 版本的默认特性不会开启，需手动开启，如下不同版本的 Api 路径：

```
/apis/apps/v1
/apis/apps/v1beta1
/apis/apps/v1beta2
/apis/apps/v1alpha2
/apis/apps/v1alpha1
```

同一资源，如Deployment，可能同时出现在多个路径下，也就是同时包含在多个 API 版本中。当某一Api资源加入到 Api 当中后，随着稳定性的增强，最终会出现在 Stable 版本中，并随着 Kubernetes 版本进行发布，为了向后兼容，之前 Api 路径下的资源需要保留一段时间，并不会很快删除。

同一资源 可能会同时存在不同的 `ApiVersion` 内，不同路径下的 同一 资源的行为可能是不同的。

#### ApiGroups

API Group a set of resources that are exposed together. Along with the version is exposed in the `"apiVersion"` field as `"GROUP/VERSION"`, e.g. `"policy.k8s.io/v1"`.

ApiGroups 使扩展 Kubernetes Api 变的更加容易。

可以通过 参数控制 API groups 的开启关闭，也可以通过 参数控制 API groups 下的某一资源的开启关闭。

ApiGroup 是 ApiVersion 的一部分，目前有多个ApiGroup正在使用，主要分为：

`apiVersion = apiGroup/version`

* Core Group，`/api/$VERSION`，`/api/v1`，`apiVersion: v1`，No `$GROUP_NAME`，eg. Api Path：

  ```
  /api/v1
  ```

* Named Group, `/apis/$GROUP_NAME/$VERSION`，`apiVersion: batch/v1`, `apiVersion: $GROUP_NAME/$VERSION`，eg. Api Path：

  ```
  /apis/apps
  /apis/apps/v1
  /apis/apps/v1beta1
  /apis/apps/v1beta2

  /apis/apiextensions.k8s.io
  /apis/apiextensions.k8s.io/v1beta1

  /apis/authentication.k8s.io
  /apis/authentication.k8s.io/v1

  /apis/authorization.k8s.io
  /apis/authorization.k8s.io/v1
  /apis/authorization.k8s.io/v1beta1

  /apis/rbac.authorization.k8s.io/v1
  /apis/rbac.authorization.k8s.io/v1beta1
  ```

当前，有两种方式支持使用 自定义资源 扩展 Kubernetes Api：

1. `CustomResourceDefinition` is for users with very basic CRUD needs
2. Coming soon: users needing the full set of Kubernetes API semantics can implementtheir own apiserver and use the aggregator to make it seamless for clients.

### Field: `kind`

[Types (Kinds)](https://github.com/kubernetes/community/blob/master/contributors/devel/api-conventions.md#types-kinds)

kind 主要分为以下三类：

1. **Objects** represent a persistent entity in the system. Examples: Pod, ReplicationController, Service, Namespace, Node.
1. **Lists** are collections of `resources` of one (usually) or more (occasionally) `kinds`. `kind: List`
1. **Simple** kinds are used for specific actions on objects and for non-persistent entities. `kind: Status`

#### Resources

`apiVersion` 负责对资源进行分组和版本管理，`kind` 实际标识了 具体的资源是什么。

所以，所有API返回的所有 JSON 对象必须有 `apiVersion` 和 `kind` 两个字段来明确标识资源。他们可以有服务器从指定的URL路径当中取到，但是客户端需要知道这些值来构建URL路径。所以在 Kubernetes 中，每种资源都可以通过URL定位，并执行相关的Verb，因此，也采用了 RESTful架构 设计 API。

### Field: `metadata`

Every object kind `MUST` have the following metadata in a nested object field called `"metadata"`:

* namespace: Namespace='default'
* name: Name
* uid: UID

虽然上述字段要求必须存在，但是上述字段并不是一定要我们通过配置文件指定。

Every object `SHOULD` have the following metadata in a nested object field called `"metadata"`:

* resourceVersion: 资源版本
* generation: 一个代表期望状态的特定代的序列号
* creationTimestamp: 创建时间戳
* deletionTimestamp: 删除时间戳
* selfLink: 资源自身的访问路径
* labels: labels
* annotations: annotations

上述字段中只有 `labels`、`annotations` 需要我们配置，这两个字段中可能还有其他非配置文件中写入的值。

### Field: `metadata.namespace` Namespaces

Related Docs:

* https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
* https://kubernetes.io/docs/tasks/administer-cluster/namespaces/
* https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough/

Api Path: `/apis/{apiGroup}/{version}/namespaces/`
Api Path: `/apis/{apiGroup}/{version}/namespaces/{namespace}`

Kubernetes 支持在同一集群之上虚拟多个集群。虚拟集群称为 `namespace`，也就是命名空间，对资源、权限等进行隔离。

命名空间 可以将不同的 项目或组 隔离到比他的命名空间当中去，方便对权限进行隔离，同时可以按命名空间划分资源或配置资源限额。

命名空间 为名称提供了一个作用域，资源的名称在名称空间中需要是唯一的，但是在不同的命名空间可以相同。

命名空间 可为域名提供一个作用域，创建 Service 的时候，关联的 DNS entry `<service-name>.<namespace-name>.svc.cluster.local`

大部分资源都在命名空间中，Namespace 本身并不在命名空间中，低级的资源如 Nodes、persistentVolumes 也不在命名空间中。Events 是一个例外，它可能在也可能不在命名空间中，取决于是关于什么的 Events。

创建资源时，`metadata.namespace` 必须已经存在。

```sh
kubectl get namespaces
kubectl get namespaces <name>
kubectl delete namespaces <name>
kubectl describe namespaces <name>
kubectl create -f ./my-namespace.yaml
```

```yaml
# my-namespace.yml
apiVersion: v1
kind: Namespace
metadata:
  name: my-namespace
  labels:
    env: production
  annotations:
```

```sh
$ kubectl --namespace=default run nginx --image=nginx
$ kubectl --namespace=default get pods
```

```sh
$ kubectl config set-context $(kubectl config current-context) --namespace=default
# Validate it
$ kubectl config view | grep namespace:
```

### Field: [`metadata.name` && `metadata.uid`](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/)

Api Path: `/apis/{apiGroup}/{version}/namespaces/{namespace}/objects/{object}`

eg. `/api/v1/namespaces/default/pods/nginx-deployment-5964dfd755-9lnzv`

所有的 Kubernete Api Object 都有一个 `Name` 和 `UID` 标识，`metadata.name` 是必须指定的值，`metadata.uid` 由系统生成，指定改值也会被重新复写系统生成的值。

Kubernete系统生成一个字符串来唯一标识一个 Objects，即 `UID`，在 Kubernetes 集群的整个生命周期中创建的每个对象都有一个不同的UID。它旨在时间尺度上区分类似实体。

`Name` 和 `UID` 不应该进行修改，Kubernete可能直接拒绝 `Name` 和 `UID` 的修改操作。

```sh
➜  ~ kubectl get pods etcd-k8s-master1 -n kube-system -o yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubernetes.io/config.hash: 408851a572c13f8177557fdb9151111c
    kubernetes.io/config.mirror: 408851a572c13f8177557fdb9151111c
    kubernetes.io/config.seen: 2018-01-12T11:20:30.255705136+08:00
    kubernetes.io/config.source: file
    scheduler.alpha.kubernetes.io/critical-pod: ""
  creationTimestamp: 2018-01-12T03:21:52Z
  labels:
    component: etcd
    tier: control-plane
  name: etcd-k8s-master1
  namespace: kube-system
  resourceVersion: "5093119"
  selfLink: /api/v1/namespaces/kube-system/pods/etcd-k8s-master1
  uid: bbc52466-f747-11e7-a1e0-525400364556
spec:
```

### Field: metadata.labels [Labels & Selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)

`Labels` 是 Objects 形式的属性，以 `key/value` 形式存在。

`Labels` 设计的目的就是用来被 `Select` 的，所以设置 `Labels` 时主要考虑的就是 资源 有可能如何被筛选。不被 Select 的 信息应该 Annotations 中。

```yaml
metadata:
  ...
  labels:
    key1: value1
    key2: value2
```

#### Label selectors

* Equality-based requirement，suport: `=,==,!=`

```
environment = production
tier != frontend
```

URL Query：`?labelSelector=environment%3Dproduction,tier%3Dfrontend`
kubectl: `kubectl get pods -l environment=production,tier=frontend`

service and replicationcontroller

```yaml
spec:
  selector:
      component: redis
```

* Set-based requirement，suport: `in,notin and exists`

```
environment in (production, qa)
tier notin (frontend, backend)
partition
!partition
```

URL Query：`?labelSelector=environment+in+%28production%2Cqa%29%2Ctier+in+%28frontend%29`
kubectl: `kubectl get pods -l 'environment in (production),tier in (frontend)'`

Newer resources, such as `Job, Deployment, Replica Set, and Daemon Set`, support set-based requirements as well.

```yaml
spec:
  selector:
    matchLabels:
      component: redis
    matchExpressions:
      - {key: tier, operator: In, values: [cache]}
      - {key: environment, operator: NotIn, values: [dev]}
```

### Field: metadata.annotations [Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/)

Annotations 可以将元数据附加到 Kubernetes 对象，相比 Labels，Annotations 不用于标识和选择对象。

Annotations 中的元数据可以是 `small` 或 `large` ，`structured` 或 `unstructured`，并且可以包括标签不允许使用的字符。

```yaml
metadata:
  ...
  annotations:
    key1: value1
    key2: value2
```

### [Well-Known Labels, Annotations and Taints](https://kubernetes.io/docs/reference/labels-annotations-taints/)

一些广为人知的、有预定含义的标签

### spec

#### kind: Pod

Pod 是 Kubernetes 的最基本组成部分，是 Kubernetes 对象模型中最小的可创建的部署单元。Pod 代表集群中一个运行的进程。

Pod 封装了 应用程序容器（或者在某些情况下是多个容器）、存储资源、一个唯一的网络IP、以及支配容器如何运行的选项。

Pod 表示一个部署单元，Kubernetes 中的应用程序的单个实例，可能由单个容器组成，也可能由少数 紧密耦合 且 共享资源 的容器组成。

Pod 构建了一个特定于应用程序的 “逻辑主机” 模型 - 它包含一个或多个相对紧密耦合的应用程序容器 - 在容器之前的世界中，它们将在相同的物理或虚拟机器上执行。

Pod 是容器的载体，所有的容器都在 Pod 中被管理，一个容器或多个容器放在一个 Pod 中作为一个单元的整体。同时，Pod 也作为一层中间层存在，方便支持其他容器引擎的容器管理。而Kubernetes 管理好 Pod 即可，无需关系底层容易细节。

Docker 是最常见的容器运行时引擎，但是 Pod 也支持其他的容器引擎。

Kubernetes 集群中的 Pod 可用于两种主要方式：

* 运行一个容器的Pod
* 运行多个需要协作的容器的Pod

每一个 Pod 都意味着运行一个给定应用程序的实例。如果你需要水平扩展应用，那就需要使用多个Pods，每个实例一个。在 Kubernetes 中，这通常被称为 replication。
Replicated Pods 通常由一个称为 Controller 的抽象创建和管理。

1. Pod如何管理多个容器？

Pod 的设计是为了支持多个相互协作的容器组成一个紧密结合的服务单元。Pod中的容器自动的协同定位或协同调度到同一台物理机或虚拟机上。他们能够共享资源和依赖，相互通信，并协调何时以及如何终止。

> Note：组合多个容器到一个Pod中相对来说是一种高级的用例。应该仅在特定的机密耦合的实例使用这种模式。例如，你有一个容器用作文件服务的WebServer，一个分离的sidecar容器从上游的源更新文件。

每个 Pod 都被分配一个唯一的IP地址，Pod 中的容器共享同一个网络命名空间，包括IP地址和端口号。Pod 中的容器可以通过 `localhost` 进行通信。当 Pod 中的容器需要与外部的容器需要相互通信的时候，他们必须协调如何使用共享网络资源，如端口号。

Pod 可以指定一组共享存储卷，Pod中的所有容器都可以访问共享卷，允许这些容器共享数据。数据卷允许持久化数据在容器需要重启的情况下保持存在。可以查看Volumes有关的内容了解更多信息。

2. Pods的使用

很少直接在Kubernetes中创建Pod，即使是单实例的Pod也是如此。这是因为Pod设计为相对短暂的一次性实体。在创建Pod时（直接创建或由Controller间接创建），它将被调度到集群中的某个节点上运行。Pod保持在该节点上运行，直到进程终止，Pod对象 被删除 或 由于缺乏资源而被驱逐 或 Node节点故障。

> Note：重新启动Pod中的容器不应与重新启动Pod混淆。 Pod本身不运行，但它是容器运行的环境，并一直存在直到它被删除。

Pods 本身不会自愈。如果 Pod 调度到发生故障的节点，或者调度操作本身失败，则 Pod 将被删除; 同样，由于缺乏资源或节点维护，Pod将无法存活。Kubernetes 使用称为 Controller 的更高级别抽象，处理管理相对一次性 Pod 实例的工作。因此，虽然可以直接使用 Pod，但在 Kubernetes 中使用控制器管理 Pod 的情况更为常见。

3. Pod定义

```yaml
apiVersion: v1            # 版本
kind: Pod                 # 类型，Pod
metadata:                 # 元数据
  namespace: String       # 元数据，pod的命名空间
  name: String            # 元数据，pod的名字
  labels:                 # 元数据，标签列表
    - key: String         # 元数据，标签的名字
  annotations:            # 元数据，自定义注解列表
    - key: String         # 元数据，自定义注解名字
spec:                     # pod中容器的详细定义
  containers:             # pod中的容器列表，可以有多个容器
  - name: String
    image: String         # 容器中的镜像
  volumes:                # 在该pod上定义共享存储卷
  - name: String
```

4. Pod构成

Pod 由一个或多个容器组成，这些容器共享存储和网络，以及如何运行容器的规范。

Pod 由一个叫 `pause` 的根容器，加上一个或多个用户自定义的容器构造。`pause` 根容器的状态便代表了这一组容器的状态，Pod 里多个业务容器共享 IP 和 Volume。

kubernetes中的 `pause` 容器便被设计成为每个业务容器提供以下功能：

* 在 pod 中担任Linux命名空间共享的基础，其他容器共享pause命名空间，不同容器犹如在localhost中；
* 启用 pid namespace，充当 init 进程。一旦 init 进程被销毁，同一 pid namespace 下的进程也随之被销毁，并容器进程被回收相应资源。

pause根容器实现：

* [image pause.c](https://github.com/kubernetes/kubernetes/blob/master/build/pause/pause.c)
* [man pause](https://linux.die.net/man/2/pause)

启动方式：

```sh
docker run -d --name ghost --net=container:nginx --ipc=container:nginx --pid=container:nginx ghost
```

Ref：

* [Kubernetes之Pause容器](https://o-my-chenjian.com/2017/10/17/The-Pause-Container-Of-Kubernetes/)
* [Kubernetes之“暂停”容器](http://dockone.io/article/2785)
* [The Almighty Pause Container](https://www.ianlewis.org/en/almighty-pause-container)
* [docker 容器的网络模式](http://cizixs.com/2016/06/12/docker-network-modes-explained)
* [Linux下1号进程的前世(kernel_init)今生(init进程)](http://blog.csdn.net/gatieme/article/details/51532804)

5. Pod调度

Ref：

* [Kubernetes之Pod调度](http://dockone.io/article/2635)
* [Kubernetes Pod调度入门](https://blog.frognew.com/2017/06/kubernetes-scheduling.html)
* [Kubernetes 的高级调度](http://blog.fleeto.us/translation/advanced-scheduling-kubernetes)
* [Kubernetes Scheduler 调度详解](https://cloud.tencent.com/developer/article/1005530)

kube-scheduler 负责Pod的调度，kube-scheduler 将Pod安置到目标Node上。

kube-scheduler使用特定的调度算法和调度策略将等待调度的Pod调度到某个合适的Node上。等待调度的Pod包含使用API创建的Pod，也包含ControllerManager为补足副本而创建的Pod。具体过程为kube-scheduler会从待调度Pod列表中取出每个Pod，并根据调度算法和调度策略从Node列表中选出一个最合适的Node，将Pod和目标Node绑定(`Binding`)，同时将绑定信息写入到etcd中。

在默认情况下，Kubernetes调度器可以满足绝大多数需求，例如调度pod到资源充足的节点上运行，或调度pod分散到不同节点使集群节点资源均衡等。
但一些特殊的场景，默认调度算法策略并不能满足实际需求，例如使用者期望按需将某些pod调度到特定硬件节点(数据库服务部署到SSD硬盘机器、CPU/内存密集型服务部署到高配CPU/内存服务器），或就近部署交互频繁的pod（例如同一机器、同一机房、或同一网段等）。

Pod 一旦和某一个 Node 绑定，便不会再被调度到其他 Pod 上。如果 Node 挂掉了，此 Pod 也将不复存在。

调度的过程包含两个步骤：

* 预选(Predicates)：将根据配置的预选策略(Predicates Policies)`过滤`掉不满足这些策略的Node，剩下的Node将作为候选Node成为优选过程的输入。
* 优选(Priorites)：根据配置的优选策略(Priorities Policies)计算出每个候选Node的积分，按积分排名，得分最高的Node胜出，Pod会和该Node绑定。

调度策略：`全局调度`、`运行时调度`

* 全局调度策略在调度器启动时配置

  调度策略可以通过启动参数进行配置：

  ```json
  kube-scheduler --policy-config-file=
  {
      "kind" : "Policy",
      "apiVersion" : "v1",
      "predicates" : [
          {"name" : "PodFitsHostPorts"},
          {"name" : "PodFitsResources"},
          {"name" : "NoDiskConflict"},
          {"name" : "NoVolumeZoneConflict"},
          {"name" : "MatchNodeSelector"},
          {"name" : "HostName"}
      ],
      "priorities" : [
          {"name" : "LeastRequestedPriority", "weight" : 1},
          {"name" : "BalancedResourceAllocation", "weight" : 1},
          {"name" : "ServiceSpreadingPriority", "weight" : 1},
          {"name" : "EqualPriority", "weight" : 1}
      ],
      "hardPodAffinitySymmetricWeight" : 10
  }
  ```

* 运行时调度策略可以在运行时动态配置，包括：

    * 节点选择（nodeSelector）

        设置节点Label，通常依据节点性能、资源划分设置Labels

        ```sh
        kubectl label nodes <node-name> <label-key>=<label-value>
        kubectl get nodes -l 'label_key=label_value'
        ```

        设置 nodeSelector

        ```yaml
        apiVersion: v1
        kind: Pod
        metadata:
          name: nginx
          labels:
            env: test
        spec:
          containers:
            - name: nginx
          image: nginx
          imagePullPolicy: IfNotPresent
          nodeSelector:
            disktype: ssd
        ```

    * 节点亲和性（nodeAffinity）

        前面提到的nodeSelector，其仅以一种非常简单的方式、即label强制限制pod调度到指定节点。
        而亲和性（affinity）与非亲和性（anti-affinity）则更加灵活的指定pod调度到预期节点上，相比nodeSelector，affinity与anti-affinity优势体现在：

        * 表述语法更加多样化，不再仅受限于强制约束与匹配。
        * 调度规则不再是强制约束（hard），取而代之的是软限（soft）或偏好（preference）。
        * 指定pod可以和哪些pod部署在同一个/不同拓扑结构下。

        ```yaml
        apiVersion: v1
        kind: Pod
        metadata:
          name: with-node-affinity
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: kubernetes.io/e2e-az-name
                    operator: In
                    values:
                    - e2e-az1
                    - e2e-az2
              preferredDuringSchedulingIgnoredDuringExecution:
              - weight: 1
                preference:
                  matchExpressions:
                  - key: another-node-label-key
                    operator: In
                    values:
                    - another-node-label-value
          containers:
          - name: with-node-affinity
            image: k8s.gcr.io/pause:2.0
        ```

    * Pod亲和性（podAffinity）与反亲和性（podAntiAffinity）

        podAffinity 用于调度 pod 可以和哪些 pod 部署在同一拓扑结构之下。
        而 podAntiAffinity 相反，其用于规定 pod 不可以和哪些 pod 部署在同一拓扑结构下。
        通过 podAffinity 与 podAntiAffinity 来解决 pod 和 pod 之间的关系。

        ```yaml
        apiVersion: v1
        kind: Pod
        metadata:
          name: with-pod-affinity
        spec:
          affinity:
            podAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
              - labelSelector:
                  matchExpressions:
                  - key: security
                    operator: In
                    values:
                    - S1
                topologyKey: failure-domain.beta.kubernetes.io/zone
            podAntiAffinity:
              preferredDuringSchedulingIgnoredDuringExecution:
              - weight: 100
                podAffinityTerm:
                  labelSelector:
                    matchExpressions:
                    - key: security
                      operator: In
                      values:
                      - S2
                  topologyKey: kubernetes.io/hostname
          containers:
          - name: with-pod-affinity
            image: k8s.gcr.io/pause:2.0
        ```

    * 污点（Taints）与容忍（Tolerations）

        ```sh
        kubectl taint nodes node1 key1=value1:NoSchedule        # Pod不会被调度到标记为taints节点
        kubectl taint nodes node1 key1=value1:PreferNoSchedule  # Pod不会被调度到标记为taints节点(偏好)
        kubectl taint nodes node1 key1=value1:NoExecute         # 该选项意味着一旦Taint生效，如该节点内正在运行的 Pod 没有对应 Tolerate 设置，会直接被逐出
        ```

        ```yaml
        apiVersion: v1
        kind: Pod
        metadata:
          name: with-pod-affinity
        spec:
          ...
          tolerations:
          - key: "key1"
            operator: "Equal"
            value: "value1"
            effect: "NoExecute"
            tolerationSeconds: 3600
        ```

如果以上调度策略还不能满足需求，可以自定义调度策略：

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  schedulerName: my-scheduler # 调度器名称
  containers:
  - name: nginx
    image: nginx:1.10
```

6. Pod运行

一旦 Pod 被 Binding 到某个 Node 上，该 Node 上的 kubelet 将开始管理 Pod 的生命周期，从创建到销毁。

目标 Node 上的 kubelet 通过 kube-apiserver 监听到 kube-scheduler 触发的 Pod 和目标 Node 的绑定事件，就会拉取镜像和启动容器。

Pod运行之后，会有如下 `status` 字段：

```yaml
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: 2018-03-02T03:09:21Z
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: 2018-03-02T03:13:13Z
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: 2018-03-02T03:09:21Z
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: docker://8769b37016dbfa3041f6524da278867183afe34c021ca96abf146f370371cf27
    image: k8s.gcr.io/echoserver:1.4
    imageID: docker-pullable://k8s.gcr.io/echoserver@sha256:5d99aa1120524c801bc8c1a7077e8f5ec122ba16b6dda1a5d3826057f67b9bcb
    lastState: {}
    name: source-ip-app
    ready: true
    restartCount: 0
    state:
      running:
        startedAt: 2018-03-02T03:13:13Z
  hostIP: 10.10.154.127
  phase: Running
  podIP: 10.244.2.87
  qosClass: BestEffort
  startTime: 2018-03-02T03:09:21Z
```

status.phase [Pod phase](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-phase)

  Phase     | Description
  ----------|------------
  Pending   | Kubernetes已经接受了Pod，该Pod还在调度或镜像拉取中。
  Running   | Pod内所有的容器已创建，且至少有一个容器处于运行状态，正在启动或重启状态。
  Succeeded | Pod内所有容器都成功的执行完毕，并不会重新启动。
  Failed    | Pod内所有容器都已终止，其中至少有一个容器以失败的状态终止。
  Unknown   | 由于某种原因无法获取Pod的状态，比如网络不通。

status.conditions [Pod condition](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.9/#podcondition-v1-core
)

  该字段是一个数组，每个元素都有 `type` `status` 字段：
  
  * type: `PodScheduled`, `Ready`, `Initialized`, and `Unschedulable`.
  * status: `True`, `False`, and `Unknown`.
  
  还可能有如下字段：
  
  * lastProbeTime
  * lastTransitionTime
  * message
  * reason

status.containerStatuses [Containers status](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.9/#containerstatus-v1-core)

Container probes

Kubernetes内部通过2种探针，实现了对Pod健康的检查

* LivenessProbe：判断容器是否存活（running）
* ReadinessProbe： 用于判断容器是否启动完成（ready）

LivenessProbe探针通过三种方式来检查容器是否健康

* ExecAction: 在容器内部执行一个命令，如果返回码为0，则表示健康
* TcpAction: 通过IP 和port ,如果能够和容器建立连接则表示容器健康
* HttpGetAction:发送一个http Get请求（ip+port+请求路径）如果返回状态吗在200-400之间则表示健康

探针检查结果分为3种情况：

* 成功（Success）：通过检查。
* 失败（Failure）：检查失败。
* 未知（Unknown）：检查未知，需要人工干预。

[Container Lifecycle Hooks](https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/)

容器生命周期勾子函数在执行的时候会影响容器的生命周期

Kubemetes支持两种类型的容器钩子：

* PostStart 该钩子在容器被创建后立刻触发，通知容器它已经被创建。
* PreStop 该钩子在容器被删除前触发，其所对应的hook handler必须在删除该容器的请求发送给Docker daemon之前完成。

Kubemetes支持两种不同的hook handler类型，分别是Exec和HTTPGet。

* Exec 在容器的cgroup和namespace内启动一个新进程来执行指定的命令，由该命令消耗的资源全部要计人容器的消耗。
* HTTPGet 向容器的指定接口发起一个HTTP请求作为handler的具体执行内容，并通过返回的HTTP状态码来判断该请求执行是否成功。

Example：

```yaml
spec:
  containers:
    - name: test-lifecycle-hostpath
      image: registry:5000/back_demon:1.0
      lifecycle:
        postStart:
          exec:
            command:
              - "touch"
              - "/home/laizy/test/hostpath/post-start"
        preStop:
          exec:
            command:
              - "touch"
              - "/home/laizy/test/hostpath/pre-stop"
      command:
      - /run.sh
```

Restart policy

```yaml
spec:
  containers:
  - name:
    ...
    restartPolicy: Always
```

Pod 的重启策略应用于 Pod 内的所有容器，失败的容器将会按指数退避的方式延迟重启（10s, 20s, 40s，5min，5min），由 Pod 所在 Node 节点上的 Kubelet 进行判断和重启操作。

Policy      | Description
------------|-----
Always      | 默认，容器失效时，即重启
OnFailure   | 容器终止运行，且退出码不为0 时重启
Never       | 不重启

InitContainers

* [Kubernetes之健康检查与服务依赖处理](https://www.kubernetes.org.cn/2597.html)

```yaml
spec:
  initContainers:
  - name: init-serviceA
    image: registry.docker.dev.fwmrm.net/busybox:latest
    command: ['sh', '-c', "curl --connect-timeout 3 --max-time 5 --retry 10 --retry-delay 5 --retry-max-time 60 serviceB:portB/pathB/"]
  containers:
```

```yaml
spec.initContainers
status.initContainerStatuses
```

Pod 可以有多个运行的容器，也可以有一个或多个在 AppContainers 之前运行的 InitContainers。

Pod 的中多个 InitContainer 启动顺序为yaml文件中的描述顺序，且串行方式启动，下一个 InitContainer 必须等待上一个 InitContainer 完成后方可启动。

例如，InitContainer1 -> … -> InitContainerN -> AppContainer[1-n]。
InitContainer1成功启动并且完成后，后续的InitContainer和AppContainer才可以启动，如InitContainer启动或执行相关检查失败，后续的initContainer和AppContainer将不会被执行启动命令。

如果Pod的 InitContainer 失败，则Kubernetes会反复重新启动Pod，直到InitContainer成功。但是，如果Pod具有Never的restartPolicy，则不会重新启动。

InitContainers用途：

* 由于InitContainer必须在AppContainers启动之前完成，所以可利用其特性，用作服务依赖处理。
* 应用镜像因安全原因等没办法安装或运行的工具，可放到InitContainer中运行。Init Container独立于业务服务，与业务无关的工具如sed, awk, python, dig等也可以按需放到InitContainer之中。InitContainer也可以被授权访问应用Container无权访问的内容。

Containers Images

```yaml
apiVersion: v1
kind: pod
metadata:
spec:
  containers:
    - name: String
    ...
    imagesPullPolicy: [Always|Never|IfNotPresent]# 获取镜像的策略
    imagePullSecrets:
```

Containers Resource

CPU和MEM都是资源类型，都有一个基本单位，CPU的单位是核心数，MEM的单位是字节数。

CPU和MEM统称为计算资源，计算资源是可以被请求，分配和使用的可测量数量。

CPU的单位可以是 `millicpu or millicores` 单位的，1 Core = 1000 m，即 0.1 = 100m。0.1 并不是百分比，所以不论在 1Core，2Cores，48Cores的机器上，表示的核心数量是固定的。

MEM的单位是 `bytes`，`E, P, T, G, M, K`，`Ei, Pi, Ti, Gi, Mi, Ki`

```
spec.containers[].resources.requests.cpu: 2
spec.containers[].resources.requests.cpu: 0.5
spec.containers[].resources.requests.cpu: 100m
```

在Pod调度时，Node上的计算资源能满足Pod资源需求是一个条件，因为同一个Pod中的容器必须调度到同一个Node上，Pod资源需求是所有容器资源需求之和。

* [Managing Compute Resources for Containers](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/)

```yaml
apiVersion: v1
kind: Pod
metadata:
spec:
  containers:
    - name: String
    ...
    resources:            # 资源限制
      limits:
        cpu: Srting
        memory: String
      requeste:
        cpu: String
        memory: String
```

* Request: 容器使用的最小资源需求，作为容器调度时资源分配的判断依赖。只有当节点上可分配资源量>=容器资源请求数时才允许将容器调度到该节点。但Request参数不限制容器的最大可使用资源。
* Limit: 容器能使用资源的资源的最大值，设置为0表示使用资源无上限。

Request能够保证Pod有足够的资源来运行，而Limit则是防止某个Pod无限制地使用资源，导致其他Pod崩溃。两者之间必须满足关系: 0<=Request<=Limit<=Infinity (如果Limit为0表示不对资源进行限制，这时可以小于Request)

InjectDataIntoPod

Arguments、Environment Variables、Files、Secrets、PodPreset

* [Arguments、Environment Variables、Files、Secrets、PodPreset](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/)

Pod lifetime

一般来讲，Pod是不会消失的，除非主动销毁他们。可以是用户或控制器。

Pod 的一旦被创建，便不能被修改，如更新容器镜像版本或其他，如果想更新Pod，只能通过删除 Pod 然后创建新 Pod 实现，可以手动删除之后创建，也可以通过Controller来实现。

Disruptions

Voluntary and Involuntary Disruptions

PodDisruptionBudget

一个正在运行的 Pod，无法对其 `.spec` 进行修改，如果想修改，只能启动新的容器，删除旧的容器。所以直接使用 `kind: Pod` 创建资源，对更新时非常不方便的。

#### Controller

Pod 在 Kubernetes 集群中是实际运行的实体，Controllers 可以使 Pod 按配置期望的状态运行。

Controller 不像 Pod 是可调度的对象，会被调度到某个 Node 上，而是存在于 Master 中，实现对 Pod 的控制。

Pod 专注于 容器的管理 及 生命周期 等 方面的管理，对与多个 Pod 的管理，需要更高级的对象来实现。

Controller 由 `kube-controller-manager` 组件维护和管理。

#### kind: ReplicationController & kind: ReplicationSet

该控制器主要实现对 Pod 数量的控制，保证 同时有 期望 数量 的 Pod 在运行。

```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx
spec:
  selector:
    app: nginx
  replicas: 3
  template:
    metadata:
      name: nginx
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
```

说明：

* `.spec.template` 是唯一必须的字段。
* `.spec.template` 是一个 `pod template`，除了没有 `apiVersion` or `kind`。
* `.spec.template.spec.restartPolicy` 只 允许是 `Always`。

.metadata.labels

ReplicationController 拥有自己的 `.metadata.labels`，通常情况下与 `.spec.template.metadata.labels` 相同，如果未指定，则默认为 `.spec.template.metadata.labels`。他们也可以不同，`.metadata.labels` 不会影响 ReplicationController 的行为。

.spec.selector

ReplicationController 管理所有 `.spec.selector` 匹配的 `Pods`，它不区分 `Pods` 是不是它自己创建的。这就使 ReplicationController 有能力影响正在运行的 `Pods`。
如果指定 `.spec.selector`，则不需与 `.spec.template.metadata.labels` 相同。如果未指定，则默认为 `.spec.template.metadata.labels`。
ReplicationController 只支持 Equal-based Selector，而 ReplicationSet 支持 Set-based Selector，这也是两者目前唯一的区别。

不应该创建与 该 `.spec.selector` 相匹配的 Pod，不论是直接创建还是通过其他控制器创建。如果这样做了，其他Pod也会纳入这个 ReplicationController 的管理范围，Kubernetes并不防止这种情况。这可能会导致严重的问题。

.spec.replicas

可以通过这个字段指明并发运行的 Pods 的数量。默认为 1。

删除一个 ReplicationController 将会 将 Pod 数量 缩减 到 0，然后 删除 ReplicationController 本身。可以通过 `--cascade=false` 参数关闭级联删除，只删除 ReplicationController，而不影响 Pod。

可以通过改变 Pod 的 Label 将 Pod 与 ReplicationController 分离，ReplicationController 将会 启动的一个新的 Pod 顶替 原来的 Pod。

如上所述，ReplicationController 的核心功能在于保持 Pod 数量在期望的状态。最终实现了 保持某一固定版本（配置）的 Pod 数量在期望的状态。

常见的使用模式：

  * Rescheduling 确保指定数量的Pod在运行，如果Pod运行失败，将会ReplicationController会触发重新调度。
  * Scaling 更新 `.spec.replicas` 字段实现水平伸缩。
  * Rolling updates 滚动更新，创建一个新的Pod，删除一个旧的Pod，逐步的替换。used by `Deployment`。`kubectl rolling-update`。
  * Multiple release tracks
  * Using ReplicationControllers with Services

通过调整 `.spec.replicas` 来 实现水平伸缩的动作 在 Kubernetes 被称为 `scale`

```sh
kubectl scale --replicas=3 rs/foo
```

#### kind: Deployment

Deployment 是 建立在 ReplicaSet 之上进行的更高一层的抽象。

Deployment 为 Pods 和 ReplicaSets 提供声明性更新。

Deployment 对象中描述了所需的状态，并且 Deployment 以受控的速率将实际状态更改为所需的状态。

Deployment 内部 管理 两个 ReplicaSet，OldReplicaSets 和 NewReplicaSets。

Deployment，可以通过 ReplicaSets 方便的 扩容。

定义 Deployment 会自动创建 ReplicaSet，更新 Deployment 配置之后，Deployment 会创建 一个 新的 NewReplicaSets，原 ReplicaSet 则为 OldReplicaSets。Deployment 按照一定的策略 增加 NewReplicaSets 下 Pods 数量或比例，当达到期望值时，再 减少 OldReplicaSets 下 Pods 数量或比例，如此反复，直到 OldReplicaSets 缩减为 0，NewReplicaSets 达到期望的状态。这样就实现了 Pods 的滚动更新。

如果在滚动更新过程中，新Pod无法创建成功，旧Pod也不会减少，所以不会导致服务终止。
如果在滚动更新过程中，再次更新 Deployment，NewReplicaSets将会被覆盖，NewReplicaSets 已经创建的 Pods 将会被清除，然后按照更新之后的配置重新创建 Pod。

更新过程也可以暂停，在适当的时候再继续。如果在暂停状态下更新 Deployment，更新过程同样需要在恢复执行之后继续执行，并且需要完成上一次暂停时执行的更新之后，再执行新的更新。也就是需要逐个版本更新，而不能跳过中间版本。

每一次滚动更新都会被记录，所以可以查看历史，也可以通过历史记录方便的回退到某一版本。

这种 新 NewReplicaSets 替换 OldReplicaSets 的过程 在 Kubernetes 中 被称为 `rollout`

```sh
kubectl rollout status
```

* Progressing Deployment

    * Deployment正在创建新的ReplicaSet过程中。
    * Deployment正在扩容一个已有的ReplicaSet。
    * Deployment正在缩容一个已有的ReplicaSet。
    * 有新的可用的pod出现。

* Complete Deployment

    * Deployment最小可用。最小可用意味着Deployment的可用replica个数等于或者超过Deployment策略中的期望个数。
    * 所有与该Deployment相关的replica都被更新到了你指定版本，也就说更新完成。
    * 该Deployment中没有旧的Pod存在。

* Failed Deployment

    * 无效的引用
    * 不可读的probe failure
    * 镜像拉取错误
    * 权限不够
    * 范围限制
    * 程序运行时配置错误

status.conditions

* Type=Progressing
* Status=False
* Reason=ProgressDeadlineExceeded

Create

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  revisionHistoryLimit: # 项来指定保留多少旧的ReplicaSet
  minReadySeconds: 5
  progressDeadlineSeconds: 600
  revision:
  revisionHistoryLimit:
  paused: false
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 3
      maxUnavailable: 2
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80
```

Deployment相关配置项说明：

* `.spec.strategy.type==Recreate` 时，在创建出新的Pod之前会先杀掉所有已存在的Pod。
* ---
* `.spec.strategy.type==RollingUpdate` 时，Deployment使用 rolling update 的方式更新Pod。
* `.spec.strategy.rollingUpdate.maxUnavailable` 是可选配置项，用来指定在升级过程中不可用Pod的最大数量。
* `.spec.strategy.rollingUpdate.maxSurge` 是可选配置项，用来指定可以超过期望的Pod数量的最大个数。
* ---
* `.spec.minReadySeconds` 是一个可选配置项，用来指定没有任何容器crash的Pod并被认为是可用状态的最小秒数。
* `.spec.progressDeadlineSeconds` 是可选配置项，用来指定在系统报告Deployment的failed progressing ——表现为resource的状态中type=Progressing、Status=False、 * Reason=ProgressDeadlineExceeded 前可以等待的Deployment进行的秒数。
* ---
* `.spec.rollbackTo.revision` 是一个可选配置项，用来指定回退到的revision。默认是0，意味着回退到历史中最老的revision。
* ---
* `.spec.revisionHistoryLimit` 是一个可选配置项，用来指定可以保留的旧的ReplicaSet数量。
* ---
* `.spec.paused` 是可以可选配置项，boolean值。

HorizontalPodAutoscaler

* [Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
* [Horizontal Pod Autoscaler Walkthrough](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/)

HPA 会根据 CPU利用率 自动调整 ReplicaSet 或 ReplicationController 中的 Pod 数量 `.spec.replicas`。Horizo​​ntal Pod Autoscaler 不适用于无法伸缩的对象。

HPA 同样也是一种Api资源，同时也是一种Controller，资源决定了控制器的行为。控制器会定期调整 ReplicaSet 或 Deployments 的副本数，以使检测到的平均CPU利用率与用户指定的目标匹配。

* 控制管理器每隔30s（可以通过 `–horizontal-pod-autoscaler-sync-period` 修改）查询 metrics 的资源使用情况
* 支持三种metrics类型
  * 预定义metrics（比如Pod的CPU）以利用率的方式计算
  * 自定义的Pod metrics，以原始值（raw value）的方式计算
  * 自定义的object metrics
* 支持两种metrics查询方式：Heapster和自定义的REST API
* 支持多metrics

```yaml
kubectl autoscale rc foo --min=2 --max=5 --cpu-percent=80
```

```yaml
apiVersion: autoscaling/v2beta1
kind: HorizontalPodAutoscaler
metadata:
  name: php-apache
  namespace: default
spec:
  scaleTargetRef:
    apiVersion: apps/v1beta1
    kind: Deployment
    name: php-apache
  minReplicas: 1
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      targetAverageUtilization: 50
status:
  observedGeneration: 1
  lastScaleTime: <some-time>
  currentReplicas: 1
  desiredReplicas: 1
  currentMetrics:
  - type: Resource
    resource:
      name: cpu
      currentAverageUtilization: 0
      currentAverageValue: 0
```

#### kind: StatefulSets

StatefulSet是为了解决有状态服务的问题（对应Deployments和ReplicaSets是为无状态服务而设计）

StatefulSet可以满足对于以下条件有要求的应用：

* Stable, unique network identifiers.
* Stable, persistent storage.
* Ordered, graceful deployment and scaling.
* Ordered, graceful deletion and termination.
* Ordered, automated rolling updates.

#### kind: DaemonSet

#### kind: Job

Job负责批量处理短暂的一次性任务 (short lived one-off tasks)，即仅执行一次的任务，它保证批处理任务的一个或多个Pod成功结束。

Kubernetes支持以下几种Job：

* 非并行Job：通常创建一个Pod直至其成功结束
* 固定结束次数的Job：设置 `.spec.completions`，创建多个Pod，直到 `.spec.completions` 个Pod成功结束
* 带有工作队列的并行Job：设置 `.spec.Parallelism` 但不设置 `.spec.completions` ，当所有Pod结束并且至少一个成功时，Job就认为是成功

`.spec.template.spec.containers.restartPolicy`（只支持OnFailure和Never，不支持Always）

Jobs

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: pi
spec:
  completions: 2
  template:
    spec:
      containers:
      - name: pi
        image: perl
        command: ["perl",  "-Mbignum=bpi", "-wle", "print bpi(2000)"]
      restartPolicy: Never
  backoffLimit: 4
```

#### kind: CronJob

CronJob 即定时任务，在 Job 的基础上增加时间，类似于 crontab，在指定的时间周期运行指定的任务。

CronJob Spec:

* `.spec.schedule` 指定任务运行周期，格式同Cron
* `.spec.jobTemplate` 指定需要运行的任务，格式同Job
* `.spec.startingDeadlineSeconds` 指定任务开始的截止期限
* `.spec.concurrencyPolicy` 指定任务的并发策略，支持 `Allow`、`Forbid`、`Replace` 三个选项

```yaml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: hello
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hello
            image: busybox
            args:
            - /bin/sh
            - -c
            - date; echo Hello from the Kubernetes cluster
          restartPolicy: OnFailure
```

#### kind: Service

Pod 和 Controllers 解决了 Workload 按照期望的状态执行的问题，并实现了很多非常实用了功能，但是还有问题需要解决。如果一组 Pod 通过网络对外提供服务，那么直接访问 Pod 服务将会非常的不方便，Pod 本身非常不稳地，经过 Controller 的控制调整之后，Pod 会被重新调度，在被调度之后 Pod 可能被移除或新建，IP地址会发生变化，无法稳定的访问地址，无论是外部的访问还是内部其他Pod的访问，维护 PodIP 列表将是非常麻烦的事情，此时需要通过 服务注册发现 或 DNS 来解决问题。

然而，Kubernetes 通过 Services 巧妙的解决了这个问题。

Kubernete 能追踪到 Pods 的变化，从而为实现 Services 提供了条件。

Kubernete Service 是一个定义了一组 Pod 的策略的抽象，我们也有时候叫做宏观服务。这些被服务标记的Pod都是（一般）通过 label Selector 决定的，Service 也可以没有 label Selector。

对于Kubernete原生的应用，Kubernete提供了一个简单的Endpoints API，这个Endpoints api的作用就是当一个服务中的pod发生变化时，Endpoints API随之变化，对于那些不是原生的程序，Kubernetes提供了一个基于虚拟IP的网桥的服务，这个服务会将请求转发到对应的后台pod

Service定义

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: ClusterIP # 该字段值为 ClusterIP 时，可以省略。
  selector:
    app: MyApp
  ports:
  - name: http
    protocol: TCP
    port: 80
    targetPort: 9376
  - name: https
    protocol: TCP
    port: 443
    targetPort: 9377
```

字段说明：

* `.spec.selector` 选择器选中一组 Pods 作为 Service 的后端。selector是可选的。

  * `Service` 有个关联的 `Endpoints` 对象表示 `target`。
  * `Service` 指定 `selector` 时会自动创建 `Endpoints`，不指定则不会创建 `Endpoints`。

  `Service` 像一个智能代理一样，会将请求自动的代理到 指定的后端 Pods。`Service` 还可以将请求代理到非 Pods 后端服务中，例如 有一个已经在运行的数据库集群，或者 运行在其他命名空间内Pods对外提供的服务。这种情况下，`.spec.selector` 就不在需要了。此时需要自定义 `Endpoints`

* `.spec.ports` 可以定义多个端口映射，访问 `tcp://ClusterIP:port` 会被转发到 `tcp://ClusterIP:targetPort`，当 `.spec.type=NodePort` 时 访问 `tcp://NodeIP:NodePort` 同样会被转发到 `tcp://ClusterIP:targetPort`。`targetPort` 默认情况与 `port` 相同，`targetPort` 可以是字符串，指的是后端 `Pod` 中端口的名称，`Pod` 可以为暴露出来的端口设置一个名称。

* `.spec.ports[].protocol` 目前支持 `TCP` 和 `UDP` 协议。

Service Type

* `.spec.type=ClusterIP` 默认，可省略，这种模式下只暴露Service在集群内部ClusterIP上，只在集群内部可达。

  可以通过 `.spec.clusterIP` 指定 `clusterIP`，有如下几种情形：

  * `.spec.clusterIP=None`

    这是一种被称为 `Headless services` 的 Service，这种 `Services` 不会分配 `ClusterIP`，并且 `kube-proxy` 也 不会做任何事情。 DNS 依赖于 `selector` 的配置。简单说，这种 `Services` 就是用来配置DNS的。

  * `.spec.clusterIP=10.224.x.x`, 如果指定非 `None` 值，必须为有效的IP地址并且在 `service-cluster-ip-range` CIDR 范围内
  * `.spec.clusterIP`, 如果未指定，Kubernetes将会自动分配一个，此时，可以通过 `service-name.namespace-name` 域名 访问服务

* `.spec.type=NodePort` 暴露Service在每个NodeIP的一个静态端口上。Kubernetes自动创建将NodeIP路由到的ClusterIP服务。可以通过`<NodeIP>:<NodePort>`从集群外部访问集群内部的服务。

  * `.spec.nodePort=` 可以设置一个在每个Node节点上监听的端口，未设置时，Kubernetes将会自动分配并设置此字段

* `.spec.type=LoadBalancer` 使用云提供商的负载均衡器在外部公开该服务。

* `.spec.type=ExternalName` 通过返回CNAME记录及其值，将服务映射到`externalName`字段的内容。即提供DNS功能。
  * `.spec.externalName: my.database.example.com`

`.spec.externalIPs` 如果Node存在多个IP，可以通过此字段设置。

sessionAffinity

`.spec.sessionAffinity`
`.spec.sessionAffinityConfig.clientIP.timeoutSeconds`

Example:

```yaml
spec:
  type: ClusterIP
  clusterIP: None
---
spec:
  type: ClusterIP
  clusterIP: 10.224.x.x
---
spec:
  type: NodePort
  nodePort: 8888
  clusterIP: 10.224.x.x
---
spec:
  type: NodePort
  nodePort: 8888
  clusterIP: 10.224.x.x
---
spec:
  type: LoadBalancer
  loadBalancerIP: 78.11.24.19
  clusterIP: 10.224.x.x
---
spec:
  type: ExternalName
  externalName: my.database.example.com
```

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  ports:
  - protocol: TCP
    port: 80
    targetPort: 9376
---
apiVersion: v1
kind: Endpoints
metadata:
  name: my-service
subsets:
  - addresses:
      - ip: 1.2.3.4
    ports:
      - port: 9376
```

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
  namespace: prod
spec:
  type: ExternalName
  externalName: my.database.example.com
```

访问服务

* 直接访问，`tcp://ClusterIP:port`，`tcp://NodeIP:NodePort`
* 通过环境变量获取到服务地址后访问 `{SVCNAME}_SERVICE_HOST:{SVCNAME}_SERVICE_PORT`
* DNS[强烈建议] `service-name.namespace-name`

Virtual IPs and service proxies

Kubernetes 群集中的每个节点都运行一个 `kube-proxy`。`kube-proxy` 负责为 `ExternalName` 以外的 其他类型 的服务实现一种 `VirturlIP` 形式。

* Kubernetes v1.0, Services are a “layer 4” (TCP/UDP over IP) construct, the proxy was purely in userspace.
* Kubernetes v1.1, the Ingress API was added (beta) to represent “layer 7”(HTTP) services, iptables proxy was added too, and become the default operating mode since Kubernetes v1.2.
* Kubernetes v1.8.0-beta.0, ipvs proxy was added.

Proxy-mode: userspace

1. kube-proxy 监视 Service and Endpoints 的创建和移除，对于每一个 Service，他都会在 本地 Node 上打开一个端口（随机选择），任何访问这个端口的请求都会被代理到 Service 后面的 Pod。哪个 Pod 被选择依据 Service 的 SessionAffinity。
2. kube-proxy 安装 iptables 规则，该规则捕获服务的 clusterIP（虚拟的）和 Port 的流量转发到第一步 kube-proxy 在本地打开的端口上，由 kube-proxy 将该流量重定向到后端 Pod 的指定端口。

client(eg.Pod) -> iptables -> kubeproxy -> Pods

![](https://d33wubrfki0l68.cloudfront.net/b8e1022c2dd815d8dd36b1bc4f0cc3ad870a924f/1dd12/images/docs/services-userspace-overview.svg)

Proxy-mode: iptables

1. kube-proxy 监视 Service and Endpoints 的创建和移除，对于每一个 Service，他都会安装 iptables 规则，该规则捕获服务的 clusterIP（虚拟的）和 Port 的流量然后直接转发到对应的 Service 后端的 Pod，默认情况下，Pod是随机选择的。

client(eg.Pod) -> iptables -> Pods

显然，iptables 不需要在用户空间和内核空间切换，它应该比用户空间代理更快，更可靠。但是，与用户空间代理不同，iptables 不能自动重试另一个 Pod 连接如果 iptables 最初选择的 Pod 不响应，因此它依赖于正在工作的 `Pod readiness probes`。

![](https://d33wubrfki0l68.cloudfront.net/837afa5715eb31fb9ca6516ec6863e810f437264/42951/images/docs/services-iptables-overview.svg)

Proxy-mode: ipvs

1. kube-proxy 监视 Service and Endpoints，调用 netlink 接口来相应地创建 ipvs 规则，并定期与 Services 和 Endpoints 同步 ipvs 规则，以确保 ipvs 状态符合预期。当访问服务时，流量将被重定向到其中一个后端 Pod。

client(eg.Pod) -> netfilter -> Pods

与 iptables 类似，Ipvs 基于 netfilter 钩子函数，但使用散列表作为基础数据结构并在内核空间中工作。这意味着 ipvs 可以更快地重定向流量，并且在同步代理规则时具有更好的性能。此外，ipvs 为负载平衡算法提供了更多选项。

* rr: round-robin
* lc: least connection
* dh: destination hashing
* sh: source hashing
* sed: shortest expected delay
* nq: never queue

![](https://d33wubrfki0l68.cloudfront.net/3ece58e40119539d5e999fe137e79b5015c24275/77563/images/docs/services-ipvs-overview.svg)

> Note：在运行 kube-proxy 之前，ipvs 模式假定在节点上安装了 IPVS 内核模块。当 kube-proxy 以 ipvs 代理模式启动时，kube-proxy 会验证节点上是否安装了 IPVS 模块，如果未安装，kube-proxy 将回退到 iptables 代理模式。

在任何这些代理模型中，`Service’sIP:PORT` 绑定的任何流量都会代理到适当的后端，而客户端不知道任何关于Kubernetes或服务或Pod的信息。

### Network

网络相关概念

1. `Network Namespace`：Linux在网络栈中引入网络命名空间，将独立的网络协议栈隔离到不同的命令空间中，彼此间无法通信；docker利用这一特性，实现不容器间的网络隔离。
1. `Veth Pair`：Veth设备对的引入是为了实现在不同网络命名空间的通信。可以通过Veth设备对连通容器和容器，`Container-veth-docker0-veth-Container`。
1. `TUN/TAP`：TUN/TAP 设备是一种让用户态程序向内核协议栈注入数据的设备
1. `Iptables/Netfilter`：Netfilter负责在内核中执行各种挂接的规则(过滤、修改、丢弃等)，运行在内核模式；Iptables模式是在用户模式下运行的进程，负责协助维护内核中Netfilter的各种规则表；通过二者的配合来实现整个Linux网络协议栈中灵活的数据包处理机制。`kube-proxy`会安装适当的NAT规则。
1. `Bridge`：网桥是一个二层网络设备，通过网桥可以将Linux支持的不同的端口连接起来，并实现类似交换机那样的多对多的通信。`docker0`就是一个网桥。
1. `Router`：Linux系统包含一个完整的路由功能，当IP层在处理数据发送或转发的时候，会使用路由表来决定发往哪里。

k8s集群IP概念汇总

IP Type             |Description
--------------------|---------------------
ProxyIP             | 代理层公网地址IP，外部访问应用的网关服务器。[实际需要关注的IP]
ServiceIP/ClusterIP | 固定虚拟IP，是内部的，外部无法寻址到。
NodeIP              | 容器宿主机的主机IP。
ContainerBridgeIP   | 容器网桥（docker0）IP，容器的网络都需要通过容器网桥转发。
PodIP               | Pod的IP，等效于Pod中网络容器的ContainerIP。
ContainerIP         | 容器的IP，容器的网络是个隔离的网络空间。

#### Flannel插件

* [DockOne技术分享（十八）：一篇文章带你了解Flannel](http://dockone.io/article/618)
* [kubernetes之网络分析](http://blog.cuicc.com/blog/2017/04/30/kubernetes-network/)

![](http://dockone.io/uploads/article/20150826/5bf473d89214a5d1e84f67ad231dd263.png)

1. 容器直接使用目标PodIP/ContainerIP访问，默认通过容器内部的eth0发送出去。
1. 将 Container eth0 和 docker0设备 绑定成 VethPair，报文通过 VethPair 到达 docker0。
1. docker0 桥接到 flannel0 设备，所以报文经 docker0 后被发送到 flannel0。
1. flannel0 虚拟网卡的一端连着协议栈，另一端连着应用程序 flanneld，所以报文在到达 flannel0 后进一步被发送到 flanneld。
1. flanneld 通过 etcd 维护了各个节点之间的路由表，把原来的报文UDP封装一层，通过配置的 `iface` 指定的网络设备发送出去。
1. 报文通过主机之间的网络找到目标主机，NodeIP -> NodeIP。
1. 报文到达另外一台主机后按相反的次序将数据包发送到 Container。
1. `Container1 eth0 -> docker0 -> flannel0 -> flanneld -> Node1 eth0 -> Node2 eth0 -> flanneld -> flannel0 -> docker0 -> Container2 eth0`

启动flannel服务

flannel服务需要先于Docker启动。flannel服务启动时主要做了以下几步的工作：

* 从 `etcd` 中获取 `network` 的配置信息。
* 划分 `subnet`，并在 `etcd` 中进行注册。
* 将子网信息记录到 `/run/flannel/subnet.env` 中。
* 根据 `/run/flannel/subnet.env` 中的子网信息重启 `dockerd` 服务

### Storage

[Kubernetes存储概览](http://cdn.opensourcecloud.cn/zt/k8s/03.pdf)

* Valumes
* kind: PersistentVolume kind: PersistentVolumeClaim
* Storage Classes
* Dynamic Volume Provisioning

### Configuration

* ConfigMap
* Secrets

## kubectl

* [kubectl-commands](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)
