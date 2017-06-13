---
layout: default
category: Developer
order: 2
---

This guide explains how an installation of the network components of MakerLab 
can be accomplished. We suggest that this installation be done in a different 
machine than where the core components are installed and on a machine with
good CPU performance, a lot of storage space and two network interfaces
(alternatively create two virtual interfaces) and a lot of storage space. 
These instructions are also at the `network` repository, as well as the code 
to run everything. We also recommend that you perform this installation on 
a Debian Jessie machine, since it's the only distro where we guarantee 
full compatibility.

## Updates

```bash
sudo apt-get update
sudo apt-get -y upgrade
```

## Necessary packets

```bash
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    vim \
    git \
    python3-dev \
    python3-pip \
    linux-image-amd64 \
    uuid-runtime \
    libpq-dev \
    postgresql-client \
    gcc \
    automake \
    make
```

## Adding Debian testing repository

It's necessary to add the `testing` repository in order to update to the latest
kernel version, due to Open vSwitch compatibility.

```bash
echo 'deb http://http.us.debian.org/debian testing main non-free contrib' >> /etc/apt/sources.list
echo 'deb-src http://http.us.debian.org/debian testing main non-free contrib' >> /etc/apt/sources.list
```

## Update Kernel version

In order to support VxLAN tunnels, Open vSwitch requires the most up to date
kernel image.

```bash
sudo apt-get update

sudo apt-get install linux-headers-4.9.0-3-amd64 linux-image-4.9.0-3-amd64
sudo reboot
```

## Open vSwitch

```bash
wget http://openvswitch.org/releases/openvswitch-2.7.0.tar.gz
tar -xf openvswitch-2.7.0.tar.gz
cd openvswitch-2.7.0/
```

```bash
./configure
```

```bash
make
```

```bash
make install
```
```bash
export PATH=$PATH:/usr/local/share/openvswitch/scripts
ovs-ctl --system-id=random start
```

```bash
cd
```

## Docker

```bash
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
```

```bash
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
```

```bash
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"
```

```bash
sudo apt-get update
sudo apt-get -y install docker-ce
```

```bash
sudo service docker start
sudo usermod -aG docker $USER
sudo systemctl enable docker
```

Docker fix
```bash
sudo echo 'GRUB_CMDLINE_LINUX_DEFAULT="quiet cgroup_enable=memory swapaccount=1" ' >> /etc/default/grub
sudo update-grub
sudo reboot
```

## Network repo

```bash
git clone git@gitlab.com:makerlab/network.git
```

## OvS-Docker

This script contains a command-line interface to attack containers to 
Open vSwitch bridges.

```bash
sudo cp network/datacenter-master/ovs-docker /usr/bin
sudo chmod a+rwx /usr/bin/ovs-docker
```

## Ryu OpenFlow controller

Installation of the OpenFlow SDN controller framework.

```bash
git clone git://github.com/osrg/ryu.git
cd ryu
pip3 install .
```

## Python

This installation handles system-wide packages used by DML's network.

```bash
sudo pip3 install flask docker psycopg2
```

## Open vSwitch bridges

Install the needed bridges. It requires at least two network interfaces.

Routing bridge
```bash
sudo ovs-vsctl add-br br-routing
sudo ovs-vsctl add-port br-routing eth1
```

VTEP bridge
```bash
DML_IP=x.x.x.x
```

```bash
sudo ovs-vsctl add-br br-vtep
sudo ovs-vsctl set-fail-mode br-vtep secure # make flows permanent
```

Add and configure VxLAN VTEP
```bash
sudo ovs-vsctl add-port br-vtep vxlan-vtep
sudo ovs-vsctl set bridge br-vtep protocols=OpenFlow10,OpenFlow11,OpenFlow12,OpenFlow13
sudo ovs-vsctl set interface vxlan-vtep type=vxlan options:remote_ip=${DML_IP} options:key=flow
```

## Containers

Build pre-defined Docker containers.

Router container
```bash
cd ~/network/datacenter-master/router-container/
docker build -t router -f Dockerfile .
```

Ubuntu with SSH server container
```bash
cd ../ubuntu-ssh-container/
docker build -t ubuntu_ssh -f Dockerfile .
```

```bash
cd ..
```

## Postgres

```bash
POSTGRES_PASSWORD=**** \
    docker run --restart=always --name dml-postgres -p 127.0.0.1:5433:5432 \
    -e POSTGRES_PASSWORD="$POSTGRES_PASSWORD" -d postgres

psql -h 127.0.0.1 -p 5432 -U postgres postgres < db.sql
```

## Startup script

This script will automatically start OvS, Docker and all the containers that
were running when the system went down.

```bash
sudo cp /home/dml-net/network/datacenter-master/dml_startup.sh /etc/init.d/
sudo chmod +x /etc/init.d/dml_startup.sh
sudo update-rc.d dml_startup.sh defaults
```
