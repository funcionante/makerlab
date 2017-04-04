---
layout: default
category: Team
order: 7
---

After some headaches we have finally came up with a proper architecture for
structuring our data.  
We developed a parser which solves the flexibility requirements imposed by one
of our clients, which demanded general "management" information to be directly
editable as if it was any other kind of content of an article. Here goes how
it looks like:
![Week 7, Photo 1](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/Wk07-01.png?alt=media&token=7769041f-8c75-46c7-8bb5-c4b2741c66a5)

This step was necessary since now the mobile apps will start to actually
communicate with the API, and they definitely don't want to face all the
complexity (imposed by the system's flexibility, one of its requirements) of
our data structure. We have added a new page on the issue [here](../../developer/developer-area/).

On other news, we are still waiting to have items added onto the wiki. We will
have to ask prof. Diogo Gomes to pressure Sr. Arez so that we can have
actual items to test with.

Hopefully, though, the STIC have finally delivered us our server (although
with an odd name). During the next few days we will start migrations, although
we expect things to go smoothly (it now feels good to be using Docker, since
most things are automatic).
