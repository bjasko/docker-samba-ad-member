#!/bin/sh

# set IP alias 

SAMBA_NAME="beta"
S_HOST_IP="192.168.168.79" 
S_HOST_ETH="eth3" 

ip addr add $S_HOST_IP/24 dev $S_HOST_ETH

docker run -d --name $SAMBA_NAME \
     -p $S_HOST_IP:138:138/udp -p $S_HOST_IP:139:139   \
     -p $S_HOST_IP:445:445  \
     -v /data/samba/beta-samba:/var/lib/samba \
     -v /data/samba/beta-etc:/etc/samba \
     --dns=192.168.168.89 \
     samba-ad-member /bin/bash
