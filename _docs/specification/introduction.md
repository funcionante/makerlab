---
layout: default
category: Specifications
order: 1
---

![MakerLab 3D Logo](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/IMG_20170614_195527.jpg?alt=media&token=555809ac-e4e4-4cc2-985e-074ba8724e11)

## Requirements

The following requirements state the functions and capabilities that the DML
system will provide, although some requirements may be stated on other pages:
* Integration with University of Aveiro’s services (UU) --- for easier access
  and information retrieval;
* Wiki-based platform --- imposed by stakeholders --- search for information in
the system and manage equipments and their requisitions, projects and users;
* Android and iOS apps --- manage projects and request equipments using their QR
codes to make the requisition process agile;
* Self-managed network --- able to satisfy the users’ requests to VM’s and
  VLANs autonomously, in order to overcome UA's network constraints;
* Components must be independent --- the failure of a plugin component must
not affect neither the core nor other plugins;
* History of equipment usage (owner and associated project) --- keep a log of
  users who might have broken it;
* Ability to automatically test the reachability of a set of endpoints;
* Interface to manage the room's network;
* Statistics about the room's usage (count people);
* The system must provide APIs for easy expansion --- this is a multi-year
project.

## Scenarios

These were left out of this page in order to keep it concise. They can be
found [here](/specification/scenarios/).

## Features

DETI MakerLab (DML) platform addresses the following features:

* Create, edit and delete projects;
* Register and edit equipment’s info and their quantity;
* Invite and remove collaborators to projects;
* Generation of QR codes for unlabeled units;
* Search users/projects/equipments;
* Document users/projects/equipments with text, images and file attachments;
* Version controlled documentation;
* Let teachers approve projects;
* Request and return/release electronic equipment in the context of approved projects;
* Scanning QR codes of equipments using the mobile app in order to do requests;
* Notify requisitions by email;
* Request and release VLANs and create or destroy VMs through the DETI MakerLab Servant.

## Architecture

Here is a simple illustration of how DETI MakerLab looks like:

![DML Architecture](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/dml-architecture.svg?alt=media&token=49f78fb4-81a8-408b-a82d-cc4fec9876a1)
{:center}

Although not an extensive diagram, hopefully it will empower the reader with a
top-level understanding of the DML's internals.

### Components

The components illustrated above are documented within each one's page. Yet,
a succinct description of each component will be provided for completeness'
sake.

#### API provider

This is the component responsible for programmatically interfacing with the
outside world --- with apps or the lab's servant, for example.

#### Wiki Engine

Responsible for handling the wiki-like internal structure, managing revisions,
and validating (authentication-wise) the access to wiki pages.

For more information see [here](/specification/wiki/).

#### App

The app provides for a more user-centered experience within the lab and have 
all necessary tools to start using it's features as fast as possible.

For more information see [here](/specification/mobile-app/).

#### Index Manager

Answers performance concerns that could rise due to our data organization
model (which in turn is based on requirements such as the use of a wiki-based
system). Facades the interaction with an indexer, abstracting the build of
queries that would otherwise require extensive knowledge about the indexer's
internals.

For more information see [here](/specification/indexer/).

#### Wiki Parser

The component responsible for processing the (unstructured) structure of the
wiki into a more well-defined form.

It handles the different stages of organization discussed in
[data-structure](/developer/data-structure/).

#### Network Manager

Answers to the network matters of the lab. Abstracts the issuing of
VLANs and the creation/removal of VMs.

For more information see [here](/specification/network-manager/).

#### Plugins

Should be as decoupled as possible from the rest of the system.

They should be hot-swappable, without affecting the overall, basic
functionality of the system. They should be the main way of expanding the
platform to new possibilities of interactions/services.

An example of a plugin is [Makerlab's servant](/specification/servant/).

<!-- -->
{:center: style="text-align: center"}
