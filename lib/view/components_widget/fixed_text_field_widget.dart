import 'package:flutter/material.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';
import '../../constant.dart';

class FixedTextField extends StatelessWidget {
  const FixedTextField({
    Key? key,
    required this.width,
    required this.height,
    this.icon,
    this.iconColor,
    this.hint,
    this.isSearch = false,
    this.onTap,
    this.enabled = true,
    this.radiusValue = 10,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.isBold = false,
  }) : super(key: key);

  final double width;
  final double height;
  final double? radiusValue;
  final IconData? icon;
  final Color? iconColor;
  final String? hint;
  final bool? isSearch;
  final bool isBold;
  final GestureTapCallback? onTap;
  final bool? enabled;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.01),
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.02),
      decoration: BoxDecoration(
        border: Border.all(color: redColor!),
        borderRadius: BorderRadius.circular(radiusValue!),
      ),
      child: Row(
        children: [
          if (!isSearch!)
            Icon(
              icon,
              color: iconColor,
            ),
          SizedBox(
            width: width * 0.02,
          ),
          Expanded(
            child: TextField(
              textInputAction: textInputAction,
              controller: controller,
              minLines: 1,
              maxLines: 3,
              enabled: enabled,
              focusNode: FocusNode(),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: isBold ? styleBlack : smallBlackStyle),
            ),
          ),
          SizedBox(
            width: width * 0.02,
          ),
          if (isSearch!)
            InkWell(
              onTap: onTap,
              child: CircleAvatar(
                  radius: width * 0.05,
                  backgroundColor: redColor,
                  child: Icon(
                    icon,
                    size: width * 0.05,
                    color: iconColor,
                  )),
            ),
        ],
      ),
    );
  }
}
