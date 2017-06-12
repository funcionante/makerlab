---
layout: default
category: Developer
order: 7
---


### Servant's rules

```
the rules
    returns the rules dml-servant follows
```

![the-rules](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fthe-rules.png?alt=media&token=c7bfd5d4-bdc6-4831-80de-5571f36df397)

### Debug

```
echo <text>
    reply back with <text>
```

![echo](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fecho.png?alt=media&token=4616a041-346b-4ac5-a4e3-0d897c71dc7a)

```
ping
    reply with pong
```

![ping](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fping.png?alt=media&token=8a0aff86-9b4d-4b14-bf87-0ad46ea13ff3)

### Help

```
dml-servant help
    displays all of the help commands that Hubot knows about
```

![help](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fhelp.png?alt=media&token=7d057d40-be12-4655-b7e9-6023aed68a31)

```
dml-servant help <query>
    displays all help commands that match <query>
```

![help-query](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fhelp-query.png?alt=media&token=597dffba-7a9a-47f5-8e18-e2228e741adc)

### Projects

```
dml-servant projects ls
    returns the list of projects the logged user belongs to
```

### Network

```
dml-servant network add port <proj-id> <port-id>
    associate port `port-id` with the VLAN of the project `proj-id`
```

```
dml-servant network create <proj-id> <dockerfile-url>
    create a VM, associated to the user's project `proj-id`, according to the
    specs in `dockerfile-url` (the url of the docker file)
```

```
dml-servant network log <cont-id>
    show the log of the container with id `cont-id`
```

```
dml-servant network ls <proj-id>
    list the containers (along some extra info) associated with `proj-id`
```

```
dml-servant network restart <cont-id>
    restart the container with id `cont-id`
```

```
dml-servant network rm <cont-id>
    remove the container with id `cont-id`
```

```
dml-servant network rm port <port-id>
    disassociate port `port-id` from the VLAN it is connected to
```

```
dml-servant network start <cont-id>
    start the container with id `cont-id`
```

```
dml-servant network stat <cont-id>
    show the status of the container with id `cont-id`
```

```
dml-servant network stop <cont-id>
    stop the container with id `cont-id`
```
