import 'package:flutter/material.dart';
import 'package:mohtaref_client/view/components_widget/icon_button_widget.dart';

import '../../constant.dart';
import 'style.dart';

class ListTileWidget extends StatelessWidget {
  final String? title;
  final IconData? iconData;
  final IconData? updateIcon;
  final GestureTapCallback? onTap;
  final VoidCallback? onIconPressed;
  final double? width;
  final double? height;
  final bool? showImage;
  final bool? showUpdateIcon;
  final bool? showCircleIcon;
  final TextEditingController? controller;
  final Color? dividerColor;
  const ListTileWidget({
    Key? key,
    this.title,
    this.iconData,
    this.onTap,
    this.width,
    this.height,
    this.showImage = false,
    this.updateIcon,
    this.onIconPressed,
    this.showUpdateIcon = false,
    this.controller,
    this.showCircleIcon = false,
    this.dividerColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: showImage! ? width! * 0.6 : width,
        child: Column(
          children: [
            ListTile(
              horizontalTitleGap: 0,
              leading: showCircleIcon!
                  ? CircleAvatar(
                      backgroundColor: thirdColor,
                      radius: width! * 0.08,
                      child: Icon(
                        iconData,
                        color: redColor,
                      ),
                    )
                  : Icon(
                      iconData,
                      color: redColor,
                    ),
              title: Text(
                title!,
                style: lineStyleSmallBlack,
              ),
              trailing: showUpdateIcon!
                  ? IconButtonWidget(
                      icon: updateIcon,
                      circleAvatarColor: thirdColor,
                      size: width! * 0.07,
                      radius: width! * 0.05,
                      iconColor: redColor,
                      onpressed: onIconPressed,
                    )

                  //  IconButton(
                  //     onPressed: onIconPressed,
                  //     icon: Icon(updateIcon),
                  //     color: redColor,
                  //   )
                  : Container(
                      width: width! * 0.00001,
                      height: height! * 0.00001,
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width! * 0.05),
              child: Divider(
                color: dividerColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
