---
layout: default
---

# What is MakerLab?

_(DETI) MakerLab_ is a system designed to manage a new room
[DETI](https://www.ua.pt/deti/) (the department to which we belong) recently
acquired. This room is filled with electronic components and devices, such as
Arduinos, Raspberries, 3D printers, a network closet and the like. The space
aims at being _the_ room to carry on projects inside DETI.

Being the Department of Electronics, Telecommunications, and Informatics, DETI
couldn't let the opportunity escape to instead of buying a closed-source,
casual management software, support the development of a solution which defies
the currently standard way of building such systems. This is when we enter in
scene.

Having been invited to produce the software that powers the room as our
bachelor's degree project, here are a few key points expressed by our mentor
which called to our attention:
*   Make the system highly **modularized** and **loosely coupled**.  
    Any component should be easily swaped (or removed).
*   **Don't reinvent the wheel**. Reuse existing projects.  
    Keep close to upstream, so that mantaining the project is painless.
*   Make the system **autonomous**.  
    _MakerLab_ shouldn't require a superviser, though one might (and will)
    exist.
*   Make the system **easy to use** and **fun**.  
    Management for the users, not for the manager.
*   Plan for the **future**.  
    Don't make restrictions to what the system will be capable of providing.

## Technical specs

At least one of the follownig system specs are required be met in order to
use DETI MakerLab:
*   Android 4.4+
*   Any recent browser (Firefox/Chrome/Safari/...)
*   iOS (??)

Despite this, some features are only available either in the mobile version
(e.g. requisitions) or the web version (e.g. most administrative dashboards).

## The Sketch of a Solution

Trying to solve to maximum the issues above (and others we left out of the
list), the following components are queued for development:
*   API dispatcher/orchestrator
*   Wiki engine
*   Semantic indexer
*   Network manager
*   Android app
*   iOS app
*   Web platform

Rational behind our decisions and more elaboration on these components is
provided on the specification pages.

## Technologies Used

_MakerLab_ uses many technologies. One of our main mottoes is to "don't
reinvent the wheel". Besides, by utilizing these projects not only are we
capable of contributing to them, but we also avoid the necessity to keep them
ourselves.

Projects that power us (and to which we thank):
*   django
*   django-wiki
*   python
*   solr

## The Team

### Puppets

![Image of Ricardo Jesus](https://avatars1.githubusercontent.com/u/11319180?v=3&s=460){:height="120px" width="120px"}
![Image of Diogo Ferreira](https://avatars2.githubusercontent.com/u/11805521?v=3&s=460){:height="120px" width="120px"}
![Image of Leonardo Oliveira](https://avatars0.githubusercontent.com/u/10348875?v=3&s=460){:height="120px" width="120px"}
![Image of Pedro Martins](https://avatars2.githubusercontent.com/u/10819202?v=3&s=460){:height="120px" width="120px"}
![Image of Duarte Henriques](https://avatars1.githubusercontent.com/u/14802516?v=3&s=460){:height="120px" width="120px"}
![Image of Jorge Silva](https://avatars1.githubusercontent.com/u/25957117?v=3&s=460){:height="120px" width="120px"}
{:center}

From left to right: Ricardo Jesus, Diogo Ferreira, Leonardo Oliveira, Pedro
Martins, Duarte Henriques and Jorge Silva.

### Puppeteer

![Image of Diogo Gomes](https://avatars1.githubusercontent.com/u/137684?v=3&s=460){:height="120px" width="120px"}
{:center}

Prof. Diogo Gomes
{:center}

## Other Pages

If you are interested in learning more about _MakerLab_, do read the following
pages:
*   [User area](pages/user/)
*   (New content!!) [Specification area](pages/specification/)
*   [Developer area](pages/developer/)

Further more, if you want to check our weekly progress, refer
[here](pages/team/).

{::comment}
The section below is for ALD definitions (if more are necessary).
{:/comment}
{:center: style="text-align: center"}
