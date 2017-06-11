---
layout: default
category: Specifications
order: 100
---

Solr's engine provides an interface to solr queries, hiding the otherwise
necessary direct calls. Its code is contained within the `solr-engine` repo.

## Container and settings

Solr itself is contained within a docker container.

The directory `solr-conf` within the root of the repo contains Solr's settings
and schemas (currently only one, for Portuguese language).

The file `docker-composer.yml` contains the docker specs for the node to
create, which by default uses `/var/makerlab/solr/` to store the information.

The script `setup.sh` handles the container's deployment.

## Server

The file `solr.py` contains a flask app which provides a set of endpoints to
facilitate communication with Solr. These are described below.

In all endpoints, json is returned. A return code of 400 is returned in case of
failure, otherwise 200 is returned (unless something unexpected happens).


### Get equipments, projects, profiles

```
/api/<string:lang>/<string:_type>/all/

lang: language to use
_type: one of - equipment, profile, project

    GET: Returns the list of _type
```

### Index article

```
/api/<string:lang>/update/

lang: language to use
body.json: article to index

    POST: Feeds body.json to Solr
```

### Remove article

```
/api/<string:lang>/<string:id>/

lang: language to use
id: identifier of the article to remove

    DELETE: Deletes the article with id (argument received)
```

### Projects of a user

```
/api/<string:lang>/user/<string:user_id>/projects/

lang: language to use
user_id: user identifier

    GET: Returns the list of projects of a user
```

### Requisitions

```
/api/<string:lang>/requisitions/
/api/<string:lang>/active_requisitions/

lang: language to use

    GET: Returns the list of (active) requisitions
```

### Requisitions of a user

```
/api/<string:lang>/user/<string:user_id>/requisitions/
/api/<string:lang>/user/<string:user_id>/active_requisitions/

lang: language to use
user_id: user identifier

    GET: Returns the list of (active) requisitions of a user
```

### Requisitions associated with a project

```
/api/<string:lang>/project/<string:proj_id>/requisitions/
/api/<string:lang>/project/<string:proj_id>/active_requisitions/

lang: language to use
proj_id: project identifier

    GET: Returns the list of (active) requisitions associated with a project
```
