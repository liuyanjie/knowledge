# strongswan

## install

```sh
yum install strongswan
systemctl enable strongswan
```

acme.sh --issue -d ikev2.myoffer.com -w /root/ikev2.myoffer.com


```sh
Do you use firewall in CentOS7 instead of iptables?
yes or no?(default_value:no):
ip address info:
    inet 127.0.0.1/8 scope host lo
    inet 10.10.1.185/24 brd 10.10.1.255 scope global eth0
    inet 192.168.16.1/20 brd 192.168.31.255 scope global br-5862cc3d0ad6
    inet 192.168.0.1/20 brd 192.168.15.255 scope global docker0
The above content is the network card information of your VPS.
[Important]Please enter the name of the interface which can be connected to the public network.
Network card interface(default_value:eth0):
The service command supports only basic LSB actions (start, stop, restart, try-restart, reload, force-reload, status). For other actions, please try to use systemctl.
Stopping strongSwan IPsec...
Starting strongSwan 5.5.1 IPsec [starter]...
#############################################################
#
# [Install Complete]
# Version:1.2.0
# There is the default login info of your IPSec/IkeV2 VPN Service
# UserName: myUserName
# PassWord: myUserPass
# PSK: myPSKkey
# you should change default username and password in /usr/local/etc/ipsec.secrets
# you cert: /root/ipsec/my_key/ca.cert.pem
# you don't need to install cert if it's be trusted.
#
#############################################################
```

docker run --privileged -d --name ikev2-vpn-server --restart=always -p 500:500/udp -p 4500:4500/udp gaomd/ikev2-vpn-server:0.3.0

docker run --privileged -i -t --rm --volumes-from ikev2-vpn-server -e "HOST=ikev2-vpn.myofferdemo.com" gaomd/ikev2-vpn-server:0.3.0 generate-mobileconfig > ikev2-vpn.mobileconfig
