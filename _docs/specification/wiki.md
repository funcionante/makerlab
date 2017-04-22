---
layout: default
category: Specifications
order: 10
---

DML's wiki is all about the knowledge off the system. Its domain include equipments, projects, members and requisitions, although others could be added to the list. The point of the system is to manage all the information in a dynamic, unbounded way, regardless of the content. This is possible due to the flexibility and collaborative capabilities provided by our wiki engine. This follows with other wikis, such as Python's, Ubuntu's, and of course, Wikipedia's.


## Roles

The wiki divides its users into 5 different levels:
* Administrator
* Manager
* Mentor/Teacher
* User/Student
* Visitor

These levels are cumulative, witch means the higher ones have the capabilities of the lower ones. The Administrator is the highest level.

### Visitor

The visitors are all the users that access the wiki unauthenticated. They can see the content of equipments and projects, as long as they access the website inside the university network or via VPN.

### User/Student

The student can edit information of most wiki pages, participating in the collaborative loop of information share. He can also be member of a (set of) project(s). Finally, he can do requisitions of equipments, in the context of one of the projects he belongs to. A student has full access to its account information as long as he has its UA credentials.

### Mentor/Teacher

A teacher is the mentor of a project running inside MakerLab. Projects can be created by a teacher. After that, he can add students to it (who can also add other students), making them part of the project. This is MakerLab's way of assigning responsibility of the scientific value of a given project, in this case to its mentor.

### Manager

The manager is the person that supervises the room. He is responsible to look after the material and help to keep the room an enjoyable space. He can manage all the equipment in the wiki, creating/editing new pages for equipments, adding new units to them (the physical manifestation of a given item), and maintaining projects' pages if the need rises.

Requisitions are tracked by the manager, who is also capable of manually edit them.

Being the mentor a special role, after authenticating himself via UA he needs to have this permission granted by the manager.

### Administrator

The administration level is the highest level of the system. All the features are available to users with this role. 

## Authentication

Users can authenticate themselves with the system in a transparent way by
using OAuth1, provided by UA. Completing its workflow is a requirement in
order to login to the platform (which assumes the existence of UA credentials)
--- this means there is no need for an actual registration.

## Management

The management is one of the main tools of the wiki. This chapter intends to develop the manager features.

### Equipments

Equipments, units, qrcodes, blank fields,...
[print]

### Requisitions

manually edit, track pending requisitions,
[print]

### Other stats

?

### Requisition process

Teacher elected by the manager becomes the mentor of a project and creates a page
Invites one or more students
The students can do requisitions (with an app) associating the items to the project
The manager can control the flow, manually editing requisitions if he needs to
