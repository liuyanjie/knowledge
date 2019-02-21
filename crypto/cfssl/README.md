# cfssl

## install

```sh
brew install cfssl
```


cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=server ca-csr.json | cfssljson -bare server
