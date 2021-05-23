# curl

https://ec.haxx.se/

```
Client          LocalDNS            LoadBalancer          BackendService
                  |                |                    |                           |
                  |--1.1 DNS Req---|                    |                           |
time_namelookup   |<-1.2 DNS Resp--|                    |                           |
                  |                                     |                           |
                  |---------2.1 TCP SYNC--------------->|                           |
                  |<--------2.2 TCP ACK/SYNC------------|                           |
time_connect      |---------2.3 TCP ACK---------------->|                           |
                  |                                     |                           |
                  |--3.1 SSL ClientHello--------------->|                           |
                  |<-3.2 SSL ServerHello/Certificate----|                           |
                  |--3.3 SSL ClientKeyEx/ChangeCipher-->|                           |
time_appconnect   |<-3.4 SSL ChangeCipher/Finished------|                           |
                  |                                     |                           |
time_pretransfer  |--4.1 HTTP Request------------------>|                           |
                  |<-4.2 HTTP StatusCode 100 Continue---|                           |
                  |--4.3 HTTP Request Complete--------->|                           |
                  |                                     |--4.4 HTTP Request-------->|
                  |                                     |<-4.5 HTTP Response--------|
time_starttransfer|<-4.6 HTTP Response------------------|                           |
time_total        |                                     |                           |
```

curl -w "
      http_code: %{http_code}
     DNS Lookup: %{time_namelookup}
  TCP handshake: %{time_connect}
  TLS handshake: %{time_appconnect} 
    pretransfer: %{time_pretransfer}
  starttransfer: %{time_starttransfer}
                 ----------
     time_total: %{time_total}\n" -so /dev/null https://tcb-api.tencentcloudapi.com/web?env=prod-80f7de
