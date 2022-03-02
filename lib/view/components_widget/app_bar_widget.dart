import 'package:flutter/material.dart';
import 'package:mohtaref_client/view/components_widget/icon_button_widget.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';

import '../../constant.dart';
import 'navigator.dart';

class AppBarWidgets extends StatelessWidget {
  final String? title;
  final double? width;
  final bool? closeIcon;
  final bool? showTap;
  final List<Widget>? tabs;

  const AppBarWidgets(
      {Key? key,
      this.title = "",
      this.width,
      this.closeIcon = false,
      this.tabs,
      this.showTap = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: mainColor,
      title: Text(
        title!,
        style: lineStyleSmallBlack,
      ),
      bottom: showTap!
          ? TabBar(
              tabs: tabs!,
              labelColor: redColor,
              indicatorColor: redColor,
              unselectedLabelColor: greyColor,
              labelStyle: labelStyleMinBlack,
              // indicatorWeight: 4,
            )
          : PreferredSize(
              child: Container(),
              preferredSize: Size.fromHeight(0),
            ),
      leading: (lang == 'en')
          ? Padding(
              padding: EdgeInsets.all(width! * 0.03),
              child: IconButtonWidget(
                icon: (lang == 'ar') ? Icons.arrow_forward : Icons.arrow_back,
                radius: width! * 0.05,
                size: width! * 0.05,
                onpressed: () {
                  back(context);
                },
              ),
            )
          : Container(),
      actions: [
        if ((lang == 'ar'))
          Padding(
            padding: EdgeInsets.all(width! * 0.03),
            child: IconButtonWidget(
              icon: closeIcon!
                  ? Icons.close
                  : (lang == 'ar')
                      ? Icons.arrow_forward
                      : Icons.arrow_back,
              radius: width! * 0.05,
              size: width! * 0.05,
              onpressed: () {
                back(context);
              },
            ),
          )
      ],
    );
  }
}
