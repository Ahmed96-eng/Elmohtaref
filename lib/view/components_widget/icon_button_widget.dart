import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onpressed;
  final double? radius;
  final double? size;
  final Color? borderColor;
  final Color? iconColor;
  final Color? circleAvatarColor;

  const IconButtonWidget({
    Key? key,
    this.icon,
    this.onpressed,
    this.radius,
    this.size,
    this.borderColor = Colors.transparent,
    this.circleAvatarColor = Colors.white,
    this.iconColor = Colors.black,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor!),
        ),
        child: CircleAvatar(
            radius: radius,
            backgroundColor: circleAvatarColor,
            child: Icon(
              icon,
              size: size,
              color: iconColor,
            )),
      ),
    );
  }
}
