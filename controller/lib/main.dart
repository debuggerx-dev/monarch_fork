import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:monarch_window_controller/utils/localization.dart';
import 'package:monarch_window_controller/window_controller/default_theme.dart'
    as theme;
import 'package:monarch_window_controller/window_controller/window_controller_screen.dart';
import 'package:stockholm/stockholm.dart';

const controlsWidth = 250.0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Window Controller',
      theme: theme.theme,
      home: const WindowControllerScreen(),
      localizationsDelegates: [
        localizationDelegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: localizationDelegate.supportedLocales
    );
  }
}
