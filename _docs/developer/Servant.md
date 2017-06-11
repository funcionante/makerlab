---
layout: default
category: Developers
order: 20
---


### servant's rules

```
the rules
    returns the rules dml-servant follows
```

![the-rules](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fthe-rules.png?alt=media&token=c7bfd5d4-bdc6-4831-80de-5571f36df397)

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
