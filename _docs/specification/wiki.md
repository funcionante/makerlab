---
layout: default
category: Specifications
order: 5
---

Wiki is all about the knowledge off the system. And the domain of our system are equipments, projects, members, requisitions. All of this is kept in the wiki. But the domain could be other. The point of our system is to manage all the information in a dynamic way, regardless of the content. This is possible due to the flexibility and collaborative capabilities provided by our wiki engine. That's what happens with Python wiki, Ubuntu wiki, and, of course, Wikipedia.


# Roles
Wiki aims to be available to all the users of the system, providing this integration at five main levels:
* Administrator
* Manager
* Mentor/Teacher
* User/Student
* Visitor

These levels are cumulative, witch means the higher ones have the capabilities of the lower ones. The Administrator is the higher level.

## Visitor
The visitors are all the users that access the wiki unauthenticated. They can see the content of equipments and projects, as long as they access the website inside the university network or via VPN.

## Student
The student can edit information of the wiki pages, participating in the collaborative ... He can also be part of projects. Finally, he can do requisitions of equipments, in the context of one project he belongs to. A Student as full access to its account as long as he has its UA credentials.

## Mentor/Teacher
A teacher is the mentor of the projects running inside MakerLab. A project can only be created by a teacher. After that, he can add students to it, making possible to them to be part of one. This is a crucial role in the MakerLab environment. MakerLab wants to give a fast, easy and resourceful environment, but has to have a way of tracking what is going on. The teacher/mentor is the entity that aproves the projects that deserve to be played in the room.

## Manager
The manager is the person that supervise the room. He is responsible to look after the material and help to keep the room an enjoyable space. He can mage all the equipment in the wiki, creating new pages for equipments. He can also manage add units of equipments. The requisitions are tracked by him and he can also manually edit requisitions, if he needs to. Because the teacher is a special role, after authenticating himself via UA, he needs to have the permissions granted by the manager.

## Administrator
The administration level is the primordial level. All the features are available to him. He can elect all the roles in the system, and automatically or manually edit any information.


# Authentication
Users can authenticate themselves in a transparent way, that being possible 
using OAuth protocol . It's workflow is centralized in wiki side, so all the
clients will need to pass this layer in order to login. 
All the user needs to do is to have the University of Aveiro credentials.
This means there is no need for registration, making the accounting something
much more simple and fast. 
The system will have access to user's informations, with his consensus, in order
to populate it's profile page. Further permissions are granted by the manager.

# Management
The management one of the main tools of the wiki. This chapter intends to develop the manager features.

## equipments
equipments, units, qrcodes, blank fields,...
[print]

## requisitions
manually edit, track pending requisitions,
[print]

## other stats
?

## Requisition Process
Teacher elected by the manager becomes the mentor of a project and creates a page
Invites one or more students
The students can do requisitions (outside wiki) associated to projects
The manager can control the flow, manually editing requisitions if it is needed to.
