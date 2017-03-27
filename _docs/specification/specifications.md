---
layout: default
category: Specifications
order: 1
---

# Specification Area

## Features, system scenarios and processes

### Features

* University of Aveiro’s UU authentication (implicit creation).
* Create, edit, close and delete projects.
* Add/register and edit equipment’s info and their units.
* Invite and remove collaborators to projects.
* Generation of QR codes for unlabeled units (and RJ-45 sockets).
* Search users/projects/equipments.
* Request and return/release electronic equipment, VLANs and VMs for project
  development
* Scanning QR/barcodes of equipment, VLANs (scanning QR code on the socket)
  and VMs using the mobile app.
* Web monitoring of equipment stock and VM’s and VLANs usage.
* Request new equipment (not existent in DML).

### Scenarios

With the best possible representation of the DML purpose in mind, the
following scenarios should illustrate the interaction users should have with
the system:

#### Users

Alice and Bob decided to start a service to do animal inferring from photos.
They need to do image processing for this, and they are interested in finding
out whether a Raspberry Pi is capable of such task. With this in mind they
create a project on DETI MakerLab (DML) and explain their goals and purposes.
They then use Alice’s phone to request a Raspberry by scanning a barcode
existent in the device’s box. The team’s project is automatically updated, now
stating that a Raspberry was requested for the project and that it is
currently at Alice’s responsibility. Meanwhile, the Raspberry’s page is also
updated, indicating that one is being used in this project. Hopefully this
will be helpful to other entrepreneurs which might want to check how some
other project used this device.

Testing the platform with evermore colleagues, Alice and Bob need something
with more power than a Raspberry. They decide to carry on tests using a DML
VM. After opening the project’s page, Bob issues the creation of a VM. After a
few minutes an email is sent to him, providing the machine’s IP address and
credentials. Bob is liable for this VM.

They soon find out that to properly access plenty of network services they
need to be less restricted than what UA’s network allows. They want to take
advantage of another DML networking service, which allows them to create a
VLAN for the project, imposing less restrictions. Bob goes to scan with his
phone a QR code existent in an ethernet socket nearby. Since this is the first
time a team member does this, a new VLAN is assigned to the project and the
port is automatically configured. Afterwards,
Alice does the same thing with another port nearby. DML network engine
automatically configures the port to belong to the correct VLAN that was
previously created (implicitly) by Bob. Both Alice and Bob can now use the
services they wanted.

After porting their project from the RPi to the VM, the team no longer needs
their RPi. They thus hand it to Mr. Faythe, DML’s staff. He scans the barcode
existent in the device’s box with his own phone. The project is no longer in
possession of the RPi, which is reflected in the project’s page.

Carol, a friend of Alice, has become interested in the project after testing
it. She wants to help the team, which is happy to accept her especially since
she knows more about electronics than they do. To give Carol access to the DML
services the team is using, Alice goes to the project’s page and adds Carol to
the project, sending her an invitation. After receiving the notification,
Carol accepts it and is now member of the team.

Alice and Bob soon find that explaining Carol how to use the VM they have
access to is tiresome (recall that Carol is more electronic-centric). To help
further individuals which might have the same doubts, Bob decides to improve
the existing VM documentation. He thus goes to the VM explanation page and
revisions it, explaining how it overall works, how to ssh into the machine,
and how to carry a few other actions.  
Dave, an element of another group, is happy to have some of his doubts
(indirectly) enlightened by Bob.

Finally, with the help of Carol, the team gets production ready. They have
bought hosting from another company and terminate the VM they had created.
Without having any more resources allocated to them, the team also decide to
close the project, indicating that they are no longer using DML to develop it.

#### Staff

Mr. Faythe is the manager of the DML room. Being responsible for maintaining
the components inside the room, keeping everything working and available, he
is constantly adding new parts that arrive and updating information about
certain items. Recently, a batch of 10 new Intel Galileos arrived, and he
wants to add them to DML’s inventory so that students can request them and
learn how to use them.

