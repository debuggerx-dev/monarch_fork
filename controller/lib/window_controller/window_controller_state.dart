
import 'package:monarch_window_controller/window_controller/data/device_definitions.dart';
import 'package:monarch_window_controller/window_controller/data/dock_definition.dart';
import 'package:monarch_window_controller/window_controller/data/monarch_data.dart';
import 'package:monarch_window_controller/window_controller/data/definitions.dart'
    as defs;
import 'package:monarch_window_controller/window_controller/data/story_scale_definitions.dart';
import 'package:monarch_window_controller/window_controller/data/visual_debug_flags.dart';

import 'data/channel_methods.dart';


class WindowControllerState implements OutboundChannelArgument{
  final bool active;
  final MonarchData? monarchData;
  final String? activeStoryName;

  final DeviceDefinition currentDevice;
  final List<DeviceDefinition> devices;

  final String currentLocale;
  final List<String> locales;

  final MetaTheme currentTheme;
  final List<MetaTheme> themes;

  final StoryScaleDefinition currentScale;

  final List<StoryScaleDefinition> scaleList;

  final DockDefinition currentDock;
  final List<DockDefinition> dockList;

  final double textScaleFactor;
  final List<VisualDebugFlag> visualDebugFlags;

  WindowControllerState({
    required this.active,
    this.monarchData,
    this.activeStoryName,
    required this.devices,
    required this.currentDevice,
    required this.locales,
    required this.currentLocale,
    required this.themes,
    required this.currentTheme,
    required this.currentDock,
    required this.currentScale,
    required this.dockList,
    required this.scaleList,
    required this.textScaleFactor,
    required this.visualDebugFlags,
  });

  factory WindowControllerState.init() => WindowControllerState(
        active: false,
        devices: [defaultDeviceDefinition],
        currentDevice: defaultDeviceDefinition,
        locales: [defs.defaultLocale],
        currentLocale: defs.defaultLocale,
        themes: [defs.defaultTheme],
        currentTheme: defs.defaultTheme,
        currentDock: defs.defaultDock,
        currentScale: defaultScaleDefinition,
        dockList: defs.dockList,
        scaleList: [defaultScaleDefinition],
        visualDebugFlags: defs.devToolsOptions,
        textScaleFactor: 1.0,
      );

  WindowControllerState copyWith({
    String? activeStoryName,
    MonarchData? monarchData,
    bool? active,
    List<DeviceDefinition>? devices,
    DeviceDefinition? currentDevice,
    String? currentLocale,
    List<String>? locales,
    MetaTheme? currentTheme,
    List<MetaTheme>? themes,
    StoryScaleDefinition? currentScale,
    DockDefinition? currentDock,
    double? textScaleFactor,
    List<VisualDebugFlag>? visualDebugFlags,
    List<StoryScaleDefinition>? scaleList,
  }) =>
      WindowControllerState(
        activeStoryName: activeStoryName ?? this.activeStoryName,
        monarchData: monarchData ?? this.monarchData,
        active: active ?? this.active,
        devices: devices ?? this.devices,
        currentDevice: currentDevice ?? this.currentDevice,
        locales: locales ?? this.locales,
        currentLocale: currentLocale ?? this.currentLocale,
        themes: themes ?? this.themes,
        currentTheme: currentTheme ?? this.currentTheme,
        scaleList: scaleList ?? this.scaleList,
        currentScale: currentScale ?? this.currentScale,
        dockList: dockList,
        currentDock: currentDock ?? this.currentDock,
        textScaleFactor: textScaleFactor ?? this.textScaleFactor,
        visualDebugFlags: visualDebugFlags ?? this.visualDebugFlags,
      );

  @override
  Map<String, dynamic> toStandardMap() {
    // As of 2022-05, we only return device, scale and dock.
    // In the future, if clients require more state properties then add 
    // them as needed.
    return {
      'device': currentDevice.toStandardMap(),
      'scale': currentScale.toStandardMap(),
      'dock': currentDock.id
    };
  }
}
