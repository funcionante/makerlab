---
layout: default
category: Users
order: 20
---

Here follows the language `dml-servant` has so far learned.

### Servant's rules

```
dml-servant the rules
```
In case you wonder about the rules `dml-servant` was programmed to obey to.

![the-rules](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fthe-rules.png?alt=media&token=c7bfd5d4-bdc6-4831-80de-5571f36df397)

### Debug

```
dml-servant echo <text>
```
If you doubt the servant's capacity to reply to you, please, give it a try.

![echo](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fecho.png?alt=media&token=4616a041-346b-4ac5-a4e3-0d897c71dc7a)

```
ping
```
Because ping-pong is a nice game. Oh, and it enables you to test whether the
servant is really listening to you or has gone rogue.

![ping](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fping.png?alt=media&token=8a0aff86-9b4d-4b14-bf87-0ad46ea13ff3)

### Help

```
dml-servant help
```
Because `dml-servant` is kind enough to help you learn its language.

![help](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fhelp.png?alt=media&token=7d057d40-be12-4655-b7e9-6023aed68a31)

### Projects

```
dml-servant projects ls
```
`dml-servant` is smart enough to tell you about your projects inside the famous
DETI MakerLab. No need to switch context!

### Network

```
dml-servant network add port <proj-id> <port-id>
```
If you need to have your own private network (free from UA's constraints!).

```
dml-servant network create <proj-id> <dockerfile-url>
```
Or a VM, `dml-servant` comes to the rescue.

```
dml-servant network log <cont-id>
```
It can also show you a VM's log, in case you need it.

```
dml-servant network ls <proj-id>
```
Or list the VM's bound to a project!

```
dml-servant network restart <cont-id>
```
Restarting a VM is a easy as 1, 2, 3, dml-servant network restart container id.

```
dml-servant network rm <cont-id>
```
Removing is a classic, no explanation needed. Proceed with care.

```
dml-servant network rm port <port-id>
```
When you no longer need to have your own private network.

```
dml-servant network start <cont-id>
```
Every `Stop <X>` needs a `Start <X>`.

```
dml-servant network stat <cont-id>
```
Looking for statistics about a VM? Well... Look no more.

```
dml-servant network stop <cont-id>
```
Every `Start <X>` needs a `Stop <X>`.
