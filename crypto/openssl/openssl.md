# OpenSSl

* openssl：多用途的命令行工具
* libcrypto：加密算法库
* libssl：加密模块应用库，实现了ssl及tls

refs:

* https://github.com/KaiZhang890/openssl-howto
* http://seanlook.com/2015/01/18/openssl-self-sign-ca/
* http://seanlook.com/2015/01/07/tls-ssl/
* http://seanlook.com/2015/01/15/openssl-certificate-encryption/
* https://www.madboa.com/geek/openssl/
* http://blog.51cto.com/cuchadanfan/1680216

## openssl

### 对称加密

```sh
openssl enc -ciphername [-in filename] [-out filename] [-pass arg] [-e] [-d] [-a/-base64]
       [-A] [-k password] [-kfile filename] [-K key] [-iv IV] [-S salt] [-salt] [-nosalt] [-z] [-md]
       [-p] [-P] [-bufsize number] [-nopad] [-debug] [-none] [-engine id]
```

```sh
# openssl enc -e -des3 -a -salt -in fstab -out e.txt
# openssl enc -d -des3 -a -salt -in fstab -out d.txt
```

### 单向加密

```sh
openssl dgst [-md5|-md4|-md2|-sha1|-sha|-mdc2|-ripemd160|-dss1] [-c] [-d] [-hex] [-binary]
       [-out filename] [-sign filename] [-keyform arg] [-passin arg] [-verify filename] [-prverify
       filename] [-signature filename] [-hmac key] [file...]
# md5sum，sha1sum，sha224sum，sha256sum ，sha384sum，sha512sum
```

```sh
echo HaHa! | openssl dgst -md5
```

### 公钥加密

### 生成密码

```sh
openssl passwd [-crypt] [-1] [-apr1] [-salt string] [-in file] [-stdin] [-noverify] [-quiet] [-table] {password}
```

```sh
openssl passwd
```

### 生成随机数

```sh
openssl rand [-out file] [-rand file(s)] [-base64] [-hex] num
```

```sh
openssl rand -base64 10
```

### 生成秘钥对

```sh
openssl genrsa [-out filename] [-passout arg] [-des] [-des3] [-idea] [-f4] [-3] [-rand file(s)] [-engine id] [numbits]
```

生成私钥

```sh
openssl genrsa -out test_rsa 4096
```

### RSA

```sh
openssl rsa [-inform PEM|NET|DER] [-outform PEM|NET|DER] [-in filename] [-passin arg] [-out filename] [-passout arg]
       [-sgckey] [-des] [-des3] [-idea] [-text] [-noout] [-modulus] [-check] [-pubin] [-pubout] [-engine id]
```

提取出公钥

```sh
openssl rsa -pubout -in test_rsa -out test_rsa.pub
```

### 创建CA和申请证书

（1）、创建自签证书

第一步：创建为 CA 提供所需的目录及文件

mkdir -pv CA/{certs,crl,newcerts,private}
touch CA/{serial,index.txt}
cd CA

第二步：指明证书的开始编号

echo 01 >> serial

第三步：生成私钥，私钥的文件名与存放位置要与配置文件中的设置相匹配；

openssl genrsa -out private/cakey.pem 4096

第四步：生成自签证书，自签证书的存放位置也要与配置文件中的设置相匹配，生成证书时需要填写相应的信息；

openssl req -new -x509 -days 3650 -key private/cakey.pem -out cacert.pem


（2）颁发证书

第一步：在需要使用证书的主机上生成私钥，这个私钥文件的位置可以随意定

openssl genrsa -out test_rsa 4096

第二步：生成证书签署请求

```sh
openssl req -new -days 3650 -key test_rsa.key -out test_rsa.csr
```

第三步：将请求通过可靠方式发送给 CA 主机

```sh
cp test_rsa.csr CA
```

第四步：CA 服务器拿到证书签署请求文件后颁发证书，这一步是在 CA 服务器上做的

```sh
/usr/local/Cellar/openssl/1.0.2n/bin/openssl ca -in test_rsa.csr -out certs/test.crt -days 3650
openssl ca -in test_rsa.csr -out certs/test.crt -days 3650

$ /usr/local/Cellar/openssl/1.0.2n/bin/openssl ca -in test_rsa.csr -out certs/test.crt -days 3650
Using configuration from /usr/local/etc/openssl/openssl.cnf
Check that the request matches the signature
Signature ok
Certificate Details:
        Serial Number: 1 (0x1)
        Validity
            Not Before: Feb  2 07:20:04 2018 GMT
            Not After : Jan 31 07:20:04 2028 GMT
        Subject:
            countryName               = CN
            stateOrProvinceName       = ShangHai
            organizationName          = xyz
            organizationalUnitName    = xyz
            commonName                = xyz.
            emailAddress              = xyz@xyz.com
        X509v3 extensions:
            X509v3 Basic Constraints:
                CA:FALSE
            Netscape Comment:
                OpenSSL Generated Certificate
            X509v3 Subject Key Identifier:
                FF:86:86:0F:85:B0:B2:27:53:92:14:9F:51:24:91:18:8C:19:77:92
            X509v3 Authority Key Identifier:
                DirName:/C=CN/ST=ShangHai/L=ShangHai/O=xyz/OU=xyz/CN=xyz.com./emailAddress=xyz@xyz.com
                serial:9C:9C:95:85:12:9C:1A:FE

Certificate is to be certified until Jan 31 07:20:04 2028 GMT (3650 days)
Sign the certificate? [y/n]:y


1 out of 1 certificate requests certified, commit? [y/n]y
Write out database with 1 new entries
Data Base Updated
```

openssl ca -keyfile private/ca.key.pem -cert private/ca.cert.pem -in private/ca.csr -out private/ca.crt -days 3650 # 证书签名

openssl ca -revoke ## 证书吊销


## 签名

用公钥恢复签名文件的内容：

openssl pkeyutl -verifyrecover -pubin -inkey pubkey.pem -in tos.sig

用私钥解密文件：

openssl pkeyutl -decrypt -inkey key.pem -in tos.enc -out tos.dec
