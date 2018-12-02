# PKI

* http://www.ruanyifeng.com/blog/2011/08/what_is_a_digital_signature.html
* http://wiki.mbalib.com/wiki/%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D
* http://www.enkichen.com/2016/04/12/certification-and-pki/
* http://www.cnblogs.com/littlehann/p/3738141.html
* http://www.voidcn.com/article/p-ceqhybow-bep.html

## 密钥

## 信息安全三要素[CIA Triad]

信息安全中有三个需要解决的问题：

* 保密性 (Confidentiality)：信息在传输时不被泄露
* 完整性（Integrity）：信息在传输时不被篡改
* 有效性（Availability）：信息的使用者是合法的

公钥密码解决保密性问题
数字签名解决完整性问题和有效性问题

## 数字签名[Digital_signature](https://en.wikipedia.org/wiki/Digital_signature)

计算机中，数字签名也是相同的含义：

* 证明消息是某个特定的人，而不是随随便便一个人发送的（有效性）；
* 除此之外，数字签名还能证明消息没有被篡改（完整性）。

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

验证证书需要验证证书中的数字签名，通过签名数字签名部分可知，验证证书中的数字签名需要另一个公钥，那么这个公钥从哪里获取，以及它合法性又该如何保证？

这时候需要一个可信任的第三方。第三方称为认证机构(Certification Authority， CA)。
CA就是能够认定”公钥确实属于此人”，并能生成公钥的数字签名的组织或机构。
CA有国际性组织和政府设立的组织，也有通过提供认证服务来盈利的组织。

1. 如何生成证书？

    1. 服务器将公钥A给CA（公钥是服务器的）
    2. CA用自己的私钥B给公钥A加密，生成数字签名A
    3. CA把公钥A，数字签名A，附加一些服务器信息整合在一起，生成证书，发回给服务器。

注：私钥B是用于加密公钥A的，私钥B和公钥A并不是配对的。

1. 如何验证证书？

    1. 客户端得到证书
    1. 客户端得到证书的公钥B（通过CA或其它途径）
    1. 客户端用公钥B对证书中的数字签名解密，得到哈希值
    1. 客户端对公钥进行哈希值计算
    1. 两个哈希值对比，如果相同，则证书合法。

注：公钥B和上述的私钥B是配对的，分别用于对证书的验证（解密）和生成（加密）。

1. 证书作废

当用户私钥丢失、被盗时，认证机构需要对证书进行作废(revoke)。要作废证书，认证机构需要制作一张证书作废清单(Certificate Revocation List)，简称CRL

假设我们有Bob的证书，该证书有合法的认证机构签名，而且在有效期内，但仅凭这些还不能说明该证书一定有效，还需要查询认证机构最新的CRL，并确认该证书是否有效。

## PKCS标准(公钥加密标准 Public Key Cryptography Standards, PKCS)

## 公钥基础设施[PKI](https://en.wikipedia.org/wiki/Public_key_infrastructure)

PKI（Public Key Infrastructure）翻译过来就是公钥基础设施，可以理解为利用公钥技术为网络应用提供加密和数字签名等密码服务以及必需的密钥和证书管理体系。
它是一个提供安全服务的基础设施，PKI技术是信息安全技术的核心，同时也是电子商务的关键和基础技术。

PKI既不是一个协议，也不是一个软件，它是一个标准，在这个标准之下发展出的为了实现安全基础服务目的的技术统称为PKI。

### PKI构成

1. 认证中心CA(证书签发)：
2. X.500目录服务器(证书保存)

### [X.509](https://en.wikipedia.org/wiki/X.509)

http://www.cnblogs.com/watertao/archive/2012/04/08/2437720.html
http://www.cnblogs.com/LittleHann/p/3738141.html
http://blog.csdn.net/niehanzi/article/details/7280579

X.509是一种非常通用的证书格式。所有的证书都符合ITU-T X.509国际标准；因此(理论上)为一种应用创建的证书可以用于任何其他符合X.509标准的应用。

#### X.509数字证书的编码

X.509证书的结构是用ASN1(Abstract Syntax Notation One)进行描述数据结构，并使用ASN1语法进行编码。

ASN1采用一个个的数据块来描述整个数据结构，每个数据块都有四个部分组成：

　　1）数据块数据类型标识（一个字节）

