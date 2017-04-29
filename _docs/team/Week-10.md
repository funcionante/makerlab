---
layout: default
category: Team
order: 10
---

This week was a lot about improving the project's documentation (feel free to
go on an check the [specifications](/specification/introduction/).

We also got a development server set up, so that we can use it to test
features before releasing them into production. With it we tested and have
already deployed:
* Communications over HTTPS;
* Having both our wiki engine and our Solr's instance running behind uwsgi and
  nginx;
* Got a few servant's features introduced (such as a ping-like command).
This is not meant to be an extensive list.
