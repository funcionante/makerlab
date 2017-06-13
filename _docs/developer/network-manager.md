---
layout: default
category: Developer
order: 18
---

The network manager is in charge of all things network. It's main goal is to
provide a private network to each project, with internet connectivity,
as well as the possibility of launching Docker containers for testing
and deployment. All the traffic is completely isolated from each network
and the users can access their projects' networks and containers by associating
RJ-45 sockets at DML's room to them.

A simplified vision of our network architecture would be:

![Network Architecture](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/network%2FNetwork%20Diagram.png?alt=media&token=8cb4994b-84d3-485f-b763-1ae706160b9d)
{:center}

## Before Starting

The "core" of each project's network will be hosted on a datacenter, where
the containers will be orchestrated and the NAT/PAT mechanisms will provide
internet access to all the hosts across the private networks.

In order to fulfill time milestones, it was decided that this 
implementation of the container orchestration will be focused on a single-host
datacenter architecture, **rather than** a swarm-like implementation.

The datacenter will be running an HTTP server (NetManager), that will fulfill 
all the requests of the DML's API, and will be responsible for managing all
the Open vSwitch bridges, containers and the associated ports of the projects.

The datacenter will also be running the SDN Controller responsible for 
controlling the switch's traffic at the DETI MakerLab room.

Both the NetManager and SDN Controller will be using the same PostgreSQL
database, where it'll be stored all the information relative to the network.
At the moment, all the requests made to the NetManager come exclusively from the 
`dml-servant`. The following image describes the current architecture in place:

![Datacenter Architecture](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/network%2FDatacenter%20Diagram.png?alt=media&token=800c6687-1d66-489e-ab87-53fba4ae46b0)
{:center}

## NetManager