　　数据类型包括简单类型和结构类型。

　　简单类型是不能再分解类型，如整型(INTERGER)、比特串(BIT STRING)、字节串(OCTET STRING)、对象标示符(OBJECT IDENTIFIER)、日期型(UTCTime)等。

　　结构类型是由简单类型和结构类型组合而成的，如顺序类型(SEQUENCE, SEQUENCE OF)、选择类型（CHOICE）、集合类型（SET）等。

　　顺序类型的数据块值由按给定顺序成员成员数据块值按照顺序组成；

　　选择类型的数据块值由多个成员数据数据块类型中选择一个的数据块值；

　　集合数据块类型由成员数据块类型的一个或多个值构成。

　　这个标识字节的结构如下：

　　1.1）Bit8-bit7用来标示 TAG 类型，共有四种，分别是universal(00)、application(01)、context-specific(10)和private(11)。

　　1.2）Bit6表示是否为结构类型(1位结构类型)；0则表明编码类型是简单类型。

　　1.3）Bit5-bit1是类型的TAG值。根据bit8-bit7的不同值有不同的含义，具体含义见下表。

　　当Bit8-bit7为universal（00）时，bit5-bit1的值表示不同的universal的值：

　　标记（TAG）　　对应类型　　　　　　　　备注

　　[UNIVERSAL 1]　　BOOLEAN　　　　[有两个值:false或true]
　　[UNIVERSAL 2]　　INTEGER　　　　[整型值]
　　[UNIVERSAL 3]　　BIT STRING　　　　[0位或多位]
　　[UNIVERSAL 4]　　OCTET STRING　　[0字节或多字节]
　　[UNIVERSAL 5]　　NULL
　　[UNIVERSAL 6]　　OBJECT IDENTIFIER　　[相应于一个对象的独特标识数字]
　　[UNIVERSAL 7]　　OBJECT DESCRIPTOR　　 [一个对象的简称]
　　[UNIVERSAL 8]　　EXTERNAL, INSTANCE OF　　[ASN.1没有定义的数据类型]
　　[UNIVERSAL 9]　　REAL　　　　　　[实数值]
　　[UNIVERSAL 10]　　ENUMERATED　　[数值列表，这些数据每个都有独特的标识符，作为ASN.1定义数据类型的一部分]
　　[UNIVERSAL 12]　　UTF8String
　　[UNIVERSAL 13]　　RELATIVE-OID
　　[UNIVERSAL 16]　　SEQUENCE, SEQUENCE OF　　[有序数列，SEQUENCE里面的每个数值都可以是不同类型的，而SEQUENCE OF里是0个或多个类型相同的数据]
　　[UNIVERSAL 17]　　SET, SET OF　　[无序数列，SET里面的每个数值都可以是不同类型的，而SET OF里是0个或多个类型相同的数据]
　　[UNIVERSAL 18]　　Numeric String　　[0－9以及空格]
　　[UNIVERSAL 19]　　Printable String　　[A-Z、a-z、0-9、空格以及符号'()+,-./:=?]
　　[UNIVERSAL 20]　　TeletexString, T61String
　　[UNIVERSAL 21]　　VideotexString
　　[UNIVERSAL 22]　　IA5String
　　[UNIVERSAL 23]　　UTCTime　　[统一全球时间格式]
　　[UNIVERSAL 24]　　GeneralizedTime
　　[UNIVERSAL 25]　　GraphicString
　　[UNIVERSAL 26]　　VisibleString, ISO646String
　　[UNIVERSAL 27]　　GeneralString
　　[UNIVERSAL 28]　　UniversalString
　　[UNIVERSAL 29]　　CHARACTER STRING
　　[UNIVERSAL 30]　　BMPString
　　[UNIVERSAL 31]　　reserved for future use

　　当Bit8-bit7为context-specific（10）时，bit5-bit1的值表示特殊内容：

　　　　[0] –- 表示证书的版本

　　　　[1] –- issuerUniqueID,表示证书发行者的唯一id

　　　　[2] –- subjectUniqueID,表示证书主体的唯一id

　　　　[3] –- 表示证书的扩展字段

　　如 SEQUENCE 类型数据块，其TAG类型位UNIVERSAL（00）,属于结构类型（1），TAG值为16（10000）所以其类型标示字段值为（00110000），即为0x30。再如，证书扩展字段类型的数据块，TAG类型为（10），属结构类型（1），TAG的值为3（00011），所以其类型标示字段值为（10100011），即为0xA3。

　　2）数据块长度（1-128个字节）

　　长度字段，有两种编码格式。

　　若长度值小于等于127，则用一个字节表示，bit8 = 0, bit7-bit1 存放长度值；

　　若长度值大于127，则用多个字节表示，可以有2到127个字节。第一个字节的第8位为1，其它低7位给出后面该域使用的字节的数量，从该域第二个字节开始给出数据的长度，高位优先。

　　还有一种特殊情况，这个字节为0x80，表示数据块长度不定，由数据块结束标识结束数据块。

　　3）数据块的值

　　存放数据块的值，具体编码随数据块类型不同而不同。

　　4）数据块结束标识（可选）

　　结束标示字段，两个字节（0x0000）,只有在长度值为不定时才会出现。

#### X.509证书的结构

　　1）X.509证书基本部分

　　1.1）版本号.

　　　　标识证书的版本（版本1、版本2或是版本3）。

　　1.2）序列号

　　　　标识证书的唯一整数，由证书颁发者分配的本证书的唯一标识符。

　　1.3）签名

　　　　用于签证书的算法标识，由对象标识符加上相关的参数组成，用于说明本证书所用的数字签名算法。例如，SHA-1和RSA的对象标识符就用来说明该数字签名是利用RSA对SHA-1杂凑加密。

　　1.4）颁发者

　　　　证书颁发者的可识别名（DN）。

　　1.5）有效期

　　　　证书有效期的时间段。本字段由”Not Before”和”Not After”两项组成，它们分别由UTC时间或一般的时间表示（在RFC2459中有详细的时间表示规则）。

　　1.6)主体

