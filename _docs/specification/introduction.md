---
layout: default
category: Specifications
order: 2
---

## Features

DETI MakerLab (DML) platform will address the following features:

* University of Aveiro’s UU authentication (implicit account creation);
* Create, edit, close and delete projects;
* Add/register and edit equipment’s info and their units;
* Invite and remove collaborators to projects;
* Generation of QR codes for unlabeled units (and RJ-45 sockets);
* Search users/projects/equipments;
* Request and return/release electronic equipment;
* Scanning QR codes of equipments using the mobile app;
* Request or deliver VLANs and create or destroy VMs through the DETI MakerLab Servant;
* Web monitoring of equipments, VM’s and VLANs;
* Request new equipment (not existent in DML).

## Scenarios

These were left out of this page in order to keep it consice. They can be
found [here](/specification/scenarios/).

## Requirements

The following requirements state the functions and capabilities that the DML
system will provide, although some requirements may be stated on other pages:
* Integration with University of Aveiro’s services (UU) --- for easier access
  and information retrieval;
* Wiki-based platform --- allowing more flexibility to content storing;
* Web platform --- information query and simple tasks (creating projects,
  inviting collaborators, etc.);
* Android and iOS apps --- full functionality (e.g. requisitioning items) plus
  scanning QR codes for requests;
* Self-managed network --- able to satisfy the users’ requests to VM’s and
  VLANs autonomously, in order to overcome UA's network constraints;
* Highly modularized and loosely coupled --- components must be easily swapped
  in or out;
* Reuse existing projects and frameworks --- keep project maintenance to a
  minimum;
* History of equipment usage  (owner and associated project) --- keep a log of
  users who might have broken it + statistics;
* Overview of statistics --- providing insights for example about equipment's
  use and topics of projects;
* The system should be autonomous --- human interaction (and worries with the
  system) to the minimum;
* The system must be fun and effortless for the average user --- implicit
  value;
* The system must be ready to be expanded and scalable in the future --- this
  is a multi-year project, must be easily expanded.

## Architecture

Here is a simple illustration of how DETI MakerLab will look like once
completed:

![DML Architecture](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/dml-architecture.svg?alt=media&token=49f78fb4-81a8-408b-a82d-cc4fec9876a1)
{:center}

Although not an extensive diagram, hopefully it will empower the reader with a
more top-level understanding of the DML's internals.

### Components

The components illustrated above are documented within each one's page. Yet,
a succinct description of each component will be provided for completeness'
sake.

#### API

This is the component responsible for programmatically interfacing with the
outside world --- with apps or the lab's servant, for example.

#### Wiki Engine

Responsible for handling the wiki-like internal structure, managing revisions,
and validating (authentication-wise) the access to wiki pages.

For more information see [here](/specification/wiki/).

#### Index Manager

Answers performance concerns that could rise due to our data organizational
mode (which in turn is based on requirements such as the use of a wiki-based
system). Facades the interaction with an indexer, abstracting the build of
queries that would otherwise require extensive knowledge about the indexer's
internals.

For more information see [here](/specification/indexer/).

#### Network Manager

Gives answer to the network matters of the lab. Abstracts the issuing of
VLANs, the creation/removal of VMs, and NAT/PAT mechanisms.

For more information see [here](/specification/network-manager/).

#### Plugins

Should be as decoupled as possible from the rest of the system.

They should be hot-swappable, without affecting the overall, basic
functionality of the system. They should be the main way of expanding the
platform to new possibilities of interactions/services.

An example of a plugin is [Makerlab's servant](/specification/servant/).

<!-- -->
{:center: style="text-align: center"}
