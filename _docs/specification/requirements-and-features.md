---
layout: default
category: Specifications
order: 2
---

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

## Features

DETI MakerLab (DML) platform includes the following features:

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
