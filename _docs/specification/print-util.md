---
layout: default
---

In order to identify items/services within Makerlab's context we use ids.
These are printed as a QR code that is then placed on each item it refers to,
making possible the automation and process simplification mentioned in other
components (see [wiki](/specification/wiki/) or
[mobile-app](/specification/mobile-app/)).

This implies the existence of labels, and although for the platform itself the
simple QR code would suffice, we had to cope with requirements imposed by
Makerlab's technical manager and support labels with different designs and
with much more content than the simple code.

Some of the limitations/requirements we had to address include:
* The printer in the room (a special purpose printer to print labels) doesn't
  have network connection;
* The computer the printer connects to runs Windows;
* The technical manager already had template labels prepared;
* The labels the technical manager wanted to print do not follow a static
  structure (i.e. some include a set of fields, others include different
  fields).

## The solution

In order to simplify the issuing of each item's label, and taking into
consideration the arguments made above, we developed a simple application that
takes a template label and manipulates the ZPL code (code resembling assembly
that the printer understands) so that each label generated actually includes
the correct QR code. Then, it sends these labels for printing.

A screenshot of the application follows:
![Print util](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/Print-util.png?alt=media&token=659e1bfb-b925-4347-81e4-a5ccddf91f94)

We kept its looks simple and minimalistic since this is not considered a
killing feature nor something that will be frequently used. The technical
manager said himself he will be using this around once per new batch of items
he receives, thus he doesn't need something really eye-catching.

![Print util label](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/Print-util-label.png?alt=media&token=fc87207f-b12f-4a94-a957-7e95faa9edbe)
