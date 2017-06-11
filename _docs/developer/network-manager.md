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

A simplified vision of our network would be:
![Network Architecture](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/network%2FNetwork%20Diagram.png?alt=media&token=7d139dc8-4a95-4986-b7ee-c1b023160c92)
{:center}


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
store all the networking-relating information.
Its main functionalities are:
*   Creation and destruction of a project's network --- when the first container
is launched (within the scope of a project), an OvS bridge is created and
a router-like container is started;
*   Creation and destruction of containers --- either a pre-built container or
built with a Dockerfile provided by the user;
*   Change of state (start and stop) of containers;
*   Association of RJ-45 sockets (based on a printed ID on them) to projects'
networks (communication with the SDN controller);
*   Informational endpoints to the platform's API, mainly to the dml-servant,
returning container's DockerIDs, IPs, status, logs and more.

### Project's vSwitch

Project's vSwitch is nothing more than a virtual switch (using Open vSwitch), 
created in the scope of each project (when the first container is created)
and that will have two main purposes:
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
time a project bridge is created, it is installed two flows on the bridge,
for redirecting traffic incoming from the VxLAN tunnel to the project's vSwitch
and vice-versa.

### Setup

For the complete setup instructions, please look for the network installation 
guide for more details.

### Endpoints

The `datacenter-master/server.py` contains a flask app which provides a set of 
endpoints to manage all the networking. These are described below. However, there 
are other auxiliary methods that are not displayed here, but they are well
documented in the code.

In all endpoints, json is returned. A return code of 400 or 500 along the with
an error message is returned in case of failure, otherwise 200 is returned 
(unless something unexpected happens).

#### Add port

Accepting a given user\_id, project\_id (id of a project) and a port number, 
adds that port to the VLAN of that project, using the SDN controller.

```
/add-port/<int:user_id>/<int:project_id>/<int:port_id>/

user_id: ID of the user on the platform
project_id: ID of the project that the port will be associated to
port_id: Ethernet socket port number that will be requested

    POST: Returns a successful HTTP response
```

#### Remove port

Accepting a given user\_id and a port number, removes that port to the VLAN 
of that project, using the SDN controller.

```
/remove-port/<int:user_id>/<int:port_id>/

user_id: ID of the user on the platform
port_id: Ethernet socket port number that will be freed

    POST: Returns a successful HTTP response
```

#### Create project bridge

Accepting a given user\_id and a project\_id (id of a project), 
creates a new OvS bridge and launches its router-like container.

```
/create-bridge/<int:user_id>/<int:project_id>/

user_id: ID of the user on the platform
project_id: ID of the project that will have the bridge associated to

    POST: Returns a successful HTTP response
```

#### Delete project bridge

Accepting a given user\_id and a project\_id (id of a project), deletes 
the corresponding OvS bridge and all its containers.

```
/delete-bridge/<int:user_id>/<int:project_id>/

user_id: ID of the user on the platform
project_id: ID of the project that will have the bridge associated to

    POST: Returns a successful HTTP response
```

#### New container

Accepting a given user\_id, a project\_id (id of a project), and possibly 
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

Accepting a given user\_id, a docker\_id and a Dockerfile, updates the container.

```
/update-container/<int:user_id>/<docker_id>/

user_id: ID of the user on the platform.
docker_id: ID of the Docker container that will be updated 
dockerfile: In attachment, it should be a dockerfile, describing the container
that'll be launched.

    POST: Returns a dictionary with {success, container_name, ip, docker_id}
```

#### Delete container

Given a user\_id and a docker\_id, stops and removes the corresponding container.

```
/remove-container/<int:user_id>/<docker_id>/

user_id: ID of the user on the platform.
docker_id: ID of the Docker container that will be updated 

    POST: Returns a successful HTTP response
```

#### Get project's containers

Given a user\_id and a project\_id (id of a project), returns all the 
containers info related to the project.

```
/get-project-containers/<int:user_id>/<int:project_id>/

user_id: ID of the user on the platform.
project_id: ID of the project 

    GET: Returns a dictionary with {success, containers}
```

#### Get container info

Accepting a given user\_id, docker\_id, returns all info about it: 
IP, DockerID, status and CPU and memory usage stats.

```
/get-container-info/<int:user_id>/<docker_id>/

user_id: ID of the user on the platform.
docker_id: ID of the Docker container that the info is requested

    GET: Returns a dictionary with {success, stats={id, docker_id, status, 
    cpu, mem_used, mem_limit, mem_perc}}
```

#### Get container logs

Accepting a user\_id and a docker\_id, returns its last 50 lines of log.

```
/get-container-logs/<int:user_id>/<docker_id>/

user_id: ID of the user on the platform.
docker_id: ID of the Docker container that the info is requested

    GET: Returns a dictionary with {success, logs}
```

#### Start container

Accepting a given user\_id, docker\_id, starts the corresponding container.

```
/start-container/<int:user_id>/<docker_id>/

user_id: ID of the user on the platform.
docker_id: ID of the Docker container that'll be started

    GET: Returns a dictionary with {success, ip, docker_id}
```

#### Stop container

Accepting a given user\_id, docker\_id, stops the corresponding container.

```
/stop-container/<int:user_id>/<docker_id>/

user_id: ID of the user on the platform.
docker_id: ID of the Docker container that'll be stoped

    GET: Returns a successful HTTP response
```

#### Restart container

Accepting a given user\_id, docker\_id, restarts the corresponding container.

```
/restart-container/<int:user_id>/<docker_id>/

user_id: ID of the user on the platform.
docker_id: ID of the Docker container that'll be restarted

    GET: Returns a dictionary with {success, ip, docker_id}
```


## SDN Controller

It'll be at DETI MakerLab that the users will connect to their projects'
networks, where there are several RJ-45 sockets and a OpenFlow enabled Switch to
control all the traffic inside the room and forward it to the datacenter.

To connect all the hosts at DML, a OpenFlow enabled Switch must exist but,
in order to work as intended, a SDN controller is also needed.

This controller will be responsible for:
*   Analyzing and redirecting packets that the Switch are not familiar with and
to tell it where to forward them;
*   Installing OpenFlow rules in the Switch, so that the packets with a similar
destination would be automatically redirected without the need of sending them
to the controller.

Although the SDN controller initially provided an HTTP REST server, it's
deprecated an not used at the moment, but in the future it might be useful.

<!-- -->
{:center: style="text-align: center"}
