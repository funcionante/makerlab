---
layout: default
category: Specifications
order: 4
---

## Architecture

Here is a simple illustration of how DETI MakerLab looks like:

![DML Architecture](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/Architecture.png?alt=media&token=4fe547e4-ce7c-4458-a2b1-dda5ee212d47)
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