The controller behind managing all the things at the Datacenter is 
a flask powered HTTP Server, with the assistance of a PostgreSQL database to
store all the networking-relative information.
Its main functionalities are:
*   Creation and destruction of a project's network --- when the first container
is launched (within the scope of a project) or a ethernet port is requested, 
an OvS bridge is created and a router-like container is started;
*   Creation and destruction of containers --- either a pre-built container or
built with a Dockerfile provided by the user;
*   Change of state (start and stop) of containers;
*   Association of RJ-45 sockets (based on a printed ID on them) to projects'
networks (in order to let the SDN controller know which ports belong to the
projects' VLANs);
*   Informational endpoints to the platform's API, mainly to the `dml-servant`,
returning container's DockerIDs, IPs, status, logs and more.

### Project's vSwitch

Project's vSwitch is nothing more than a virtual switch (using Open vSwitch), 
created in the scope of each project (when the first container is created
or a port is requested) and that will have two main purposes:
*   Operate as a switch/bridge for attaching containers;
*   Create a connection between the project's switch and the VTEP bridge to
send the traffic trough the VxLAN tunnel, so that all containers and users' 
terminals (laptops, etc.) at DML coexist inside the same Layer 2 network 
(private network of each project).

### "Router" container

Each private network, after the creation of its OvS bridge, will be provided
with a container that will operate like a router, creating the "bridge" between
this network and the internet, using NAT/PAT mechanisms, and operating like
a DHCP server, providing IP addresses to all the hosts within that network.

### Container Orchestration Architecture

A more comprehensive view on the internal works of the datacenter orchestration
can be seen in the following image.

![Container Architecture](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/network%2FOvS%20Diagram.png?alt=media&token=93e0456f-c34c-4f50-9a5b-8dd0cff272ef)
{:center}

There are two main bridges that are created with the system deployment:
*   Routing bridge --- aggregates all the public routers' interfaces,
as well as a network interface of the deployment machine, allowing the routers
to obtain a public IP address;
*   VTEP bridge --- aggregates all the patch ports that connect directly to the
projects' vSwitches. It'll operate as a OpenFlow virtual switch, since, by the
time a project bridge is created, two flows are installed on the bridge,
in order to redirect traffic coming from the VxLAN tunnel to the project's 
vSwitch and vice-versa.

### Setup

For the complete setup instructions, please look for the network installation 
guide for detailed instructions of how to set up all the network related 
components.

### Endpoints

The `datacenter-master/server.py` contains a flask app which provides a set of 
endpoints to manage all the networking. These are described below. However, there 
are other auxiliary methods that are not displayed here, but they are well
documented in the code.

In all endpoints, json is returned. A return code of 400 or 500 along the with
an error message is returned in case of failure, otherwise 200 is returned 
(unless something unexpected happens).

#### Add port

Accepting a given `user_id`, `project_id` (id of a project) and a port number, 
adds that port to the VLAN of that project, using the SDN controller.

```
/add-port/<int:user_id>/<int:project_id>/<int:port_id>/

user_id: ID of the user on the platform
project_id: ID of the project that the port will be associated to
port_id: Ethernet socket port number that will be requested

    POST: Returns a successful HTTP response
```

#### Remove port

Accepting a given `user_id` and a port number, removes that port to the VLAN 
of that project, using the SDN controller.

```
/remove-port/<int:user_id>/<int:port_id>/

user_id: ID of the user on the platform
port_id: Ethernet socket port number that will be freed

    POST: Returns a successful HTTP response
```

#### Create project bridge

Accepting a given` user_id` and a `project_id` (id of a project), 
creates a new OvS bridge and launches its router-like container.

```
/create-bridge/<int:user_id>/<int:project_id>/

user_id: ID of the user on the platform
project_id: ID of the project that will have the bridge associated to

    POST: Returns a successful HTTP response
```

#### Delete project bridge

Accepting a given `user_id` and a `project_id` (id of a project), deletes 
the corresponding OvS bridge and all its containers.

```
/delete-bridge/<int:user_id>/<int:project_id>/

user_id: ID of the user on the platform
project_id: ID of the project that will have the bridge associated to

    POST: Returns a successful HTTP response
```

#### New container

Accepting a given `user_id`, a `project_id` (id of a project), and possibly 
a Dockerfile, launches a new container.

```
/new-container/<int:user_id>/<int:project_id>/

user_id: ID of the user on the platform.
project_id: ID of the project (bridge) that the new container will be 
attached to
dockerfile: In attachment might be a dockerfile, describing the container
that'll be launched

    POST: Returns a dictionary with {success, container_name, ip, docker_id}
```

#### Update container

Accepting a given `user_id`, a `docker_id` and a Dockerfile, 
updates the container.

```
/update-container/<int:user_id>/<docker_id>/

user_id: ID of the user on the platform.
docker_id: ID of the Docker container that will be updated 
dockerfile: In attachment, it should be a dockerfile, describing the container
that'll be launched.

    POST: Returns a dictionary with {success, container_name, ip, docker_id}
```

#### Delete container

Given a `user_id` and a `docker_id`, stops and removes 
the corresponding container.

```
/remove-container/<int:user_id>/<docker_id>/

user_id: ID of the user on the platform.
docker_id: ID of the Docker container that will be updated 

    POST: Returns a successful HTTP response
```

#### Get project's containers

Given a `user_id` and a `project_id` (id of a project), returns all the 
containers info related to the project.

```
/get-project-containers/<int:user_id>/<int:project_id>/

user_id: ID of the user on the platform.
project_id: ID of the project 

    GET: Returns a dictionary with {success, containers}
```

#### Get container info

Accepting a given `user_id`, `docker_id`, returns all info about it: 
IP, DockerID, status and CPU and memory usage stats.

```
/get-container-info/<int:user_id>/<docker_id>/

user_id: ID of the user on the platform.
docker_id: ID of the Docker container that the info is requested

    GET: Returns a dictionary with {success, stats={id, docker_id, status, 
    cpu, mem_used, mem_limit, mem_perc}}
```

#### Get container logs

Accepting a `user_id` and a `docker_id`, returns its last 50 lines of log.

```
/get-container-logs/<int:user_id>/<docker_id>/

user_id: ID of the user on the platform.
docker_id: ID of the Docker container that the info is requested

    GET: Returns a dictionary with {success, logs}
```

#### Start container

Accepting a given `user_id` and `docker_id`, 
starts the corresponding container.

```
/start-container/<int:user_id>/<docker_id>/

user_id: ID of the user on the platform.
docker_id: ID of the Docker container that'll be started

    GET: Returns a dictionary with {success, ip, docker_id}
```

#### Stop container

Accepting a given `user_id` and `docker_id`,
stops the corresponding container.

```
/stop-container/<int:user_id>/<docker_id>/

user_id: ID of the user on the platform.
docker_id: ID of the Docker container that'll be stoped

    GET: Returns a successful HTTP response
```

#### Restart container

Accepting a given `user_id` and `docker_id`, restarts 
the corresponding container.

```
/restart-container/<int:user_id>/<docker_id>/

user_id: ID of the user on the platform.
docker_id: ID of the Docker container that'll be restarted

    GET: Returns a dictionary with {success, ip, docker_id}
```


## SDN Controller

It'll be at the DETI MakerLab room that the users will connect to their projects'
networks, where there are several RJ-45 sockets and a OpenFlow enabled Switch to
control all the traffic inside the room and forward it to the datacenter.

To connect all the hosts at DML, a OpenFlow enabled Switch must exist but,
in order to work as intended, a SDN controller is also needed.

This controller will be responsible for:
*   Analyzing and redirecting packets that the Switch are not familiar with and
to tell it where to forward them, may their destination be an host at the room
or a VM through the VxLAN tunnel;
*   Installing OpenFlow rules in the Switch, so that the packets with a similar
destination would be automatically redirected without the need of sending them
to the controller.

Although the SDN controller initially provided an HTTP REST endpoints, it's
deprecated an not used at the moment, but in the future it might be useful. 
With that in mind, the SDN controller runs an HTTP server, but without any 
current endpoints.

To start the SDN controller, just use `ryu-manager sdn-controller/dml_switch_rest.py`. 

The controller contains the following methods:

#### Get IP (class method)

Returns the IP of a project VLAN given a certain `project_id`.

```
project_id: ID of the project

    Returns: string containing the IP address.
```

#### Get VNI (class method)

Returns the VLAN ID / VNI, which equals the `project_id`, given an IP of a
project VLAN.

```
ip: a given IP address

    Returns: the VLAN ID / VNI of a project's network
```

#### Get All Reserved Ports

Returns a list of all already reserved ports currently in the network database.

```
ip: a given IP address

    Returns: list of integers - port numbers
```

#### Get VLAN Port

Given a certain port number, returns the VLAN ID that's associated to.

```
port: ethernet port number

    Returns: the VLAN ID / VNI of the network the given port is associated to
```

#### Switch Features Handler

Receving an OpenFlow event as input, installs a table-miss flow entry.
At the moment, if it specified a lesser number, e.g., 128, 
OvS will send Packet-In with invalid `buffer_id` and truncated packet data. 
In that case, it is not possible to output packets correctly.

```
ev: An OpenFlow event, that contains a packet message and the involved protocols

    Returns: None
```

#### Add flow

Creates a new OpenFlow flow in the current datapath (table 0).

```
datapath: Datapath of the OpenFlow controlled switch
priority: Priority of the flow
match: Packets matching conditions config
actions: Actions to perform given the selected packets
buffer_id: used Buffer ID
    
    Returns: None
```

#### Parse VxLAN broadcast

Given a certain packet message and its headers that comes from the VxLAN tunnel
port and that the destination MAC address is the broadcast address, this method
parses that packet, figuring out which VNI / VLAN ID the packet carries and send
it to the correct ports.

```
msg: Message of a packet
header_list: List of headers of the given message

    Returns: None
```

#### Packet-In handler

Given an OpenFlow event, parses that event packet.

According to the In-Packet origin, there are multiple alternatives:
*   If the traffic comes from the VxLAN tunnel port with the broadcast MAC
destination, calls the `_parse_vxlan_broadcast` method with the given packet 
message and its headers;
*   If the traffic comes from the VxLAN tunnel port with a destination IP 
address, use the `get_vni` method to obtain the VLAN ID to forward it to the 
correct VLAN;
*   If the traffic comes from an host directly connected to the switch, obtain
its VLAN ID using the `get_port_to_vlan` method;

According to the In-Packet destination:
*   If the packet's destination MAC address is unknown (not present in the ARP
table at the time), send the packet to all the VLAN ports, including the VxLAN
tunnel port (flooding process);
*   If the packet's destination MAC address is known, send it to the correct
port and call the `add_flow` method to regist a new flow at the switch to 
prevent these known "routes" to be constantly redirected to the SDN controller;

It is worth poiting out that, if a packet is redirected to the VxLAN tunnel
port, it's necessarily added a new OpenFlow message field with the corresponding
VNI / VLAN ID.


```
ev: An OpenFlow event, that contains a packet message and the involved protocols

    Returns: None
```

<!-- -->
{:center: style="text-align: center"}
