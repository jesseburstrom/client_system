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

part 'application/layouts_application.dart';

part "startup.dart";

part "app/animations_app.dart";

part "app/app.dart";

part "app/communication_app.dart";

part "app/languages_app.dart";

part "app/languages_app_settings.dart";

part "app/layout_app.dart";

part "app/widget_app.dart";

part "app/widget_app_settings.dart";

part "app/widget_app_scaffold.dart";

part 'application/languages_application_settings.dart';

part "application/animations_application.dart";

part "application/application.dart";

part "application/application_functions_internal.dart";

part "application/application_functions_internal_calc_dice_values.dart";

part "application/communication_application.dart";

part 'application/widget_application_settings.dart';

part "application/languages_application.dart";

part "application/widget_application.dart";

part "application/widget_application_scaffold.dart";

part 'authenticate/authenticate.dart';

part 'authenticate/languages_authenticate.dart';

part 'authenticate/widget_authenticate.dart';

part "chat/chat.dart";

part "chat/languages_chat.dart";

part "chat/widget_chat.dart";

part "dices/animations_rolldice.dart";

part "dices/dices.dart";

part "dices/languages_dices.dart";

part "dices/unity_message.dart";

part "dices/widget_dices.dart";

part "file_handler/file_handler.dart";

part "highscore/animations_highscore.dart";

part "highscore/highscore.dart";

part "highscore/languages_highscore.dart";

part "highscore/widget_highscore.dart";

part "input_items/input_items.dart";

part "languages/languages.dart";

part "layout/pos.dart";

part "net/net.dart";

part "pages/pages.dart";

part "scroll/animations_scroll.dart";

part "scroll/languages_animations_scroll.dart";

part "scroll/widget_scroll.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PageDynamic(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
