#!/bin/bash

### VARS ###
export K3S_TOKEN="sup3rsecr3t"
### END VARS ###

ME=`whoami`

if [ "$ME" != "root" ]; then 
    echo "You are not root, please sudo or become root"
    exit 1
fi

hostnamectl set-hostname ubuntu-server

apt-get update -y
apt-get upgrade -y

apt-get install -y curl git nano

curl -sfL https://get.k3s.io | sh -