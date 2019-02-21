# X.509

* https://en.wikipedia.org/wiki/Public_key_infrastructure
* https://en.wikipedia.org/wiki/X.509
* https://en.wikipedia.org/wiki/X.690
* https://en.wikipedia.org/wiki/Abstract_Syntax_Notation_One


### [X.509](https://en.wikipedia.org/wiki/X.509)

http://www.cnblogs.com/watertao/archive/2012/04/08/2437720.html
http://www.cnblogs.com/LittleHann/p/3738141.html
http://blog.csdn.net/niehanzi/article/details/7280579

X.509是一种非常通用的证书格式。所有的证书都符合ITU-T X.509国际标准；因此(理论上)为一种应用创建的证书可以用于任何其他符合X.509标准的应用。

#### X.509数字证书的编码

#### X.509证书的结构

X.509证书扩展部分

数字证书格式
数字证书体现为一个或一系列相关经过加密的数据文件。常见格式有：

符合PKI ITU-T X509标准，传统标准（.DER .PEM .CER .CRT）
符合PKCS#7 加密消息语法标准(.P7B .P7C .SPC .P7R)
符合PKCS#10 证书请求标准(.p10)
符合PKCS#12 个人信息交换标准（.pfx *.p12）
当然，这只是常用的几种标准，其中，X509证书还分两种编码形式：

X.509 DER(Distinguished Encoding Rules)编码，后缀为：.DER .CER .CRT
X.509 BASE64编码，后缀为：.PEM .CER .CRT
X509是数字证书的基本规范，而P7和P12则是两个实现规范，P7用于数字信封，P12则是带有私钥的证书实现规范。采用的标准不同，生成的数字证书，包含内容也可能不同。下面就证书包含/可能包含的内容做个汇总，一般证书特性有：

存储格式：二进制还是ASCII
是否包含公钥、私钥
包含一个还是多个证书
是否支持密码保护（针对当前证书）
其中：

DER、CER、CRT以二进制形式存放证书，只有公钥，不包含私钥
CSR证书请求
PEM以Base64编码形式存放证书，以”—–BEGIN CERTIFICATE—–” 和 “—–END CERTIFICATE—–”封装，只有公钥
PFX、P12也是以二进制形式存放证书，包含公钥、私钥，包含保护密码。PFX和P12存储格式完全相同只是扩展名不同
P10证书请求
P7R是CA对证书请求回复，一般做数字信封
P7B/P7C证书链，可包含一个或多个证书
理解关键点：凡是包含私钥的，一律必须添加密码保护（加密私钥），因为按照习惯，公钥是可以公开的，私钥必须保护，所以明码证书以及未加保护的证书都不可能包含私钥，只有公钥，不用加密。

上文描述中，DER均表示证书且有签名，实际使用中，还有DER编码的私钥不用签名，实际上只是个“中间件”。另外：证书请求一般采用CSR扩展名，但是其格式有可能是PEM也可能是DER格式，但都代表证书请求，只有经过CA签发后才能得到真正的证书。


## X.509

X.509是常见通用的证书格式。所有的证书都符合为 Public Key Infrastructure (PKI) 制定的 ITU-T X509 国际标准。
X.509是国际电信联盟-电信（ITU-T）部分标准和国际标准化组织（ISO）的证书格式标准。
作为ITU-ISO目录服务系列标准的一部分，X.509是定义了公钥证书结构的基本标准。
1988年首次发布，1993年和1996年两次修订。
当前使用的版本是 X.509 V3，它加入了扩展字段支持，这极大地增进了证书的灵活性。
X.509 V3证书包括一组按预定义顺序排列的强制字段，还有可选扩展字段，即使在强制字段中，X.509证书也允许很大的灵活性，因为它为大多数字段提供了多种编码方案。

证书编码：

X.509 DER 编码(ASCII )的后缀是： .der
X.509 PAM 编码(Base64)的后缀是： .pem

两种编码格式的证书文件的后缀也可能是 .cer .crt，取自certificate，编码就需要根据内容判断了，pem文件内部包含数据类型信息。

PEM - Privacy Enhanced Mail， Openssl 使用 PEM 格式来存放各种信息，它是 openssl 默认采用的信息存放方式，内容是BASE64编码。

PEM文件还可以用来存放私钥等其他类型的数据，pem如果只含私钥的话，一般用.key扩展名，而且可以有密码保护

> Apache和*NIX服务器偏向于使用这种编码格式。

```
—–BEGIN CERTIFICATE—– 
—–END CERTIFICATE—–
```
```
—–BEGIN RSA PRIVATE KEY—– 
—–END RSA PRIVATE KEY—–
```

DER - Distinguished Encoding Rules，打开看是二进制格式，不可读。

> Java和Windows服务器偏向于使用这种编码格式。

证书编码的转换

PEM转为DER openssl x509 -in cert.crt -outform der -out cert.der
DER转为PEM openssl x509 -in cert.crt -inform der -outform pem -out cert.pem

—–BEGIN CERTIFICATE—–
—–END CERTIFICATE—–
—–BEGIN RSA PRIVATE KEY—–
—–END RSA PRIVATE KEY—–

