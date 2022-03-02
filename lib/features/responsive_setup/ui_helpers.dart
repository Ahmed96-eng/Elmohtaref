import 'package:flutter/widgets.dart';

import 'enums/device_screen_type.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.shortestSide;

  if (deviceWidth > 950) {
    return DeviceScreenType.desktop;
  }
  if (deviceWidth > 600) {
    return DeviceScreenType.tablet;
  }
  return DeviceScreenType.mobile;
}
