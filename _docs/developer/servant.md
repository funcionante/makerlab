---
layout: default
category: Developer
order: 9
---

The commands the servant answers to are already discussed in the [user
area](../../user/Servant/).

## Introduction

The servant is a [hubot](https://hubot.github.com/) chatbot that uses the
[hubot-slack](https://www.npmjs.com/package/hubot-slack) adapter to interact
with [DETI's Slack](https://detiuaveiro.slack.com).

It runs in Node.js and accepts scripts in either coffeescript or javascript.

The repo which hosts the projects code is `dml-servant`.

To interact with slack, the bot needs a secret token generated at the
department's slack page.

Besides answering to the already mentioned commands, the bot is also capable of
periodically checking a set of endpoints and reporting their results (through
slack).

The logged user's email is used to request information from the wiki (which in
turn also uses the same email). This makes transparent (to the user) the
integration of both services.

## Details

The following details are given per directory or file of the repo.

### `assets/`

This directory includes relevant files for the bot's execution.

The most useful one is `endpoints.txt`, which includes a set of endpoints to
periodically try to reach.

### `lib/constants.js`

Defines constants used through the rest of the code.

The most relevant portion of it is included:
```
DML_NM_HOST: '192.168.1.128',
DML_NM_PORT: '22',
DML_NM_URL: 'http://127.0.0.1:5000',
DML_NM_USERNAME: 'dml-datacenter',

DML_DEV_API_HOST: '188.166.77.53',
DML_DEV_SSL_CERT: fs.readFileSync('assets/nginx-selfsigned_dev.crt', {encoding: 'utf-8'}),

DML_PING_CHANNEL: '#makerlab-reports',
DML_PING_ENDPOINTS: 'assets/endpoints.txt',
DML_PING_MIN_PATTERN: '*/30',  // every 30 minutes

DML_PRIVATE_KEY: fs.readFileSync('assets/id_rsa'),
DML_SSL_CERT: fs.readFileSync('assets/nginx-selfsigned.crt', {encoding: 'utf-8'})
```

* `DML_NM_*` constants relevant to the bot's interaction with the network manager.
* `DML_DEV_*` define constants used when referencing the development server.
* `DML_PING_*` constants used regarding the "test endpoints" function.
* `DML_PRIVATE_KEY` key used by the bot in ssh sessions.
* `DML_SSL_CERT` certificate the bot expects from the main server.

### `scripts/crontab.js`

Handles testing endpoints in a cron-like approach.

Non of its methods are callable from the outside world, since they only output
information.

### `scripts/projects.js`

Contains functions regarding projects.

Currently one chat listener is registered, which is used to display information
about the logged user's projects.

### `scripts/network.js`

The main script used by the bot.

All the `network` endpoints registered in the bot are written in this file.

#### Major warning

The way the servant authenticates with the network, for security reasons, is
through ssh. This means that the servant effectively ssh's into the machine
running the network's server in order to issue requests.

This is transparent to the developers by the use of
[http-ssh-agent](https://www.npmjs.com/package/http-ssh-agent), which enables
the creation of an agent used to proxy requests.

### `setup/`

A directory containing information/scripts on how to generate the initial
version of the bot.
