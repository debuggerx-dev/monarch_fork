import 'package:flutter/material.dart';

import 'package:monarch_utils/log.dart';
import 'package:monarch_utils/log_config.dart';

import 'active_theme.dart';
import 'channel_methods_sender.dart';
import 'channel_methods_receiver.dart';
import 'standard_themes.dart';
import 'stories_errors.dart';
import 'story_app.dart';
import 'monarch_data.dart';
import 'user_message.dart';

final logger = Logger('Start');

void startMonarch(String packageName, List<MetaTheme> userMetaThemes,
    Map<String, MetaStories> metaStoriesMap) {
  _setUpLog();

  logger.finest('Starting Monarch flutter app');

  userMetaThemes = _validateAndFilterMetaThemes(userMetaThemes);

  final monarchData =
      MonarchData(packageName, userMetaThemes, metaStoriesMap);

  setUpStoriesErrors(monarchData);
  activeTheme.setMetaThemes([...userMetaThemes, ...standardMetaThemes]);

  runApp(StoryApp(monarchData: monarchData));

  receiveChannelMethodCalls();
  _sendInitialChannelMethodCalls(monarchData);
}

void _setUpLog() {
  defaultLogLevel = LogLevel.ALL;
  logToConsole(printTimestamp: false, printLoggerName: true);
}

List<MetaTheme> _validateAndFilterMetaThemes(List<MetaTheme> metaThemeList) {
  final _list = <MetaTheme>[];
  for (var item in metaThemeList) {
    if (item.theme == null) {
      printUserMessage('Theme "${item.name}" is not of type ThemeData. It will be ignored.');
    }
    else {
      logger.fine('Valid theme found: ${item.name}');
      _list.add(item);
    }
  }
  return _list;
}

void _sendInitialChannelMethodCalls(MonarchData monarchData) async {
  await channelMethodsSender.sendPing();
  await channelMethodsSender.sendDefaultTheme(activeTheme.defaultMetaTheme.id);
  await channelMethodsSender.sendMonarchData(monarchData);
  await channelMethodsSender.sendReadySignal();
}
