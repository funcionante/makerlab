---
layout: default
---

Requirements such as the use of a wiki-based platform and high flexibility
demands made us adopt the data organization discussed
[here](/data-structure/).

This page we will deal with the component that implements what was discussed
in the previously mentioned link.

## On the component

As the name suggests, the `wiki-parser` in not a component per se, but more a
sub component associated to the wiki. It enables the wiki to have access to a
uniform data model, abstracting the steps needed in order to attain the model
itself (for example parsing the markdown of a wiki's article).

Given the nature of the component, a test suite was developed to assert that
new additions to it don't break compatibility to what had already been
implemented.

For brevity these have been left out of this document, though they can be
found what the [component's
repository](https://gitlab.com/makerlab/wiki-parser) (access is granted if
requested), where they integrate the deployment pipeline.
