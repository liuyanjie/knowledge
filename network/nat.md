# 锥型NAT

锥型NAT将内部源主机 sIP:sPort 映射到NAT设备上的 snatIP:snatPort，所有内部主机共享 65535 个端口，连接数收到很大限制。

完全锥形NAT：dIP和dPort都不受限
in_sIP1:in_sPort1 -> out_sIP1:out_sPort1 -> dIP1:dPort1
in_sIP1:in_sPort1 -> out_sIP1:out_sPort1 <- dIP1:dPort1
in_sIP1:in_sPort1 -> out_sIP1:out_sPort1 <- dIP2:dPort2

仅需对每台内部主机做 sIP:sPort:snatIP:snatPort 映射，不需要包含 dIP:dPort，并且该表项可以一直存在。即：

IP限制型锥型NAT：dIP受限

仅限内部主机主动发起过连接的外部主机能够向特定端口发送数据

in_sIP:in_sPort:snatIP:snatPort:dIP

Port限制型锥型NAT：dIP和dPort都受限

in_sIP:in_sPort:snatIP:snatPort:dIP:dPort

仅限内部主机主动发起过连接的外部主机及端口能够向特定端口发送数据

对称型NAT是一个请求对应一个端口

in_sIP1:in_sPort1:dIP1:dPort1 -> out_sIP1:out_sPort1 -> dIP1:dPort1
in_sIP1:in_sPort1:dIP1:dPort1 -> out_sIP1:out_sPort1 <- dIP1:dPort1

in_sIP1:in_sPort2:dIP1:dPort1 -> out_sIP1:out_sPort2 -> dIP1:dPort1
in_sIP1:in_sPort2:dIP1:dPort1 -> out_sIP1:out_sPort2 <- dIP1:dPort1

https://cloud.tencent.com/developer/article/1005974

SNAT & DNAT

iptables & netfilter & NAT

https://segmentfault.com/a/1190000018641361

https://ring0.me/2014/02/network-virtualization-techniques/

http://reader.epubee.com/books/mobile/b0/b0df099166abc536213030fa3ef0bda4/text00008.html
