---
layout: default
category: User
order: 2
---

The network manager is in charge of all things network. It's main goal is to provide a private network to each project, with internet connectivity, aswell as the possibility of launching Docker containers for testing and deployment. All the traffic is completely isolated from each network and the users can access their projects' networks and containers by associating RJ-45 sockets at DML's room to them.

## Interface

All the communication with the manager will be performed by the Wiki, and it will have a similar workflow to the requisition of an electronic resource. Both the creation and change of state of containers (start and stop), aswell as the association of RJ-45 sockets to access the private network will have specific interfaces inside the Wiki.

## Datacenter

The "core" of each project network will be hosted on a datacenter, where the containers will be orchestrated and the NAT/PAT mechanisms will provide internet access to all the hosts across the private networks.

## The Room

It'll be at DETI MakerLab that the users will connect to their projects' networks, where there are several RJ-45 sockets and a SDN enabled Switch to control all the traffic inside the room and forward it to the datacenter.

## Architecture

A simple diagram of the network architecture is in the following image:

![Network Architecture](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/network-architecture.png?alt=media&token=2d083793-1ecd-46c3-b481-fbc999b3bdf6)
{:center}
