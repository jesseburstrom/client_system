// System imports
import "dart:async";
import "dart:convert";
import "dart:io";
import "dart:math";

import "package:http/http.dart";
import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";
import "package:socket_io_client/socket_io_client.dart";
import 'package:web_socket_channel/web_socket_channel.dart';

// Animations imports
import "package:animated_text_kit/animated_text_kit.dart";
import "package:flutter_unity_widget/flutter_unity_widget.dart";

part "layouts.dart";

part "startup.dart";

part "./application/animations_board_effect.dart";

part "./application/application.dart";

part "./application/application_functions_internal.dart";

part "./application/application_functions_internal_calc_dice_values.dart";

part "./application/languages_application.dart";

part "./application/widget_application.dart";

part "./chat/chat.dart";

part "./chat/languages_chat.dart";

part "./chat/widget_chat.dart";

part "./dices/animations_rolldice.dart";

part "./dices/dices.dart";

part "./dices/languages_dices.dart";

part "./dices/widget_dices.dart";

part "./file_handler/file_handler.dart";

part "./highscore/animations_highscore.dart";

part "./highscore/highscore.dart";

part "./highscore/languages_highscore.dart";

part "./highscore/widget_highscore.dart";

part "./input_items/input_items.dart";

part "./languages/languages.dart";

part "./net/net.dart";

part "./pages/languages_application_connect.dart";

part "./pages/languages_application_settings.dart";

part "./pages/languages_login.dart";

part "./pages/authenticate.dart";

part "./pages/application_connect.dart";

part "./pages/application_settings.dart";

part "./pages/pages.dart";

part "./scroll/animations_scroll.dart";

part "./scroll/languages_animations_scroll.dart";

part "./scroll/widget_scroll.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future attemptLogin(BuildContext context) async {
  var isLoggedIn = false;
  try {
    var userData = await fileHandler.readFile(authenticate.fileAuthenticate);
    isLoggedIn =
        await authenticate.tryLogin(userData["username"], userData["password"]);
  } catch (e) {
    print(e.toString());
  }

  Timer.run(() {
    if (!isLoggedIn) {
      pages.navigateToAuthenticatePageR(context);
    } else if (!gameStarted) {
      pages.navigateToSelectPageR(context);
    } else {
      pages.navigateToMainAppHandlerPageR(context);
    }
  });
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    attemptLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
