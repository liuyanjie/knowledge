# 加密认证体系

* [Backus–Naur_form](https://en.wikipedia.org/wiki/Backus–Naur_form)
* [Augmented_Backus–Naur_form](https://en.wikipedia.org/wiki/Augmented_Backus–Naur_form)
* [Abstract_Syntax_Notation_One](https://en.wikipedia.org/wiki/Abstract_Syntax_Notation_One)
* [Introduction to ASN.1​](https://www.itu.int/en/ITU-T/asn1/Pages/introduction.aspx)
* [ASN.1](http://luca.ntop.org/Teaching/Appunti/asn1.html)
* [X.500](https://en.wikipedia.org/wiki/X.500)
* [X.509](https://en.wikipedia.org/wiki/X.509)
* [X.690](https://en.wikipedia.org/wiki/X.690)

密码学（Cryptography）

公钥基础设施（PKI）

数字证书标准（X.509）

## 信息安全三要素[CIA Triad]

信息安全中有三个需要解决的问题：

* 保密性 (Confidentiality)：信息在传输时不被泄露
* 完整性（Integrity）：信息在传输时不被篡改
* 有效性（Availability）：信息的使用者是合法的

`公钥密码` 解决 `保密性` 问题

`数字签名` 解决 `完整性` 和 `有效性` 问题

## 数字签名[Digital_signature](https://en.wikipedia.org/wiki/Digital_signature)

计算机中，数字签名也是相同的含义：

* 证明消息是某个特定的人，而不是随随便便一个人发送的（`有效性`）
* 除此之外，数字签名还能证明消息没有被篡改（`完整性`）

简单来说，数字签名（digital signature）是公钥密码的逆应用：用私钥加密消息，用公钥解密消息。

1. 生成签名

    一般来说，不直接对消息进行签名，而是对消息的哈希值进行签名，步骤如下。

    1. 对消息进行哈希计算，得到哈希值
    2. 用 **私钥** 对哈希值进行 **加密**，生成签名
    3. 将签名附加在消息后面，一起发送过去

2. 验证签名

    1. 收到消息后，提取消息中的签名
    2. 用 **公钥** 对签名进行 **解密**，得到 `hash1`
    3. 对消息中的正文进行哈希计算，得到 `hash2`
    4. 比较 `hash1` 和 `hash2`，如果相同，则验证成功

## 证书

**证书** 实际上就是对 **公钥** 进行 **数字签名**，它是对 **公钥合法性** 提供证明的技术。

证书一般包含：**公钥（记住证书中是带有公钥的）**，**公钥的数字签名**，**公钥拥有者的信息**，若证书验证成功，这表示该公钥是合法，可信的。

验证证书 需要验证证书中的数字签名，通过签名数字签名部分可知，验证证书中的数字签名需要另一个公钥，那么这个公钥从哪里获取，以及它合法性又该如何保证？

这时候需要一个可信任的第三方。第三方称为认证机构(Certification Authority， CA)。

CA就是能够认定 ”公钥确实属于此人”，并能生成公钥的数字签名的组织或机构。
CA有国际性组织和政府设立的组织，也有通过提供认证服务来盈利的组织。

0. 密钥对

    1. CA: `ca-private-key/ca-public-key`
    2. Server: `server-private-key/server-public-key`

    CA 的 `ca-public-key` 和 Server 的 `server-public-key` 都是可以公开的，但是通常是通过证书公开的，以保证其安全性。

1. 如何生成证书 `server-certificate` ？

    1. 服务器端 将 `server-public-key` 给 `CA`
    2. `CA` 用 `ca-private-key` 给 `server-public-key` 签名，生成 `server-signature`
    3. `CA` 把 `server-public-key`，`server-signature`，附加一些服务器信息整合在一起，生成数字证书 `server-certificate`，发回给服务端。

    注：`CA` 用 `ca-private-key` 给 `ca-public-key` 签名，生成 `ca-signature`，进而生成CA数字证书 `ca-certificate`，也就是所谓的自签名证书。

2. 如何验证证书 `server-certificate` ？

    1. 客户端得到 服务器 证书 `server-certificate`，可以拿到 `server-public-key`、`server-signature`
    2. 客户端得到 CA 证书 `ca-certificate`，可以拿到 `ca-public-key`、`ca-signature`
    3. 客户端用 `ca-public-key` 对证书中的 `server-signature` 解密，得到 `哈希值1`
    4. 客户端用 `ca-public-key` 对 `server-public-key` 进行哈希值计算，得到 `哈希值2`
    5. 如果 `哈希值1` 与 `哈希值2`，则证书合法。

    扩展问题：CA 证书的安全性如何保证？证书链 -> CA根证书

3. 证书作废

    当用户服务器私钥丢失、被盗时，认证机构需要对证书进行作废(revoke)。要作废证书，认证机构需要制作一张证书作废清单(Certificate Revocation List)，简称CRL

    假设我们有Bob的证书，该证书有合法的认证机构签名，而且在有效期内，但仅凭这些还不能说明该证书一定有效，还需要查询认证机构最新的CRL，并确认该证书是否有效。

