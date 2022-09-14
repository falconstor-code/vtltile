#!/bin/bash

config
set protocols static route 172.20.2.1/30 next-hop "$private_ipv4_address"
set protocols static route 192.168.100.14/24 next-hop 172.20.2.5
set interfaces tunnel tun0 address 172.20.2.6/30
set interfaces tunnel tun0 local-ip "$private_ipv4_address"
set interfaces tunnel tun0 remote-ip 172.20.1.1
set interfaces tunnel tun0 encapsulation gre
set interfaces tunnel tun0 mtu 1300
commit
exit