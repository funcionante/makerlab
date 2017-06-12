---
layout: default
category: Developer
order: 1
---

In order to overcome the need for students and professors to have another account to manage,
MakerLab's access is based on integration with the university’s authentication system,
which uses [Open Authorization (OAuth) protocol](https://tools.ietf.org/html/rfc5849).

The authentication and login process are centralized on MakerLab's api endpoints
in order to prevent clients (wiki, mobile applications, etc.) from having to deal
with their own authentication system.

To join OAuth protocol with wiki's django server, we use [Requests-OAuthlib](
http://requests-oauthlib.readthedocs.io/en/latest/index.html), which provide an
interface for building OAuth1 (version used by University of Aveiro) and OAuth2 clients.

For an application to communicate with OAuth server, it must be registered and authorized,
by [requesting a Consumer and Secret Key](http://identity.ua.pt/oauth/) and wait
for the application to be approved.

The OAuth service of the University of Aveiro is composed of four steps, namely :

1. Request Token : after the Consumer Key and Secret have been obtained, we can begin
using the OAuth protocol to access restricted services. The first step is to require
a pair of temporary credentials on `auth/login`. These tokens will be needed on
first steps and have a useful life of 30 minutes, so we need to save them taking
into account the concurrency accesses, by using locks and timestamps on write operations.

2. Authorize : now that we have the temporary tokens, we must proceed with the
authentication and authorization of the user by redirecting them to University
of Aveiro's IdP, where te user will enter their credentials and approve the use
of personal informations by our application.

3. Access Token : after Authorize process ends, a new set of tokens (authorization tokens)
will be returned (by a redirect from IdP to `auth/auth` endpoint) that will be used
on this step to generate the access tokens. 

4. Get data : with final access tokens we can make request for specific user's
informations, whose list can be found on the [documentation website of the university](
http://api.web.ua.pt/pt/services/universidade_de_aveiro/oauth#servicos_disponiveis).
On the first registration of the user on our platform some informations are saved
on theirs wiki profile, namely the full name, mec. number and course, if it is a student,
or just the name in the case of a teacher.

After all steps above are completed a redirect to wiki has to be done, in order to
start using it's features.
