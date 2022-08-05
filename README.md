# Stunnel Socks5 server

This project helps you to run a Socks5 server without any authentication.  
I use this for my local proxy purpose, traffic move via Wireguard to the outside of the country and this proxy help me to forward my script traffic (like Python) via that Wireguard interface.

## How to use
At first you should connect to a Wreguard server and create a route table for the Wireguard, it happens via this config in the Wireguard config file:
```
Table = 2022
```
* `2022` is an example  

Then, you should create a network via command below:
```sh
docker network create -d bridge --subnet=192.168.75.0/24 --gateway=192.168.75.1 vpn
```
Now, You should config the route for the `vpn` network and also add a rule for that network.
```sh
ip rule add from 192.168.75.0/24 lookup 2022
ip route add $(ip route | grep '192.168.75.0/24')table 2022
```
Finally, you can create a new container on this network.
```sh
docker pull ghcr.io/rasooll/stunnel-socks-server:latest
docker run --name socks5-server -d -p 127.0.0.1:1080:1080 --network vpn ghcr.io/rasooll/stunnel-socks-server:latest
```

## Important note
This project is used personally and may not be useful for all people, I suggest using other Socks5 servers for ordinary purposes.