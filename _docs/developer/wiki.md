---
layout: default
category: Developers
order: 100
---

Wiki is the core of the system. There lives (almost) all the information of the system. On the one hand, wiki provides tools to manage equipments, projects and users. On the other, users can collaboratively edit articles, in a version controlled way, to document and share all the information that assists students making their projects happen.

## Context

To avoid some misunderstandings, we want to give you a few words about the wiki's concept. Wiki is primarily... a Wiki, like Wikipedia. There are articles on users, projects and equipments. But, due to the requirements for management, it  provides the capabilities of an information system. A wiki is primarily a place to store flexible content, that can be indexed in a dynamic way. For example, each equipment, in its article, saves the requisitions' logs in a XML structure, along with the content of the article itself.

## Before starting

Before you continue, here are some recommendations for where to start if you need to develop new features over the wiki. Wiki is a fork of the django-wiki project, developed in django, a Python's web framework. So, first you need to be familiar with Python, witch we assume you are. Second, you will need to be familiar with django, witch we assume you aren't. In order to achieve that, we recommend you the beginners tutorial available on django's documentation, [here](https://docs.djangoproject.com/en/1.11/intro/tutorial01/). It will give you a fast and complete way to understand the django's basics. We really recommend you to follow this tutorial, otherwise it will be chaotic for you too understand what is going on in the project's structure. After performing this, be sure that words like models, views, urls and templates are not weird for you in the context of django. To conclude, as we said, django-wiki (the original project from where we forked our own) is developed in django. This is not specially important to know, but if you are curious, take a few seconds to visit their repository [here](https://github.com/django-wiki/django-wiki).

## Database model
The system is based in the database that was originally developed in the django-wiki. The database has all the logic to manage articles, article's revisions and a few other things. The database model is presented bellow, and it will be very useful for you when you start manipulating the source code. Use it to guide yourself when building your queries.

![Wiki models](https://firebasestorage.googleapis.com/v0/b/makerlab-b9b8c.appspot.com/o/wiki%2Fwiki_model.png?alt=media&token=e5ffe110-3fec-4a75-87ad-1070d737bbab)

The database model is 100% kept like the original. This has to do with our vision to build a dynamic and flexible system. The database serves the low level logic to manage the basic functionalities of a wiki: the articles. All the logic we needed to implement in each article type (equipments, projects, users), was done in the article content. Each article has in its content a XML structure. That XML provides everything we need to store information in a structured way. The wiki, supported with an indexer and a parser, can interpret all this information in a dynamically.

The tag 'type' specifies the article type. The article's content, displayed to the users when they surf on the wiki, is saved in the 'content' tag, using markdown. Other tags are present according to the article type.

### Equipment's structure

Each equipment has tags for quantity, active requisitions and requisition logs.

```
<wiki>
    <content>
        # Ficha Técnica
        * ** Família: ** Microcomputador
        * ** Sub-Família: ** Raspberry
        * ** Código: ** 640522710850
        * ** Preço (c/ IVA): ** 38.63€
        * ** Fornecedor: ** Farnell
        * ** Localização: ** N/A
        * ** Data Última Aquisição: ** 2016/11/03

        # Imagens
        [image:4 align:left size:orig]

        ...
    </content>
    <type>equipment</type>
    <quantity>20</quantity>
    <active_requisitions>1</active_requisitions>
    <requisitions>
        <requisition>
            <project>42</project>
            <member>1</member>
            <begin>2017-06-11T17:35:22.773391Z</begin>
            <end>2017-06-11T17:35:33.716983Z</end>
        </requisition>
        <requisition>
            <project>42</project>
            <member>1</member>
            <begin>2017-06-11T17:35:24.551744Z</begin>
        </requisition>
    </requisitions>
</wiki>
```

### Project's structure

A project has tags for members.

```
<wiki>
    <content>
        # Descrição
        O DETI MakerLab é um sistema projetado para gerir a nova sala do DETI.
        ...
    </content>
    <type>project</type>
    <members>
        <owner>4</owner>
        <mentor>2</mentor>
        <member>5</member>
        <member>8</member>
    </members>
</wiki>
```

## User profile's structure

A user profile saves some personal data like NMEC and course. It also registers if a user is a teacher.

```
<wiki>
    <content>
        # Sobre mim
        ![Foto](https://qph.ec.quoracdn.net/main-thumb-t-47219-200-krmazzslyzgyzmjogyetrglpdgxnodob.jpeg)

        Esta página é reservada a ti. Edita-a a teu gosto.
        ...
    </content>
    <type>profile</type>
    <is_teacher>True</is_teacher>
</wiki>
```

## API

Wiki has an API that is available to be used for any developer that wishes to, but was originally designed to be used and integrated with our mobile app. With the evolution of the project it was also used by our chatbot and even by some particular features of the wiki. Above are the endpoints available and its usage

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
