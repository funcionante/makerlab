---
layout: default
category: Developer
order: 10
---

# Authentication

Since the authentication process is centralized in MakerLab's api endpoint, the app 
will make this process through a Web View that, allied to the redirects made by 
OAuth protocol used by the university, will take the user through the steps needed
to the authentication process. The app will only interfere in last step - 
establishing the session with the wiki - where it will get the session-id through
the request headers and save it in the app preferences (Shared Preferences),
as it will be necessary to perform all the requests to MakerLab's api endpoints.
This Shared Preferences are saved in a secure way (Secure Preferences) on the equipment
(smartphone or tablet) memory. After this proccess, the webview cache need to be
cleared, so that the user can logout and re-login with another accounts, since UA's
idp saves session and allways maintains an logged account.

After the login's process, the app will request for user's infos by making
a request to `/api/profile` endpoint and save the user name, email and wiki user id.
At this point the app also saves the current login time, since wiki's session is maintained
only for 15 days, so it needs to force logout so that the session-id is allways
valid.

An auto-login feature is also present, by handling the user infos on app preferences.
When the user forces logout, these infos are cleared, so the app will ask the user
to make authentication by following all workflow shown above.

# DMLCalls

The DMLCalls is the model class responsible for populate and mantaining the information
needed on others views, namely the complete list of users, and the list of projects 
and requisitions of the user that is authenticated.
A complete workflow (getting list of users > list of user's projects > list of user's
requisitions) is done on the app startup, so that the views can be populated in
the initial state.

These information obtained from the MakerLab's api endpoints is stored follwoing
the OOP methodology, as follows.

* Users list : based on User object, which contains its name (first and last),
wiki user id and a flag used to manipulate checkable list on "Adicionar Membros"
feature;
* User's projects list : based on Project object, which contains project name and id,
creation date and a list of it's members (User objects);
* User's requisitions list : based on Requisition object which contains the item name
and id, the associated project name and number of units requested;

These objects are stored in lists, accessible at any time, through DMCalls instance.
It is also possible to force a refresh of the user's projects and requisitions
by calling the respective method (forceUserProjectsLoad, forceUserRequisitions).
The user's projects refresh will notify Main Activity (with a broadcast signal)
and redirect the user to projects list in order to refresh the list view 
with the last projects, and the user's requisitions refresh will notify the reader
fragment in order to re-activate the camera function.


## Api call's

All requests to MakerLab's api endpoints are done based on Volley lib.
However, since wiki host has a self-signed certificate to work on http secure mode
(https), some changes have to be done on top of Volley lib. These changes are 
present on `network package` , namely:

