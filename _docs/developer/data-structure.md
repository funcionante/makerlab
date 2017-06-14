---
layout: default
category: Developer
order: 3
---

## On the data structure

Given the flexibility that MakerLab aims for, the data structure it uses
internally (that is, inside the API domain) is not trivial.  
We have divided the (meta)data an article comprises over 3 disjoint layers,
plus an extra presentation layer.

![Data Layer Image](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/Data%20Layers.svg?alt=media&token=5c0565ea-b8b3-4578-afbd-8d24b76747fc)
{:center}

#### Structured Layer

The information belonging to this layer is persisted in the system database.
It deals mainly with permission issues and with otherwise data that already
was part of the [django-wiki](https://github.com/django-wiki/django-wiki)
which served as the starting point of our own wiki.  
Every information in here is highly structured and is hardly modified in any
direct way which we don't control and/or verify that is correct and valid.

#### Semi-structured Layer

This layer deals with information that is not strictly structured, yet we can
ensure its correction and validity, and serves as the first layer where we
modify and keep information of our own (versus the information already used by
_django-wiki_).  
We keep this information stored in XML. This means that an article in our
system is no longer solely its contents. It now is its metadata as added by
us, plus its contents (XML + Markdown).  
We call this layer semi-structured since we do not impose a static structure
in this layer. As need arises, new tags can be added and old ones removed. And
the system has to bare with this flexibility. Yet, we don't let general users
modify this structure, effectively making us (i.e. the system itself) the
only entity that uses this information. As a result we don't need to worry
about changes imposed by users and can be sure about the information we
access to.  

#### Parsed Layer

This is the most flexible layer on our system, and the one that effectively
poses most challenges when coping with our management-on-a-wiki system.  
All the content kept within this layer is actually stored directly in the
markdown of the articles. This means that any user (with proper credentials)
can edit and manipulate this information.  
At first sight this might seem undesirable, yet we find it to be the ultimate
flexibility mechanism. Following the principle "we are all grown-up here", we
think (and our clients do too) that sufficiently privileged users should have
direct access to information and be capable of changing it as they would
change any other piece of information.  
We thus, whenever reasonable, store information directly to the respective
article's markdown (its contents), making it directly editable.  
In order to cope with this, we have developed a parser which looks for pieces
of contents which resemble the loosely defined structure in which we would
have written information, and hopefully interprets it. We try to use simple
structures and be as flexible as possible in our grammar definition, so that
users still have freedom to manipulate the structures without braking the
overall contents.

#### Normalizer

Having all the above layers and information scattered across different storage
sources would make it difficult to access information specially out of the
domain the API defines with the outer world (e.g. it would be hard to have a
mobile app parsing markdown and interpreting it as valid data).  
With this in mind we have developed a component whose sole purpose is to
gather normalize all an article's information into a well defined structure
which can be easily used by and shared with all the other components,
specially those which are not (nor should they be) familiar with these layers
which we presented here.

<!-- -->
{:center: style="text-align: center"}