　　　　证书拥有者的可识别名，这个字段必须是非空的，除非你在证书扩展中有别名。

　　1.7)主体公钥信息

　　　　主体的公钥（以及算法标识符）。

　　1.8)颁发者唯一标识符

　　　　标识符—证书颁发者的唯一标识符，仅在版本2和版本3中有要求，属于可选项。

　　1.9)主体唯一标识符

　　　　证书拥有者的唯一标识符，仅在版本2和版本3中有要求，属于可选项。

　　2）X.509证书扩展部分

　　可选的标准和专用的扩展（仅在版本2和版本3中使用），扩展部分的元素都有这样的结构：

　　Extension ::= SEQUENCE {

　　extnID OBJECT IDENTIFIER,

　　critical BOOLEAN DEFAULT FALSE,

　　extnValue OCTET STRING }

　　extnID：表示一个扩展元素的OID

　　critical：表示这个扩展元素是否极重要

　　extnValue：表示这个扩展元素的值，字符串类型。

　　2）扩展部分包括：

　　2.1）发行者密钥标识符

　　　　证书所含密钥的唯一标识符，用来区分同一证书拥有者的多对密钥。

　　2.2）密钥使用

　　　　一个比特串，指明（限定）证书的公钥可以完成的功能或服务，如：证书签名、数据加密等。如果某一证书将 KeyUsage 扩展标记为“极重要”，而且设置为“keyCertSign”，则在 SSL 通信期间该证书出现时将被拒绝，因为该证书扩展表示相关私钥应只用于签写证书，而不应该用于 SSL。

　　2.3）CRL分布点

　　　　指明CRL的分布地点。

　　2.4） 私钥的使用期

　　　 指明证书中与公钥相联系的私钥的使用期限，它也有Not Before和Not After组成。若此项不存在时，公私钥的使用期是一样的。

　　2.5） 证书策略

　　　　由对象标识符和限定符组成，这些对象标识符说明证书的颁发和使用策略有关。

　　2.6） 策略映射

　　　　表明两个CA域之间的一个或多个策略对象标识符的等价关系，仅在CA证书里存在。

　　2.7）主体别名

　　　　指出证书拥有者的别名，如电子邮件地址、IP地址等，别名是和DN绑定在一起的。

　　2.8） 颁发者别名

　　　　指出证书颁发者的别名，如电子邮件地址、IP地址等，但颁发者的DN必须出现在证书的颁发者字段。

　　2.9）主体目录属性

　　　　指出证书拥有者的一系列属性。可以使用这一项来传递访问控制信息。

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

## openssl