* AndroidSelfSigned - based on [erickok solution](https://gist.github.com/erickok/7692592)
creates a keystore containing trusted certificates, a trust manager that trust
 on certificates placed on the keystore and a ssl context that uses that trust manager;
* VolleySelfSigned - using all tools created on AndroidSelfSigned and based on
HurlStack, creates a connection with a custom ssl socket factory (NoSSLv3SocketFactory)
and attach a session-id (cookie) to it;
* [NoSSLv3SocketFactory](https://github.com/gotev/okhttp-tlscompat/blob/master/okhttp-tlscompat/src/main/java/net/gotev/okhttptlscompat/NoSSLv3SocketFactory.java) -disables SSLv3, since while making a secure connection, android was falling back
to SSLv3 from TLSv1 . It is a known bug in android versions <= 4.4 and it can be
solved by removing the SSLv3 protocol from enabled protocols list;
 
The server certificate that is used on MakerLab's api endpoints interactions is
generated in MakerLab's server (.crt extension) and placed on assets folder (on project path).
Also, the cookie that is attached to the requests / responses is obtained on
Authentication phase, as described in above section.

# Views structure

The app views are all based on Fragments interface, selected by a side menu which
is available at any time with the exception of Project Page fragment, User list
fragment and Create Project fragment, since they make part of a separate workflow.
In that case, it is necessary to handle go back feature (top left icon is replaced
for a go back arrow) and it's logic in MainActivity.

# Item scanner

Since the app needs to scan QR codes and work on theirs information,
the application uses [MobileVisionBarcodeScanner](https://github.com/KingsMentor/MobileVisionBarcodeScanner)
lib, which in itself is based on a [solution created by Google](https://developers.google.com/vision/android/barcodes-overview).
It detects a QR code and returns it's value so that we can work above it.

## Augmented Reality

The augmented reality feature was a addition made on MobileVisionBarcodeScanner
source code. When a code is readed, a Barcode wrapper is created, which make
possible to find the code bounding box. Based on that, the app builds and draw four
paintings on returned canvas, as following:

* Rect Background - fills the background with white color and bounds the image;
* Logo bitmap - decodes the png logo file and creates a scaled bitmap to draw over the
rect background;
* Rect border - draws a rectangle border with MakerLab's color, to make the canvas look better;
* Text - computes text position on rect's bottom, so that it appears centered with it. This
text is the equipment name where the QR code is pasted, and it is obtained by making
a request to `api/equipments/QRCODE_SCANNED`. These names are maintained in a Map
so that repeated requests are not made to previously readed codes;

This feature can be enabled or disabled on settings menu, which controlls a flag
saved on app preferences.

## Requisitions / Deliveries logics

After the QR code is readed and returned, it is necessary to find the equipment
infos, by making a request to `api/equipments/QRCODE_SCANNED` and analyse the name,
quantity and active requisitions number. After that a dialog is created to
handle user input, namely:

* Requisition / Delivery chooser - a switch which determines whether the user wants
to make a requisition or a delivery;
* Project - if the user wants to make a requisition, the project spinner will
show all user's projects (DMLCalls projects list) so that the user selects one of them
to associate the requisition. If it is a delivery, the project spinner will just
show the projects in which the user have active requisitions, by analysing user 
active requisitions list (DMLCalls requisition list);
* Number of units - determines the number of units the user want to request or deliver.
The request max value is limited to 10 (so the server does not overload) or number
of units available if it has a value smaller than 10. The deliver max value is also
limited to 10 or number of units in the active requisition, if it has a value smaller than 10.

The inexistence of projects prevents the dialog from being displayed, since
there are no projects in which the user can associate the requisition, as well as
the inexistence of available equipment's units will block the requisition feature
and the inexistence of active requisitions of the equipment will block delivery feature.

When "Concluir" button is pressed, the request need to be done, by making a PUT request
to `api/projects/CHOSEN_PROJECT_ID/requisitions/QRCODE_SCANNED` in order to make a requisition
or a DELETE request to same endpoint to make a delivery. Since the server does 
not support multiple requisitions / deliveries at once, it is necessary to make 
multiple requests to the specific endpoint, which value is determined by the 
number chosen in the NumberPicker. After all requests are computed
by the server, a message with operation status will show and the requisition list needs
to be refresh by making a reload of the requisitions list on DMLCalls, which, when the reload
is finished, will broadcast a signal in order to allow the user to make new requisitions
or deliveries based on updated values.

# Projects

## Create Project

Based on two fields on a form where the user fills the project name and description
a PUT request is made to `api/projects/new?title=PROJECT_NAME&content=PROJECT_DESCRIPTION`.
After that the user is redirected to project list view.

## Listing Projects

The user's projects list (DMLCalls projects list) is showing based on a listview with
a custom adapter which shows the project name, creation date and a rectangle image which
represents the project.

## Project Page

When a project is clicked on above section, a page with more details appears.
The main feature of this page is to see and manage the project members, by showing
a list with them.

## Adding members to projects

When the user clicks on "Adicionar Membros", a new page with all MakerLab's users
is shown, so that the user can select and add multiple members to it's projects.
This checkable list is handle by consulting isSelected flag present on User object,
so it needs to be unchecked on page startup. A listview item click listener is also
setted in order to improve user experience and allow them to pick a user by simply touch on
the item or in the checkbox. When "Adicionar Membros" button is clicked, a PUT request
to `api/projects/PROJECT_ID/members/USER_ID` has to be done , user by user, since
the server does not support multiple addings'.

## Requisitions Lists

Based on requisitions and deliveries done on Item Scanner section, a page will be
show all user active requisitions (DMLCalls requisition list).
Each item of this list will have the equipment name, the project which requisition
is associated and number of units requested.


# Development Environment

The app was created on Android Studio IDE and the dependencies are maintained using
Gradle (used by default with Android Studio IDE).

## Dependencies

In order to create and build the app so that the requeriments and user experience
gets fulfilled, some external libs have been used, namely:


* MobileVisionBarcodeScanner - base lib to read QRCodes, as explained in the above sections;
* [Gravatar-Android](https://github.com/tkeunebr/gravatar-android) - used to
load user avatar;
* [TextDrawable](https://github.com/amulyakhare/TextDrawable) - used to draw
project image/avatar on its page and projects list;
* [Picasso](https://github.com/square/picasso) - used to download and cache images;
* [SecurePreferences-lib](https://github.com/scottyab/secure-preferences) - wrapper
that encrypts the values of Shared Preferences;
* [FloatingActionButton](https://github.com/Clans/FloatingActionButton) - custom
and animated floating action button based on material design specification;
* [Volley](https://github.com/google/volley) - HTTP library that makes network requests
faster and easier to handle;
* [CircleImageVIew](https://github.com/hdodenhof/CircleImageView) - used to draw
user avatar with a circular shape;
