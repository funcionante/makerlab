---
layout: default
category: Developer
order: 11
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

## environ.json
Wiki has a configuration file some environment variables. Those value vary from installation to installation. This is an example of a setup of this file:

```
{
    "HOST": "https://deti-makerlab.ua.pt/",

    "ALLOWED_HOSTS": "188.166.77.53 127.0.0.1",
    "DEBUG": true,
    "SECRET_KEY": "1234567890qwertyuiopasdfghjklzxc",

    "DATABASE_HOST": "127.0.0.1",
    "DATABASE_PASSWORD": "password",
    "DATABASE_PORT": "5432",

    "WIKI_URL": "http://127.0.0.1:80",
    "SOLR_URL": "http://127.0.0.1:5000",

    "MEDIA_ROOT": "/var/www/makerlab/media/",
    "STATIC_ROOT": "/var/www/makerlab/static/",

    "DML_AUTH_KEY": "_1234abcd",
    "DML_AUTH_SECRET": "_5678efgh",

    "DML_EMAIL_HOST": "noreply@deti-makerlab.ua.pt",
    "DML_EMAILS_ADMIN": "admin@example.com",
    "DML_EMAILS_MANAGER": "manager@example.com, manager2@example.com"
}
```

The parameters without the `DML_ prefix` are mapping configuration parameters original from django, used in a `settings.py` file. Bellow is an explanation of the others:

* `HOST`: Wiki MakerLab base url;
* `DML_AUTH_KEY` and `DML_AUTH_SECRET`: Parameters from UA OAuth [ver aqui](http://api.web.ua.pt/pt/services/universidade_de_aveiro/oauth);
* `DML_EMAIL_HOST`: email to appear in the sender field of MakerLab's automatic emails
* `DML_EMAILS_ADMIN`: list of emails to where are sent a copy of all emails sent by the system (usually the administrator of the system)
* `DML_EMAILS_MANAGER`: list of emails to where are sent all requisitions/deliveries (usually the managers of the system)

## Wiki roles
When developing new features to the wiki, be attentive to the existent user roles, explained in detail [here](/specification/wiki/).  

## django-wiki

Along the development of MakerLab Wiki, we maintained our repository fork updated with the new versions coming from django-wiki ([here](https://github.com/django-wiki/django-wiki)), the wiki that is in the origin of ours. All the development made in MakerLab Wiki was done with that in mind, supporting new changes from the original project, MakerLab Wiki up to date with the new features and fixes that came from the original project. So, please keep these efforts in your development, don't forget to merge new django-wiki versions with ours.
