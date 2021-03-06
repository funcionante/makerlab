---
layout: default
category: User
order: 3
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

![projects-ls](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fprojects-ls.png?alt=media&token=ef6ba01c-3c57-489a-a084-7dbfca4ad9d8)

### Network

```
dml-servant network add port <proj-id> <port-id>
```
If you need to have your own private network (free from UA's constraints!).

![network-add-port](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fnetwork-add-port.png?alt=media&token=8858ec91-69c5-499f-826b-96983133c29f)

```
dml-servant network create <proj-id> <dockerfile-url>
```
Or a VM, `dml-servant` comes to the rescue.

![network-create](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fnetwork-create.png?alt=media&token=39b14f86-d4dc-4381-981a-dfd109fb8503)

```
dml-servant network log <cont-id>
```
It can also show you a VM's log, in case you need it.

![network-log](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fnetwork-log.png?alt=media&token=eea4342e-ee97-426f-b252-a93a0aa64e1d)

```
dml-servant network ls <proj-id>
```
Or list the VM's bound to a project!

![network-ls](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fnetwork-ls.png?alt=media&token=a674a2b0-2eaf-48d3-9a53-6c1419b6c7fd)

```
dml-servant network restart <cont-id>
```
Restarting a VM is a easy as 1, 2, 3, dml-servant network restart container id.

![network-restart](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fnetwork-restart.png?alt=media&token=7552370b-5a5a-498f-aab2-288e23d2038d)

```
dml-servant network rm <cont-id>
```
Removing is a classic, no explanation needed. Proceed with care though.

![network-rm](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fnetwork-rm.png?alt=media&token=374ba24a-9f20-4899-8dea-b0f248fa6517)

```
dml-servant network rm port <port-id>
```
When you no longer need to have your own private network.

![network-rm-port](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fnetwork-rm-port.png?alt=media&token=33b1a500-3080-4e78-808c-f4bcbc142480)

```
dml-servant network start <cont-id>
```
Every `Stop <X>` needs a `Start <X>`.

![network-start](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fnetwork-start.png?alt=media&token=074400d1-4bf3-4dd2-8390-1837c0989a7d)

```
dml-servant network stat <cont-id>
```
Looking for statistics about a VM? Well... Look no more.

![network-stat](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fnetwork-stat.png?alt=media&token=7066afef-cb00-4b66-abd2-7edf35ecb6a3)

```
dml-servant network stop <cont-id>
```
Every `Start <X>` needs a `Stop <X>`.

![network-stop](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/servant%2Fnetwork-stop.png?alt=media&token=8beabf48-847b-4127-a40c-f4c9f0a85fb3)
