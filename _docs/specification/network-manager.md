The network manager is in charge of all things network. It's main goal is to
provide a private network to each project, with internet connectivity,
as well as the possibility of launching Docker containers for testing
and deployment. All the traffic is completely isolated from each network
and the users can access their projects' networks and containers by associating
RJ-45 sockets at DML's room to them.

A simplified vision of our network architecture would be:

![Network Architecture](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/network%2FNetwork%20Diagram.png?alt=media&token=8cb4994b-84d3-485f-b763-1ae706160b9d)


The "core" of each project's network will be hosted on a datacenter, where
the containers will be orchestrated and the NAT/PAT mechanisms will provide
internet access to all the hosts across the private networks.

In order to fulfill time milestones, it was decided that this 
implementation of the container orchestration will be focused on a single-host
datacenter architecture, **rather than** a swarm-like implementation.

The datacenter will also be running the SDN Controller responsible for 
controlling the switch's traffic at the DETI MakerLab room.

## NetManager

The datacenter will host a controller that will manage all the networking
information.
Its main functionalities are:
*   Creation and destruction of a project's network;
*   Creation and destruction of containers;
*   Change of state (start and stop) of containers;
*   Association of RJ-45 sockets (based on a printed ID on them) to projects'
networks;
*   Informational endpoints to the platform's API, mainly to the `dml-servant`.

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


<!-- -->
{:center: style="text-align: center"}