PEM - Privacy Enhanced Mail，文本格式，以 `"-----BEGIN..."` 开头, `"-----END..."` 结尾，内容是BASE64编码.
查看PEM格式证书的信息：`openssl x509 -in certificate.pem -text -noout`
Apache和*NIX服务器偏向于使用这种编码格式.

DER - Distinguished Encoding Rules，二进制格式，不可读。
查看DER格式证书的信息：`openssl x509 -in certificate.der -inform der -text -noout`
Java和Windows服务器偏向于使用这种编码格式.


文件类型：

密钥 KEY - 通常用来存放一个公钥或者私钥，并非X.509证书，编码可能是PEM，也可能是DER。

```sh
openssl rsa -in mykey.key -text -noout
openssl rsa -in mykey.key -text -noout -inform der
```

证书签名请求 CSR - Certificate Signing Request，即证书签名请求，这个并不是证书，而是向权威证书颁发机构获得签名证书的申请，其核心内容是一个公钥(当然还附带了一些别的信息)，在生成这个申请的时候，同时也会生成一个私钥，私钥要自己保管好。

```sh
openssl req -noout -text -in my.csr -inform der
```

证书 certificate，CRT/CER

CRT常见于*NIX系统，可能是PEM编码，也有可能是DER编码，大多数应该是PEM编码。
CER常见于Windows系统，可能是PEM编码，也可能是DER编码，大多数应该是DER编码。

PFX/P12 - predecessor of PKCS#12,对*nix服务器来说,一般CRT和KEY是分开存放在不同文件中的,但Windows的IIS则将它们存在一个PFX文件中,(因此这个文件包含了证书及私钥)这样会不会不安全？应该不会,PFX通常会有一个"提取密码",你想把里面的东西读取出来的话,它就要求你提供提取密码,PFX使用的时DER编码,如何把PFX转换为PEM编码？
openssl pkcs12 -in for-iis.pfx -out for-iis.pem -nodes
这个时候会提示你输入提取代码. for-iis.pem就是可读的文本.
生成pfx的命令类似这样:openssl pkcs12 -export -in certificate.crt -inkey privateKey.key -out certificate.pfx -certfile CACert.crt

其中CACert.crt是CA(权威证书颁发机构)的根证书,有的话也通过-certfile参数一起带进去.这么看来,PFX其实是个证书密钥库.

## SSL/TLS & OpenSSL

https://en.wikipedia.org/wiki/Transport_Layer_Security
https://tools.ietf.org/html/rfc5246
http://www.ruanyifeng.com/blog/2014/02/ssl_tls.html

SSL/TLS 采用 PKCS公钥密码标准 和 X.509证书标准

SSL：（Secure Socket Layer，安全套接字层），位于可靠的面向连接的网络层协议和应用层协议之间的一种协议层。SSL通过互相认证、使用数字签名确保完整性、使用加密确保私密性，以实现客户端和服务器之间的安全通讯。该协议由两层组成：SSL记录协议和SSL握手协议。

TLS：(Transport Layer Security，传输层安全协议)，用于两个应用程序之间提供保密性和数据完整性。该协议由两层组成：TLS记录协议和TLS握手协议。

SSL是Netscape开发的专门用户保护Web通讯的，目前版本为3.0。最新版本的TLS 1.0是IETF(工程任务组)制定的一种新的协议，它建立在SSL 3.0协议规范之上，是SSL 3.0的后续版本。两者差别极小，可以理解为SSL 3.1，它是写入了RFC的。 

OpenSSL - 简单地说,OpenSSL是SSL的一个实现,SSL只是一种规范.理论上来说,SSL这种规范是安全的,目前的技术水平很难破解,但SSL的实现就可能有些漏洞,如著名的"心脏出血".OpenSSL还提供了一大堆强大的工具软件,强大到90%我们都用不到

## SSH & OpenSSH

OpenSSH(SSH) = SH + (OpenSSL|LibreSSL|...SSL|...TLS)(SSL)

OpenSSH 是 SSH （Secure SHell） 协议的免费开源实现。SSH协议族可以用来进行远程控制， 或在计算机之间传送文件。而实现此功能的传统方式，如telnet(终端仿真协议)、 rcp ftp、 rlogin、rsh都是极为不安全的，并且会使用明文传送密码。OpenSSH提供了服务端后台程序和客户端工具，用来加密远程控件和文件传输过程中的数据，并由此来代替原来的类似服务。
OpenSSH是使用SSH透过计算机网络加密通讯的实现。它是取代由SSH Communications Security所提供的商用版本的开放源代码方案。目前OpenSSH是OpenBSD的子计划。
OpenSSH常常被误认以为与OpenSSL有关联，但实际上这两个计划的有不同的目的，不同的发展团队，名称相近只是因为两者有同样的软件发展目标──提供开放源代码的加密通讯软件。.

openssl req -out lyj.csr -newkey rsa:2048 -nodes -keyout lyj.key

http://www.cnblogs.com/yangxiaolan/p/6256838.html
http://www.178linux.com/48764

## Ref

http://www.cnblogs.com/guogangj/p/4118605.html
