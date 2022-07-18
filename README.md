
## Demonstration of the project with a multiplayer board game.

The system can handle web platform (Chrome), desktop (Windows), emulator (Android) and real phone (Android).

It can also handle iOs both mobile as well as desktop and Linux desktop.

The mobile versions (phone/tablet) can also have Unity 3D plugin with realtime animations and light effects!

(The web version of the mobile platforms with 3D are currently instable due to update but without 3D works great!)

The players communicate through socket connections and there is chat enabled.

<!-- ![Alt Text](DemoMultiplayer.jpg?raw=true "Demo Multiplayer") -->
<!-- ![Alt Text](/jesseburstrom/client_system/blob/master/DemoMultiplayer.jpg?raw=true "Demo Multiplayer") -->
[Link To Live Demo](https://clientsystem.net/flutter-app)

The link : clientsystem.net/flutter can be used in phone to test the system (not including react to get full screen).

[Link To Unity](https://github.com/jesseburstrom/unityplugin/)

[Link To Node Server](https://github.com/jesseburstrom/react-demo/)


# update 2022-07-13

Added general tutorial with moving arrows on objects having text and fixed many small things.

The layout system is now working good on small and large devices and the idea is to have it work good on any project from scratch.
Say one develops an ordering system to work in industry then the size or model of tablet is from layout perspective irrelevant, looks and works well on all.

Putting 3d to side (it will take long time before it is stable anyway, revisit later.) to work only on general project with design patterns and technical organisation.

#update 2022-06-27

Using batch script to compile flutter and then copy files to server and upload to repo with one command. Use different domain and instance for that. Makes sense to have same environment for testing as deployment. Also hot-reload works if run on Android Studio!

Beginning to build other apps like a presentation app where one logs in on say web and use phone as controller. Many such things are seamless in this setting.
Maybe other clients can be allowed to navigate presentation as well locally (many times one wanted to see earlier slide but to late...)

# update
2022-06-21

Fixed many things, Web works nice and have Tutorial also (arrow with text on objects in situations).

On mobile have improved visibility by using space differently, removing unnecessary widgets to enlarge others. Still need some tweeking.

Realized the best is probably to move local developement to online through scripting. This since Websocket over lan need https which is counterntuitive working 
offline.

in end win more scripting 'flutter build web' + '' + ... in one command.

Also need not change isOnline flag between online deployment and offline developement. Only need other instance with other address.

I did all this by myself finding information around!!!

-----------------------------------------------------------------------------------------------------------------------------------

So the setup looks like: web React(Redux, Thunk) with Flutter Plugin, Flutter with Bloc(soon) on all platforms same code, NodeJS express server with MongoDB database on Google Cloud.

Surpricingly the web version works equally good on both android(tested chrome and edge) and iphone(tested chrome and safari) also with unity 3d eliminating completely the need to compile to mobile platform!

----------------------------------------------------

# client_system

Generalized Frontend Client System

The purpose of this system is to create a effective frontend display and interaction system
using the framework of Google Flutter. 

The idea is simple: To make a system which saves all the repetetive tasks of application developement 
in a way that is easily maintainable and reusable to save valuable time and have good organization from the first code line.


## Flutter

The project is built using Flutter which in turn uses the dart programming language.

OBS this repo is not the current Flutter Part of the System just DEMO!


