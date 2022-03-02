import 'package:flutter/cupertino.dart';

import 'enums/device_screen_type.dart';

class SizingInfo {
  SizingInfo(
      {this.orientation,
      this.deviceScreenType,
      this.screenWidth,
      this.widgetWidth,
      this.screenHeight,
      this.widgetHeight});

  final Orientation? orientation;
  final DeviceScreenType? deviceScreenType;
  final double? screenHeight;
  final double? screenWidth;
  final double? widgetHeight;
  final double? widgetWidth;

  @override
  toString() {
    return 'ORIENTATION = $orientation ,  DEVICE_SCREEN_TYPE = $deviceScreenType  ,  SCREEN_SIZE = $screenHeight  ,  LOCAL_WIDGET_SIZE = $widgetHeight';
  }
}
