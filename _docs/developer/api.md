---
layout: default
category: Developer
order: 10
---

Wiki has an API that is available to be used for any developer that wishes to, but was originally designed to be used and integrated with our mobile app. With the evolution of the project it was also used by our chatbot and even by some particular features of the wiki. Above are the endpoints available and their usage.

### Articles

```
/api/articles

    GET: Returns the list of all the articles (all types)
    Permissions: Administrator
```

```
/api/articles/<int:article_id>

article_id: article id

    GET: Returns a article
    Permissions: Administrator
```

### Equipments

```
/api/equipments

    GET: Returns the list of all the equipments
    Permissions: Everyone
```

```
/api/equipments/<int:equipment_id>

equipment_id: equipment id

    GET: Returns an equipment
    Permissions: Everyone
```

```
/api/equipments/<int:equipment_id>/quantity/<int:quantity>

equipment_id: equipment id
quantity: quantity to add/subtract to the equipment's stock

    PUT: Adds quantity to the equipment
    DELETE: Subtracts quantity to the equipment
    Permissions: Manager
```

```
/api/equipments/<int:equipment_id>/project_id/<int:project_id>/user_id/<int:user_id>/timestamp/<timestamp:timestamp>/lost

equipment_id: equipment id
project_id: project id associated to the requisition
user_id: user id associated to the requisition
timestamp: momment when the requisition occured

    DELETE: Marks a pending unit (with an active requisition) as lost, subtracting it from the stock
    Permissions: Manager
```

### Projects

```
/api/projects

    GET: Returns the list of all the projects of the logged user
    Permissions: Everyone
```

```
/api/projects/<int:user_id>

user_id: user id

    GET: Returns the list of all the projects of the given user
    Permissions: Everyone
```

```
/api/projects/new

title: project's title
content: project's content

    GET: Creates a new project
    Permissions: User
```

```
/api/projects/<int:project_id>/mentor

project_id: project id

    GET: Assigns the logged user as mentor of the given project
    Permissions: Teacher
```

```
/api/projects/<int:project_id>/member/<int:user_id>

project_id: project id
user_id: user id

    PUT: Adds the given user to the given project
    DELETE: Removes the given user from the given project
    Permissions: User belonging to the given project (PUT) or owner of the given project (DELETE)
```

```
/api/projects/<int:project_id>/requisitions/<int:equipment_id>

project_id: project id
equipment_id: equipment id

    PUT: Adds a requisition to the given equipment associated to the given project and the logged user
    DELETE: Removes a requisition from the given equipment associated to the given project and the logged user
    Permissions: User (PUT) or user in the possession of the active requisition (DELETE)
```

```
/api/projects/<int:project_id>/invite_mentor/<email:email>

project_id: project id
email: destinatary's email

    PUT: Sends an email to the given destinatary with and invitation to visit and become a mentor of the given project
    Permissions: User
```

### Requisitions

```
/api/requisitions

    GET: Returns the list equipments with requisitions from the logged user
    Permissions: User
```

```
/api/requisitions/active

    GET: Returns the list equipments with active requisitions from the logged user
    Permissions: User
```

#### Profiles

```
/api/profiles

    GET: Returns the list of all the user profiles
    Permissions: Everyone
```

```
/api/profile

    GET: Returns the profile  of the logged user
    Permissions: User
```

```
/api/profiles/<int:user_id>

user_id: user id

    GET: Returns the profile of the given user
    Permissions: Everyone
```

```
/api/profiles/<int:user_email>

user_email: user email

    GET: Returns the profile of the given user by its email
    Permissions: Everyone
```

```
/api/profiles/<int:user_id>/teacher

user_id: user id

    PUT: Assigs the given user as teacher
    Permissions: Manager
```

### Solr

```
/api/solr/update/all

user_id: user id

    GET: Sends to solr all the articles in the system
    Permissions: Administrator
```

```
/api/solr/update/<int:article_id>

article_id: article id

    GET: Sends to solr the given article
    Permissions: Administrator
```

```
/api/solr/raw/<string:path>

path: complete path to the solr original API. Example: "/api/solr/raw/api/pt/user/1/projects"

    GET: Calls the solr API's endpoint correspondent to the given path
    Permissions: Administrator
```
