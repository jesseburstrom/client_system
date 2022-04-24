
## Demonstration of the project with a multiplayer board game.

The system can handle web platform (Chrome), desktop (Windows), emulator (Android) and real phone (Android).

It can also handle iOs both mobile as well as desktop and Linux desktop.

The mobile versions (phone/tablet) can also have Unity 3D plugin with realtime animations and light effects!

The players communicate through socket connections and there is chat enabled.

<!-- ![Alt Text](DemoMultiplayer.jpg?raw=true "Demo Multiplayer") -->
<!-- ![Alt Text](/jesseburstrom/client_system/blob/master/DemoMultiplayer.jpg?raw=true "Demo Multiplayer") -->
[![Live Demo](VidePlayImage.jpg?raw=true "Demo Multiplayer")](https://www.youtube.com/watch?v=IE9bFjeJQHQ)

[Link To Server](https://github.com/jesseburstrom/WebAPIIdentity/)

[Link To Unity](https://github.com/jesseburstrom/unityplugin/)

[Link To Node Server](https://github.com/jesseburstrom/react-demo/)

# update

2022-03-27

Have learnt React with Redux/THunks and custom middleware and Google Cloud With NodeJS and nginx prerouter for SSL

This is important since I believe the heart of any application is on the web and you also need a place to administrate the application.

React is perfect for this rubust and highly maintained and works on all browsers. Here I want to put all extra information, like news, contact FAQ etc
with the Flutter app as plugin.

Also to get the desktop version one would go to the website for download, and so if the browser is not supported there is always the desktop version!

Having studied the Redux state managment solution I clearly see that I will need something like bloc in the Flutter app.

I will try to see if there is some minimum but 'covers most cases' implemmentation of bloc into the system.

Either way if I do it myself it's somewhat messy and complicated so seems good idea to use bloc.

So the setup looks like: web React(Redux, Thunk) with Flutter Plugin, Flutter with Bloc on all platforms same code, NodeJS express server with MongoDB database on Google Cloud.

Almost free since SSL free and domainname is like 12$/year and free tier GCP. All tech open source (ok not database but need buy service as soon as serious project anyway).

A good way to start some project and if getting traction, one can always move to paid services.

----------------------------------------------------

# waiting for open source

Last but not least i am looking for the most efficient open source solution, after uplifing the project, and it will come soon.
Some mini version with mock db on server that is not persistant etc etc just to make it more managable.

Question is still should i only upload some files with Node.js server, Flutter project, unity project, and give instructions how to install locally?


Important is still to give precise instruction to replicate project first, then comes open source i believe.


# client_system

Generalized Frontend Client System

The purpose of this system is to create a effective frontend display and interaction system
using the framework of Google Flutter. 

The idea is simple: To make a system which saves all the repetetive tasks of application developement 
in a way that is easily maintainable and reusable to save valuable time and have good organization from the first code line.

The project has evolved to now include both NodeJS server as well as ASP .NET server solutions with socket support for both.
It also has a authentication 'module'.


## Flutter

The project is built using Flutter which in turn uses the dart programming language.

For C# programmers an intuitive analogy would bee:

C# is to dart as C++ is to C#

The C# language is clearly a 'simplified' version of C++ as dart is a 'simplified' version of C# but with tons of similarities.

This is good news if one is already used to ASP .NET developement and want to have a frontend client with similar syntax and design.

##


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
