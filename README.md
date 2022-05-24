
## Demonstration of the project with a multiplayer board game.

The system can handle web platform (Chrome), desktop (Windows), emulator (Android) and real phone (Android).

It can also handle iOs both mobile as well as desktop and Linux desktop.

The mobile versions (phone/tablet) can also have Unity 3D plugin with realtime animations and light effects!

The players communicate through socket connections and there is chat enabled.

<!-- ![Alt Text](DemoMultiplayer.jpg?raw=true "Demo Multiplayer") -->
<!-- ![Alt Text](/jesseburstrom/client_system/blob/master/DemoMultiplayer.jpg?raw=true "Demo Multiplayer") -->
[Link To Live Demo](https://clientsystem.net/flutter-app)

The link : clientsystem.net/flutter can be used in phone to test the system (not including react to get full screen).

[Link To Unity](https://github.com/jesseburstrom/unityplugin/)

[Link To Node Server](https://github.com/jesseburstrom/react-demo/)

# update
2022-05-24

Fixed Flutter to Unity communication by adding also websocket communication. There is one that also works with webGL luckily!
I have also put up good workflow between Online/Local developement in Unity, Flutter, NodeJS and React.
3D dices now works in demo! Working on making it all better UI and visually now technical issues mainly fixed!

(It might help others it was [endel/NativeWebSocket](https://github.com/endel/NativeWebSocket) that saved it! (of course if I find other resolution maybe it was my mistake from first but right now it made it work for me and I learnt alot.)

2022-05-22

WOrks on web now and have last fix of communication between Unity and Flutter to fix and then it works with 3d Unity on web as well!

Have some testing and bugfixing to do in general considering multiplayer socket.

So the setup looks like: web React(Redux, Thunk) with Flutter Plugin, Flutter with Bloc(soon) on all platforms same code, NodeJS express server with MongoDB database on Google Cloud.

Surpricingly the web version works equally good on both android(tested chrome and edge) and iphone(tested chrome and safari) also with unity 3d eliminating completely the need to compile to mobile platform!

----------------------------------------------------

# waiting for open source

Until system fully tested and tried out also with more applications.
I mean all obvious things I see needs working out.

The code presented is not the recent version which i develop on other repo until ready for open source.


# client_system

Generalized Frontend Client System

The purpose of this system is to create a effective frontend display and interaction system
using the framework of Google Flutter. 

The idea is simple: To make a system which saves all the repetetive tasks of application developement 
in a way that is easily maintainable and reusable to save valuable time and have good organization from the first code line.


## Flutter

The project is built using Flutter which in turn uses the dart programming language.

For C# programmers an intuitive analogy would bee:

C# is to dart as C++ is to C#

