---
layout: default
category: Specifications
order: 20
---

Given that most tasks carried by DML require little to no human interaction, a
unified way of outputting/communicating information to the outside world is
required.

`dml-servant` is the entity responsible for this, built in an independent and
decoupled manner --- also illustrating our plugin architecture.

Its top level features include:
* Provisioning diagnostic tools;
* Providing a cli-like interface with which users can interact with;
* Monitoring services, e.g. giving information about the state of things;

The first bullet is aimed more at the development team, while the last two
targets most users.

In essence, `dml-servant` tries to bring to Makerlab the chatops-like bot it
needed in order to interact with the outside world and inform its masters if
it finds any problems. Better, only if it solved the problems itself (future
work).

![DML-Servant](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/DML-Servant.png?alt=media&token=610bac92-12b6-4224-a673-1db53ddc6d06)

It is accessible through DETI's [Slack](https://detiuaveiro.slack.com/messages/@dml-servant/).

## Diagnostic services

These services give the development team a simpler interface in order to track
down and isolate problems, leveraging the knowledge required to successfully
do this (e.g. the team doesn't need to know about the location of all the
services that are running in order to test them).

Tasks so far scheduled for development include:
* Test reachability of set of endpoints (partially complete);

## Monitoring services

Run tasks regularly and inform users (the team or otherwise) of their result,
for example.

Functions scheduled for development include:
* Monitor a set of endpoints, informing if they fail/become inaccessible
  (partially complete);
* Inform a user when a given item he/she has marked becomes available;
* Inform users that have subscribed to a given channel of new equipment
  available;
* Blame (eventually publicly) users that have failed to return a product in
  time;

## CLI interface

Interface through which users/the team can interact with the servant. These
include endpoints to make available the functionality described in the
services above, as well as an interface to manage the state of virtual
machines within the datacenter (although this is still open for discussion).

Once the documentation of the endpoints being developed is complete, which
will be available through the servant's `help` command (see the image above),
this section will see further extension with such information.
