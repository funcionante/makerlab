---
layout: default
category: Specifications
order: 9
---

DML's wiki is all about the knowledge of the system. Its domain includes
equipments, projects, members and requisitions, although others could be added
to the list. The point of the system is to manage all the information in a
dynamic, unbounded way, regardless of the content. This is possible due to the
flexibility and collaborative capabilities provided by our wiki engine. This
follows with other wikis, such as Python's, Ubuntu's, and of course,
Wikipedia's.

## Roles

The wiki divides its users into 5 different levels:
* Administrator
* Manager
* Mentor/Teacher
* User/Student
* Visitor

These levels are cumulative, witch means the higher ones have the capabilities
of the lower ones. The Administrator is the highest level.

### Visitor

The visitors are all the users that access the wiki unauthenticated. They can
see the content of equipments and projects, as long as they access the website
inside the university network or via VPN.

### User/Student

The student can edit information of most wiki pages, participating in the
collaborative loop of information share. He can also be member of a (set of)
project(s). Finally, he can do requisitions of equipments, in the context of one
of the projects he belongs to. A student has full access to its account
information as long as he has its UA credentials.

### Mentor/Teacher

A teacher is the mentor of a project running inside MakerLab. Projects can be
created by a teacher. After that, he can add students to it (who can also add
other students), making them part of the project. This is MakerLab's way of
assigning responsibility of the scientific value of a given project, in this
case to its mentor.

### Manager

The manager is the person that supervises the room. He is responsible to look
after the material and help to keep the room an enjoyable space. He can manage
all the equipment in the wiki, creating/editing new pages for equipments, adding
new units to them (the physical manifestation of a given item), and maintaining
projects' pages if the need rises.

Requisitions are tracked by the manager, who is also capable of manually editing
them.

Being the mentor a special role, after authenticating himself via UA he needs to
have this permission granted by the manager.

### Administrator

The administration level is the highest level of the system. All the features
are available to users with this role.

## Authentication

Users can authenticate themselves with the system in a transparent way by using
OAuth1, provided by UA. Completing its workflow is a requirement in order to
login to the platform (which assumes the existence of UA credentials) --- this
means there is no need for an actual registration.

## Management

The management is one of the main tools of the wiki. This section intends to
develop the manager features.

### Equipments

Equipments are registered in the wiki, which provides a template page with the
last used fields (although the manager can edit the entire page to his needs).
This avoids the existence of blank fields in a typical information system. For
instance, links to images or datasheets can be added to each equipment on
demanded, that is, withouth assuming that all items should contain this time
of information associated.

For each equipment, several units can be added, each with a unique ID that is
used to generate the QR Code present in the unit's label.

![Raspberry Pi 3 Wiki](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/wiki%2Fwiki_01.png?alt=media&token=39cc8a73-d720-4263-81a9-dee60ea0067f)

### Requisitions

The requisition of units happens through mobile apps. Despite this, the
manager can track the complete requisition process, tracking pending
requisitions, and being able to contact the students via email. He can also
manually edit requisitions, with a simple edit to the wiki's page of the given
unit.

![Raspberry Pi 3 Requisitions](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/wiki%2Fwiki_05.png?alt=media&token=528f0b94-badb-42e2-b3d0-477d939f6150)

### Requisition process

The way the requisitions' workflow processes is of extreme importance. We want
to be sure that:
* Equipments are safe and well maintained --- no damage, loss or thefts. If
  this happens someone needs to be responsibilized;
* Equipments are used in deserving projects.

The diagram below illustrates the procedure to do requisitions (inside the
dashed box) as an easy and fast step, wrapped in a bigger process (the whole
diagram).

![Requisition process](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/Requisition%20Process.png?alt=media&token=1dee8917-a1d9-4a6b-a349-071012d11a2f)

Following all these steps we can trust in the paradigm of a system where
everybody can enjoy learning and making, with the less bureaucracies possible,
yet where when things go wrong the responsible doesn't get away.
