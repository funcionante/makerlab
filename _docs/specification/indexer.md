---
layout: default
---

Since most of the knowledge of the system is kept within our wiki, in a
mostly unstructured manner, our architecture was drawn taking into
consideration that we needed a way to sanitize its storage and its accessing.
The first topic is covered [here](/developer/data-structure/), where we discus
decisions about the data organization we adopted. This page continues this
documentation effort by targeting the data access with an indexer.

By including in our architecture ways of handling data from different layers,
we have supported requirements such as: high flexibility, wiki based approach.

Yet, this alone hinders the performance of the platform since the only way of
finding a piece of information not within the database/structured layer is by
iterating through the many existing articles, interpreting and evaluating
them. The situation worsens as one realises that at times we also need to
evaluate not only the current articles, but also each article's past
revisions.

We address this issue by including a block (the indexer) that captiously
indexes our interpretation of each article, as they are updated.

We can then query the indexer for features of our interest, and it will search
its index for them. This solves our performance worries since by design the
indexer is implemented with optimizations and efficiency in mind.

Although not meant to be an extensive list, a few queries that are/will be
supported include:
* Active requisitions, filtered by date range, project, etc;
* Projects a user belongs to (and vice-versa);
* Users that were with the item between a range of dates;
* Other queries necessary for the wiki's operation;
