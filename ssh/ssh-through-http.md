# tunneling SSH through HTTP

## Tools

* [corkscrew](https://github.com/bryanpkc/corkscrew)

install on MacOS

```sh
brew install corkscrew
```

Edit `~/.ssh/config`

```txt
Host github.com
    ProxyCommand corkscrew http-proxy.example.com 8080 %h %p
```

* [connect](https://github.com/larryhou/connect-proxy)

```sh
brew install connect
```

## Refs

* https://daniel.haxx.se/docs/sshproxy.html
* https://www.zeitoun.net/articles/ssh-through-http-proxy/start

