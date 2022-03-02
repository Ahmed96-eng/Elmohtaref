import 'package:flutter/material.dart';
import 'package:mohtaref_client/features/responsive_setup/sizing_info.dart';
import 'package:mohtaref_client/features/responsive_setup/ui_helpers.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({this.builder});

  final Widget Function(BuildContext context, SizingInfo)? builder;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return LayoutBuilder(
      builder: (context, boxConstrains) {
        var sizingInfo = SizingInfo(
          orientation: mediaQuery.orientation,
          deviceScreenType: getDeviceType(mediaQuery),
          screenWidth: mediaQuery.size.width,
          screenHeight: mediaQuery.size.height,
          widgetHeight: boxConstrains.maxHeight,
          widgetWidth: boxConstrains.maxWidth,
        );
        return builder!(context, sizingInfo);
      },
    );
  }
}
