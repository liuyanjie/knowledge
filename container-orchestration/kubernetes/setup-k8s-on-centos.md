# Setup-k8s-on-centos

## install deps

```sh
yum install git gcc gettext autoconf libtool automake make cmake pcre-devel asciidoc xmlto c-ares-devel libev-devel libsodium-devel mbedtls-devel -y
```

## install shadowsocks-libev

```sh
yum install epel-release -y

curl https://copr.fedorainfracloud.org/coprs/librehat/shadowsocks/repo/epel-7/librehat-shadowsocks-epel-7.repo > /etc/yum.repos.d/librehat-shadowsocks-epel-7.repo

yum install shadowsocks-libev

yum install rng-tools && systemctl start rngd

yum install virtio-rng

systemctl enable --now shadowsocks-libev-local && systemctl start shadowsocks-libev-local
systemctl enable --now shadowsocks-libev-server && systemctl start shadowsocks-libev-server
systemctl status shadowsocks-libev-local
journalctl -u shadowsocks-libev-local
```

cat > /etc/shadowsocks-libev/config.json << 'EOF'
{
 "server": "0.0.0.0",
 "server_port": 58338,
 "password": "p@$$w0rd",
 "method": "chacha20-ietf-poly1305"
}

```
error while loading shared libraries: libmbedcrypto.so.0
https://github.com/shadowsocks/shadowsocks-libev/issues/1966

ln -s /usr/lib64libmbedcrypto.so.1 /usr/lib64libmbedcrypto.so.0
ln -s /usr/lib64/libmbedcrypto.so.3 /usr/lib64/libmbedcrypto.so.2
```

```sh
vim /etc/shadowsocks.json
{  
    "server": "hk1-sta69.rhinq.space",  
    "server_port": 39654,
    "local_port": 1080,
    "password": "MVqQwnw7VYHM",  
    "timeout": 600,  
    "method": "chacha20-ietf-poly1305"  
}
```

ss-local -c /etc/shadowsocks.json -d start/stop

start service

docker run --name shadowsocks-libev --rm -p 39654:39654 -p 1080:1080 -v /etc/shadowsocks-libev/config.json:/etc/shadowsocks-libev/config.json shadowsocks/shadowsocks-libev

## install CLI proxy tools

proxychain-ng

```sh
git clone https://github.com/rofl0r/proxychains-ng \
  && cd proxychains-ng \
  && ./configure --prefix=/usr --sysconfdir=/etc \
  && make && make install && make install-config \
  && cd .. && rm -rf proxychains-ng
```

```sh
echo "socks5 127.0.0.1 1080"    >> /etc/proxychains.conf
echo "socks5 172.31.197.9 1080" >> /etc/proxychains.conf
echo "socks5 10.10.1.185 1080"  >> /etc/proxychains.conf
```

```sh
proxychains4 curl goolge.com
```

or

```sh
yum install tsocks
yum install privoxy
```

```sh
[root@log ~]# nslookup github.global.ssl.fastly.Net
Server:		10.143.22.118
Address:	10.143.22.118#53

Non-authoritative answer:
Name:	github.global.ssl.fastly.Net
Address: 151.101.73.194

151.101.73.194 github.global.ssl.fastly.Net
```

## set proxy

http://www.linuxdiyf.com/linux/27927.html

vim ~/.bashrc

```sh
export http_proxy=http://127.0.0.1:1080/
export https_proxy=http://127.0.0.1:1080/
export all_proxy=socks5://127.0.0.1:1080/
export no_proxy=.aliyuncs.com,.docker.com,.fedoraproject.org
```

```sh
source ~/.bashrc
```

vim /etc/yum.conf

proxy=http://127.0.0.1:1080/

## install docker

```sh
sudo yum remove docker docker-common docker-selinux docker-engine
sudo apt remove docker docker-common docker-selinux docker-engine

sudo apt install -y yum-utils device-mapper-persistent-data lvm2
sudo apt-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo apt install docker-ce

sudo systemctl start docker

systemctl enable docker.service
```

### config docker registry-mirrors and proxy

https://docs.docker.com/config/daemon/systemd/#httphttps-proxy
http://blog.yanzhe.tk/2017/11/09/docker-set-proxy/

sudo mkdir -p /etc/systemd/system/docker.service.d

sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf <<-'EOF'
[Service]
Environment="HTTP_PROXY=http://172.31.197.9:1080/" "HTTPS_PROXY=https://172.31.197.9:1080/" "NO_PROXY=localhost,127.0.0.1,docker.io,*.aliyuncs.com,*.mirror.aliyuncs.com,registry.docker-cn.com,hub.c.163.com,hub-auth.c.163.com"
EOF

```sh
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "registry-mirrors": ["https://ytts598n.mirror.aliyuncs.com"]
}
EOF
```

```sh
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## install socat

```sh
yum install -y socat
```

## install kubernetes

官方源：

```sh
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
```

阿里云镜像源：

```sh
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

```

```sh
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
```

```sh
yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
```

```sh
systemctl enable kubelet && systemctl start kubelet
```

启动失败

```sh
# root @ demo in ~ [15:09:55] C:3
$ systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/etc/systemd/system/kubelet.service; enabled; vendor preset: disabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: activating (auto-restart) (Result: exit-code) since Sat 2018-12-15 15:10:00 CST; 1s ago
     Docs: https://kubernetes.io/docs/
  Process: 23361 ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS (code=exited, status=255)
 Main PID: 23361 (code=exited, status=255)

Dec 15 15:10:00 demo.mo systemd[1]: Unit kubelet.service entered failed state.
Dec 15 15:10:00 demo.mo systemd[1]: kubelet.service failed.

# root @ demo in ~ [15:10:02] C:3
$ journalctl -u kubelet |tail
Dec 15 15:10:21 demo.mo systemd[1]: kubelet.service: main process exited, code=exited, status=255/n/a
Dec 15 15:10:21 demo.mo systemd[1]: Unit kubelet.service entered failed state.
Dec 15 15:10:21 demo.mo systemd[1]: kubelet.service failed.
Dec 15 15:10:31 demo.mo systemd[1]: kubelet.service holdoff time over, scheduling restart.
Dec 15 15:10:31 demo.mo systemd[1]: Started kubelet: The Kubernetes Node Agent.
Dec 15 15:10:31 demo.mo systemd[1]: Starting kubelet: The Kubernetes Node Agent...
Dec 15 15:10:31 demo.mo kubelet[23474]: F1215 15:10:31.298474   23474 server.go:189] failed to load Kubelet config file /var/lib/kubelet/config.yaml, error failed to read kubelet config file "/var/lib/kubelet/config.yaml", error: open /var/lib/kubelet/config.yaml: no such file or directory
Dec 15 15:10:31 demo.mo systemd[1]: kubelet.service: main process exited, code=exited, status=255/n/a
Dec 15 15:10:31 demo.mo systemd[1]: Unit kubelet.service entered failed state.
Dec 15 15:10:31 demo.mo systemd[1]: kubelet.service failed.

# root @ demo in ~ [15:10:36]
$
```

```sh
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system
```

proxychains4 kubeadm init

kubeadm init --config=kubeadm-init-config.yml

```sh
cat <<EOF > kubeadm-init-config.yml
apiVersion: kubeadm.k8s.io/v1.11
kind: MasterConfiguration
api:
  # advertiseAddress: 10.0.0.11
  # advertiseAddress: 192.168.3.101
  bindPort: 6443
etcd:
  image: registry.cn-hangzhou.aliyuncs.com/kubernetes-containers/etcd-amd64:latest
#   endpoints:
#   - <endpoint1|string>
#   - <endpoint2|string>
#   caFile: <path|string>
#   certFile: <path|string>
#   keyFile: <path|string>
#   dataDir: <path|string>
#   extraArgs:
#     <argument>: <value|string>
#     <argument>: <value|string>
networking:
#   dnsDomain: <string>
#   serviceSubnet: <cidr>
  podSubnet: "10.244.0.0/16"
