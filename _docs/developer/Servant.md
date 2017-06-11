---
layout: default
category: Developers
order: 20
---


### servant's rules

```
the rules
    returns the rules dml-servant follows

>>> dml-servant the rules
. A robot may not harm humanity, or, by inaction, allow humanity to come to harm.
1. A robot may not injure a human being or, through inaction, allow a human being to come to harm.
2. A robot must obey any orders given to it by human beings, except where such orders would conflict with the First Law.
3. A robot must protect its own existence as long as such protection does not conflict with the First or Second Law.
```

### Debug

```
echo <text>
    reply back with <text>

>>> dml-servant echo As armas e os barões assinalados, Que da ocidental praia Lusitana, Por mares nunca de antes navegados, Passaram ainda além da Taprobana (...)
As armas e os barões assinalados, Que da ocidental praia Lusitana, Por mares nunca de antes navegados, Passaram ainda além da Taprobana (...)
-------------------------------------------------------------------------------
ping
    reply with pong

>>> dml-servant ping
PONG
```

```
dml-servant help - Displays all of the help commands that Hubot knows about.
```
```
dml-servant help <query> - Displays all help commands that match <query>.
```

```
dml-servant network add port <proj-id> <port-id>
```
```
dml-servant network create <proj-id> <dockerfile-url>
```
```
dml-servant network log <cont-id>
```
```
dml-servant network ls <proj-id>
```
```
dml-servant network restart <cont-id>
```
```
dml-servant network rm <cont-id>
```
```
dml-servant network rm port <port-id>
```
```
dml-servant network start <cont-id>
```
```
dml-servant network stat <cont-id>
```
```
dml-servant network stop <cont-id>
```
```
dml-servant projects ls
```
