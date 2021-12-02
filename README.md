
## Demonstration of the project with a multiplayer board game.

The system can handle web platform (Chrome), desktop (Windows), emulator (Android) and real phone (Android).

It can also handle iOs both mobile as well as desktop and Linux desktop.

The mobile versions (phone/tablet) can also have Unity 3D plugin with realtime animations and light effects!

The players communicate through socket connections and there is chat enabled.

<!-- ![Alt Text](DemoMultiplayer.jpg?raw=true "Demo Multiplayer") -->
[![Live Demo](VidePlayImage.jpg?raw=true "Demo Multiplayer")](https://www.youtube.com/watch?v=czephRjgjD4){target="_blank"}


# client_system

Generalized Frontend Client System

The purpose of this system is to create a effective frontend display and interaction system
using the framework of Google Flutter. 

The idea is simple: To make a system which saves all the repetetive tasks of application developement 
in a way that is easily maintainable and reusable to save valuable time and have good organization from the first code line.

The project has evolved to now include both NodeJS server as well as ASP .NET server solutions with socket support for both.
It also has a authentication 'module'.

This brings us to 'modules'

## Modules

During developement I have tried all thinkable variations of class handling to try to find the most convinient ways
of building and maintaining the various parts of an application.

In a module which is a class I have decided that most convinient is to keep widget display in separate extension files (holds methods belonging to class),
as well as language definitions. This also includes the widgets and language definitions for the settings page(s).

I chose to let the settings page be part of the main class to avoid circular class call problems (the settings need access to project attributes and the project need access to the settings).

## Animations

The animations I found could very well be class by themself and then be imported into the main class. THe gain is to keep the attributes in the animation class itself but there is still need to communicate into animations.Also somewhat more verbose to have to reference instance of class.

But this is due to limitations of override for the main class. It can only override one full class with constructor and or attributes and that I chose to give to the language handling.

## Language

The Language class is defined with getters ending with _ so that for example the word "Hello" is defined:

final _hello = {"English": "Hello"};

String get hello_ => getText(_hello);

void languagesSetup() {

    _hello["Swedish"] = "Hej";
 
}

In the widget that displays the word it is clearly seen it is translated text by the _ ending : hello_

## Page handling

I am currently experimenting with a simplified page and state/context handler.

I collect all the setup and handling of pages in the page class and have simplified it to 2 levels.
One main application page and one for settings or extra pages.

Though the construct is to explore ways of organizing page handling over the full application (also after recieving message from server) it certainly allows for personal page additions as usual.

It has the benefit of simplifying the layout of main.dart and the startup.dart file.

## Second project interactive shopping system

To show the usage of this system and develop further the api and communication with .NET server with Entity Framework,
this project is a 'copy'(under construction) of the interactive ordering application at Burger King.

The chat could be changed to serve as a customer contact chat in this case or maybe for internal messaging among staff.

![Alt Text](DemoDatabase.jpg?raw=true "Demo Database")

## Layout

Each module has a layout file that defines the various widgets position on the screen and the relative order of display.
The definition of display takes into account portrait and landscape mode and can be conditionally set much like in razor pages :NET

## Empty project template

Along with the modules comes the main application module which at startup will be a simple 'empty project template' showing how all
parts are connected with minimal demonstration examples for setting, animation, communication etc...

## Chat

The chat module really showcase the effectiveness of this system.

It uses all parts even in it's simplest form and is very easy to change and integrate with any project.

## Acknowledgements

I want to thank all great people around the world who shared their ideas upon which this project is built, hundreds of them at least maybe more.

The whole project started as a reaction to the pandemic, fine now I have time (in isolation) to build that system I have been thinking of all these years.
Then it gradually grew to become the idea of the system anyone can use to quickly get application up and running.

The only requiriment I had initially was something open source, full stack, some database and works on mobile devices.

Now I have just that but it works on all platforms and is just so much better than I could ever dream of.

Special thanks to Lexicon education company withouth which the content of this project would have been less than half of what it is today!

## Open source

The next step would to make this open source and for that I have first made sure the project can handle multiple applications without conflict.
With my second project, building a rest api for database management (under construction) I can see it works well.

Changing the main class from: app = App() to app = Application() works fine.

To handle different additions i'm thinking of some module handling system (save the different .dart files in database) where users can
suggest improvement or point out bugs and the creator can update.

This alongside some traditional open source management where the main system is open for pull requests and well developed additions are brought in.

This since there for natural ways can be many different versions of any module say Chat for example.



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