kubernetesVersion: 1.9.0
# cloudProvider: <string>
# nodeName: k8s-master
# authorizationModes:
# - <authorizationMode1|string>
# - <authorizationMode2|string>
token: b9e6bb.6746bcc9f8ef8267
# tokenTTL: 0
# selfHosted: <bool>
# apiServerExtraArgs:
#   <argument>: <value|string>
#   <argument>: <value|string>
# controllerManagerExtraArgs:
#   <argument>: <value|string>
#   <argument>: <value|string>
# schedulerExtraArgs:
#   <argument>: <value|string>
#   <argument>: <value|string>
# apiServerExtraVolumes:
# - name: <value|string>
#   hostPath: <value|string>
#   mountPath: <value|string>
# controllerManagerExtraVolumes:
# - name: <value|string>
#   hostPath: <value|string>
#   mountPath: <value|string>
# schedulerExtraVolumes:
# - name: <value|string>
#   hostPath: <value|string>
#   mountPath: <value|string>
# apiServerCertSANs:
# - <name1|string>
# - <name2|string>
# certificatesDir: <string>
imageRepository: registry.cn-hangzhou.aliyuncs.com/kubernetes-containers
# unifiedControlPlaneImage: <string>
featureGates:
  SelfHosting: true
  StoreCertsInSecrets: true
  # CoreDNS: true
EOF

```

```sh
Dec 15 16:17:23 demo.mo systemd[1]: kubelet.service holdoff time over, scheduling restart.
Dec 15 16:17:23 demo.mo systemd[1]: Started kubelet: The Kubernetes Node Agent.
Dec 15 16:17:23 demo.mo systemd[1]: Starting kubelet: The Kubernetes Node Agent...
Dec 15 16:17:23 demo.mo kubelet[8682]: F1215 16:17:23.800762    8682 server.go:189] failed to load Kubelet config file /var/lib/kubelet/config.yaml, error failed to read kubelet config file
Dec 15 16:17:23 demo.mo systemd[1]: kubelet.service: main process exited, code=exited, status=255/n/a
Dec 15 16:17:23 demo.mo systemd[1]: Unit kubelet.service entered failed state.
Dec 15 16:17:23 demo.mo systemd[1]: kubelet.service failed.
```

```sh
kubeadm init \
  --apiserver-advertise-address=10.10.0.217 \
  --apiserver-bind-port=6443 \
  --cert-dir=/etc/kubernetes/pki \
  --cri-socket=/var/run/dockershim.sock \
  --feature-gates= \
  --image-repository=gcrxio \
  --kubernetes-version=v1.13.1 \
  --node-name=$(hostname) \
  --pod-network-cidr=10.244.0.0/16 \
  --service-cidr=10.96.0.0/12 \
  --service-dns-domain=cluster.local
```

```sh
$ kubectl get nodes -o wide
NAME      STATUS     ROLES    AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE                KERNEL-VERSION               CONTAINER-RUNTIME
demo.mo   NotReady   master   5m35s   v1.13.1   10.10.0.217   <none>        CentOS Linux 7 (Core)   3.10.0-862.14.4.el7.x86_64   docker://18.6.1

```

https://hub.docker.com/r/gcrxio

```sh
$ kubeadm config print init-defaults
apiVersion: kubeadm.k8s.io/v1beta1
bootstrapTokens:
- groups:
  - system:bootstrappers:kubeadm:default-node-token
  token: abcdef.0123456789abcdef
  ttl: 24h0m0s
  usages:
  - signing
  - authentication
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: 1.2.3.4
  bindPort: 6443
nodeRegistration:
  criSocket: /var/run/dockershim.sock
  name: demo.mo
  taints:
  - effect: NoSchedule
    key: node-role.kubernetes.io/master
---
apiServer:
  timeoutForControlPlane: 4m0s
apiVersion: kubeadm.k8s.io/v1beta1
certificatesDir: /etc/kubernetes/pki
clusterName: kubernetes
controlPlaneEndpoint: ""
controllerManager: {}
dns:
  type: CoreDNS
etcd:
  local:
    dataDir: /var/lib/etcd
imageRepository: k8s.gcr.io
kind: ClusterConfiguration
kubernetesVersion: v1.13.0
networking:
  dnsDomain: cluster.local
  podSubnet: ""
  serviceSubnet: 10.96.0.0/12
scheduler: {}

```

### view

```sh
➜  ~ cat /etc/systemd/system/kubelet.service
[Unit]
Description=kubelet: The Kubernetes Node Agent
Documentation=http://kubernetes.io/docs/

[Service]
ExecStart=/usr/bin/kubelet
Restart=always
StartLimitInterval=0
RestartSec=10