With this in mind, Mr. Faythe goes to create a new product. After filling a
few generic options existent in the template provided (like the product’s
abstract, connectors, etc), he soon realises that he would like to specify a
few other characteristics, such as that there is an integrated RTC which
requires a 3V battery, a programmable EEPROM, and so on. He thus adds new
sections to the item’s page, resembling the structure he found on the
product’s datasheet.  
To provide further documentation, Mr. Faythe also adds a few links to other
datasheets with the goal of helping students which are interested in using the
Galileo.  
Happy with the result, Mr. Faythe creates the Galileo’s product page.

Now, he wants to make available the different units he received (the actual
items). He goes to the Galileo’s page and chooses to add new units of the
product, by selecting the number of units he wants to add and all the codes are
quickly generated so that Mr. Faythe can print them on a nearby printer.
Soon he has added all 10 new Galileos, and can make them available for students.

#### Administration

After a few weeks of the purchase of Galileos, DETI’s administration could get
hold of some funding for the DML. They need to decide how they will use this
money.  
They start by the "cheap" resources, the most used products in DML. They have
two candidates which stand out: Arduinos and Raspberries. Interested in
knowing whether their current stock is capable of fulfilling the demand, they
check the usage/availability of each. They find out that while there have
always been Arduinos in sufficient number, Raspberries have actually run out
at a given time. They decide to buy 10 more, hopefully mitigating their
scarceness.

With still some money available, they start looking at more expensive things:
DML’s networking services. They soon find out that VMs are highly requested,
with the Datacenter having difficulties in providing for all projects. The
problem is, the remaining money is not enough. With this in mind they approach
some of their partners, requesting more funding to improve DML’s Datacenter
and providing insights about the projects using this service. Interested in
this data, the partners agree to upgrade the Datacenter, buying 5 new
machines.

## Requirements and tests

### Requirements

The following requirements state the functions and capabilities that the DML
system will provide:

*   Integration with University of Aveiro’s services (UU)  
    For easier access and information retrieval.
*   Wiki-based platform  
    Allowing more flexibility to content storing.
*   Web platform  
    Information query and simple tasks (creating projects, inviting
    collaborators, etc.).
*   Android and iOS apps  
    Full functionality plus scanning QR codes for requests.
*   Self-managed network  
    Able to satisfy the users’ requests to VM’s and VLANs autonomously.
*   Highly modularized and loosely coupled  
    Components must be easily swapped in or out.
*   Reuse existing projects and frameworks  
    Keep project maintenance to a minimum.
*   History of equipment usage  (owner and associated project)  
    Keep a log of users who might have broken it + statistics.
*   Overview of statistics  
    Providing insights for example about equipment’s use and topics of
    projects.
*   The system should be autonomous  
    Human interaction (and worries with the system) to the minimum.
*   The system must be fun and effortless for the average user  
    Implicit value.
*   The system must be ready to be expanded and scalable in the future  
    This is a multi-year project, must be easily expanded.

## Architecture

Here is a simple illustration of how DETI MakerLab will look like once
completed:

![](../../images/specifications/dml-architecture.svg)
{:center}

Although not an extensive diagram, hopefully it will empower the reader with a
more general understanding of the DML's internals.

### Components

#### API Orchestrator

This component is responsible for providing both a reasonable interface to
the outer world (i.e. web platform or apps), and for orchestrating the
internal components of DML, abstracting operations which would otherwise
demand lower-level, more complex calls.

The documentation for the API is available at
[SwaggerHub](https://app.swaggerhub.com/api/rj-jesus/makerlab/0.0.2).

#### Wiki Engine

Responsible for handling the wiki-like internal structure, managing revisions,
and validating (authentication-wise) the editing done to wiki pages.

#### Index Manager

Provides a facade for interaction with the Solr indexer, abstracting
operations that would otherwise demand the knowledge of Solr's internals.

#### Network Manager

Manages all things network. Abstracts the issuing of VLANs, the
creation/removal of VMs, and NAT/PAT mechanisms.

<!--
#### Features / functionality
#### Interfaces / connections
### Deployment
-->

## Data model

Already included in the API specs above and the components documentation (once
made available).

{::comment}
The section below is for ALD definitions (if more are necessary).
{:/comment}
{:center: style="text-align: center"}
