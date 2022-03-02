import 'package:flutter/material.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';

import '../../constant.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final IconData? iconData;
  final FormFieldValidator<String>? valdiator;
  final bool? obscurePassword;
  // final bool? isPhone;
  final TextInputType? keyboardType;
  final GestureTapCallback? onTap;
  final TextInputAction textInputAction;

  const TextFormFieldWidget({
    Key? key,
    this.hint,
    this.controller,
    this.iconData,
    this.valdiator,
    this.obscurePassword = false,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.textInputAction = TextInputAction.next,
    // this.isPhone = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          Container(
            height: 100,
            child: Center(
              child: TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                obscureText: obscurePassword!,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  hintText: hint,
                  hintStyle: hintStyleMinBlack,
                  fillColor: Colors.grey[200],
                  labelText: hint,
                  labelStyle: labelStyleMinBlack,
                  // border: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.red),
                  // ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                  ),
                  // border: OutlineInputBorder(
                  //     borderSide: BorderSide(style: BorderStyle.none)),
                  // suffixIcon: Padding(
                  //   padding: EdgeInsets.all(16.0),
                  //   child: InkWell(onTap: onTap, child: Icon(iconData)),
                  // ),
                ),
                validator: valdiator,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: InkWell(
                onTap: onTap,
                child: Icon(
                  iconData,
                  color: buttonColor,
                )),
          )
        ],
      ),
    );
  }
}
