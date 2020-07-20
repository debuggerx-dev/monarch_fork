import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'user_message.dart';

import 'active_locale.dart';
import 'story_view.dart';
import 'monarch_data.dart';

class StoryApp extends StatefulWidget {
  final MonarchData monarchData;

  StoryApp({this.monarchData});

  @override
  State<StatefulWidget> createState() {
    return _StoryAppState();
  }
}

class _StoryAppState extends State<StoryApp> {
  String _locale;
  StreamSubscription _activeLocaleSubscription;

  _StoryAppState();

  @override
  void initState() {
    super.initState();

    _setLocale();
    _activeLocaleSubscription =
        activeLocale.activeLocaleStream.listen((_) => setState(_setLocale));
  }

  void _setLocale() {
    _locale = activeLocale.activeLocale;
  }

  @override
  void dispose() {
    _activeLocaleSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: _getLocalizationsDelegates(),
        supportedLocales: [Locale('en'), Locale('es')],//_getSupportedLocales(),
        locale: Locale('es'),//_getLocale(),
        title: 'Story',
        home: Scaffold(body: StoryView(monarchData: widget.monarchData)));
  }

  Locale _getLocale() {
    if (widget.monarchData.metaLocalizations.isEmpty) {
      return null;
    }
    else {
      return parseLocale(_locale);
    }
  }

  Iterable<LocalizationsDelegate<dynamic>> _getLocalizationsDelegates() {
    final delegate = widget.monarchData.metaLocalizations[0].delegate;
    if (delegate is LocalizationsDelegate<dynamic>) {
      printUserMessage('IS LocalizationsDelegate<dynamic> [${delegate.runtimeType.toString()}] [${delegate.type.toString()}] [${delegate.isSupported(Locale("es"))}]');
    }
    else {
      printUserMessage('NOT LocalizationsDelegate<dynamic>');
    }
    // if (widget.monarchData.metaLocalizations.isEmpty) {
    //   return null;
    // }
    // else {
      return [
          // ...widget.monarchData.metaLocalizations.map((x) => x.delegate).toList(),
          // widget.monarchData.metaLocalizations[0].delegate,
          delegate,
          ...GlobalMaterialLocalizations.delegates,
          // GlobalWidgetsLocalizations.delegate,
          // GlobalCupertinoLocalizations.delegate,
        ];
    // }
  }

  Iterable<Locale> _getSupportedLocales() {
    if (widget.monarchData.metaLocalizations.isEmpty) {
      return null;
    }
    else {
      final locales = <Locale>[];
      for (var metaLocalization in widget.monarchData.metaLocalizations) {
        locales.addAll(metaLocalization.locales);
      }
      return locales;
    }
  }
}