[Install]
WantedBy=multi-user.target
```

```sh
➜  ~ cat /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
[Service]
Environment="KUBELET_KUBECONFIG_ARGS=--bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf"
Environment="KUBELET_SYSTEM_PODS_ARGS=--pod-manifest-path=/etc/kubernetes/manifests --allow-privileged=true"
Environment="KUBELET_NETWORK_ARGS=--network-plugin=cni --cni-conf-dir=/etc/cni/net.d --cni-bin-dir=/opt/cni/bin"
Environment="KUBELET_DNS_ARGS=--cluster-dns=10.96.0.10 --cluster-domain=cluster.local"
Environment="KUBELET_AUTHZ_ARGS=--authorization-mode=Webhook --client-ca-file=/etc/kubernetes/pki/ca.crt"
Environment="KUBELET_CADVISOR_ARGS=--cadvisor-port=0"
Environment="KUBELET_CGROUP_ARGS=--cgroup-driver=systemd"
Environment="KUBELET_CERTIFICATE_ARGS=--rotate-certificates=true --cert-dir=/var/lib/kubelet/pki"
ExecStart=
ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_SYSTEM_PODS_ARGS $KUBELET_NETWORK_ARGS $KUBELET_DNS_ARGS $KUBELET_AUTHZ_ARGS $KUBELET_CADVISOR_ARGS $KUBELET_CGROUP_ARGS $KUBELET_CERTIFICATE_ARGS $KUBELET_EXTRA_ARGS
```

```sh
➜  ~ systemctl cat kubelet
# /etc/systemd/system/kubelet.service
[Unit]
Description=kubelet: The Kubernetes Node Agent
Documentation=http://kubernetes.io/docs/

[Service]
ExecStart=/usr/bin/kubelet
Restart=always
StartLimitInterval=0
RestartSec=10

[Install]
WantedBy=multi-user.target

# /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
[Service]
Environment="KUBELET_KUBECONFIG_ARGS=--bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf"
Environment="KUBELET_SYSTEM_PODS_ARGS=--pod-manifest-path=/etc/kubernetes/manifests --allow-privileged=true"
Environment="KUBELET_NETWORK_ARGS=--network-plugin=cni --cni-conf-dir=/etc/cni/net.d --cni-bin-dir=/opt/cni/bin"
Environment="KUBELET_DNS_ARGS=--cluster-dns=10.96.0.10 --cluster-domain=cluster.local"
Environment="KUBELET_AUTHZ_ARGS=--authorization-mode=Webhook --client-ca-file=/etc/kubernetes/pki/ca.crt"
Environment="KUBELET_CADVISOR_ARGS=--cadvisor-port=0"
Environment="KUBELET_CGROUP_ARGS=--cgroup-driver=systemd"
Environment="KUBELET_CERTIFICATE_ARGS=--rotate-certificates=true --cert-dir=/var/lib/kubelet/pki"
ExecStart=
ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_SYSTEM_PODS_ARGS $KUBELET_NETWORK_ARGS $KUBELET_DNS_ARGS $KUBELET_AUTHZ_ARGS $KUBELET_CADVISOR_ARGS $KUBELET_CGROUP_ARGS $KUBELET_CERTIFICATE_ARGS $KUBELET_EXTRA_ARGS
```

```sh
➜  ~ tree /etc/kubernetes
/etc/kubernetes
|-- admin.conf
|-- admin-user.yaml
|-- controller-manager.conf
|-- scheduler.conf
|-- kubelet.conf
|-- manifests
|   |-- etcd.yaml
|   |-- kube-apiserver.yaml
|   |-- kube-controller-manager.yaml
|   `-- kube-scheduler.yaml
|-- pki
|   |-- apiserver.crt
|   |-- apiserver.key
|   |-- apiserver-kubelet-client.crt
|   |-- apiserver-kubelet-client.key
|   |-- ca.crt
|   |-- ca.key
|   |-- front-proxy-ca.crt
|   |-- front-proxy-ca.key
|   |-- front-proxy-client.crt
|   |-- front-proxy-client.key
|   |-- sa.key
|   `-- sa.pub
```

```sh
➜  ~ systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/etc/systemd/system/kubelet.service; enabled; vendor preset: disabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: active (running) since Tue 2018-02-27 11:15:22 CST; 5 days ago
     Docs: http://kubernetes.io/docs/
 Main PID: 13829 (kubelet)
   CGroup: /system.slice/kubelet.service
           └─13829 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --pod-manifest-path=/etc/kubernetes/manifests --allow-privileged=true --network-plugin=cni --cn...
```

## GCR镜像问题
