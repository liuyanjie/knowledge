# HTTPS（Hypertext Transfer Protocol over Secure Socket Layer）

HTTPS由两部分构成：HTTP+TLS/SSL，即在HTTP下层增加了一层安全套接字（TLS/SSL）层，因为有了TLS/SSL，所有经过安全层的HTTP数据都是加了密的，所以TLS/SSL实际上为HTTPS提供了安全基础。

TLS vs SSL

* TLS（Transport Layer Security，传输层安全协议）

  位于可靠的面向连接的 网络层协议 和 应用层协议 之间的一种协议层。

  该协议由两层组成：SSL记录协议和SSL握手协议。

* SSL（Secure Socket Layer，安全套接字层）


  SSL是Netscape开发的专门用户保护Web通讯的，目前版本为3.0。最新版本的TLS 1.0是IETF(工程任务组)制定的一种新的协议，它建立在SSL 3.0协议规范之上，是SSL 3.0的后续版本。两者差别极小，可以理解为SSL 3.1，它是写入了RFC的。 

HTTP在安全方面的缺陷

1. 内容未经加密，容易被第三方截获并查看内容
2. 无法防止篡改，容易被第三方截获并篡改内容
3. 容易被冒充，第三方可以伪装成通信对端与你通信

因为存在以上风险，所以HTTPS的出现就是为了解决以上问题，通过数字证书签名提供数据加密并防止数据被篡改，通过加密数据防止数据被查看，通过PKI证书认证有效识别服务端。


HTTPS通讯流程

HTTPS通信流程实际上可以说是TLS握手流程，TLS完成握手之后，HTTP按正常的报文格式请求即可，根本无需关系数据加密传输的问题，对HTTP来说是透明的

TLS握手流程：1-4-3-2

1. ClientHello
2. ServerHello
3. ServerCertificates
4. ServerKeyExchange
5. ServerHelloDone
6. ClientKeyExchange
7. ClientChangeCipherSpec
8. ClientFinished
9.  ServerChangeCipherSpec
10. ServerFinished

[传输层安全协议抓包分析之SSL/TLS](https://www.freebuf.com/articles/network/116497.html)
