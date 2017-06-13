---
layout: default
category: Specifications
order: 6
---

The network manager is in charge of all things network. It's main goal is to
provide a private network to each project, with internet connectivity,
as well as the possibility of launching Docker containers for testing
and deployment. All the traffic is completely isolated from each network
and the users can access their projects' networks and containers by associating
RJ-45 sockets at DML's room to them.

## Datacenter

The "core" of each project's network will be hosted on a datacenter, where
the containers will be orchestrated and the NAT/PAT mechanisms will provide
internet access to all the hosts across the private networks.

In order to fulfill time milestones, it was decided that this year's
implementation of the container orchestration will be focused on a single-host
datacenter architecture, **rather than** a swarm-like implementation.

The datacenter will be running an HTTP server, that will fulfill all
the requests of the DML's API, and will be responsible for managing all
the Open vSwitch bridges and containers of the projects.

### NetManager API

The API behind managing all the things at the Datacenter is an HTTP Server.
Its main functionalities are:
*   Creation and destruction of a project network --- when the first container
is launched (within the scope of a project), an OvS bridge is created and
a router-like container is started;
*   Creation and destruction of containers --- either a pre-built container or
built with a Dockerfile provided by the user;
*   Change of state (start and stop) of containers;
*   Association of RJ-45 sockets (based on a printed ID on them) to projects'
networks (communication with the SDN controller);
*   Informational endpoint to the platform's API, to feed the mobile apps and
the Wiki with all the info related to the network.

### Open vSwitch

Open vSwitch is nothing more than a virtual switch, created in the scope of
each project (when the first container is created) and that will have two
main purposes:
*   Operate as a switch/bridge for attaching containers;
*   Create the VXLAN tunnel between the datacenter and the DML's room, so that
all containers and users' terminals (laptops, etc.) at DML coexist inside the
same Layer 2 network (private network of each project).

### "Router" container

Each private network, after the creation of its OvS bridge, will be provided
with a container that will operate like a router, creating the "bridge" between
this network and the internet, using NAT/PAT mechanisms, and operating like
a DHCP server, providing IP addresses to all hosts.

### Datacenter Architecture

A more comprehensive view on the internal works of the datacenter orchestration
can be seen in the following image, where an OvS bridge is presented that will
aggregate all the "router" containers and an individual bridge for a certain
project, with its VXLAN port and several containers connected.

![Datacenter Architecture](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/datacenter-architecture.png?alt=media&token=6a84f831-fb9f-4e0c-ae56-024df3e13db1)
{:center}

## The Room

It'll be at DETI MakerLab that the users will connect to their projects'
networks, where there are several RJ-45 sockets and a SDN enabled Switch to
control all the traffic inside the room and forward it to the datacenter.

### SDN Controller

To connect all the hosts at DML, a SDN enabled Switch will exist but,
in order to work as intended, a SDN controller is also needed.

This controller will be responsible for:
*   Analyzing, redirecting and encapsulating (VXLAN encapsulation, in case of
a packet that will be forwarded to the Datacenter) packets that the Switch
doesn't know what to do with them;
*   Installing OpenFlow rules in the Switch, so that packets with a similar
behavior would be automatically redirected without the need of sending them
to the controller.

## Architecture

A simple diagram of the network architecture is in the following image:

![Network Architecture](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/network-architecture.png?alt=media&token=2d083793-1ecd-46c3-b481-fbc999b3bdf6)
{:center}

<!-- -->
{:center: style="text-align: center"}
