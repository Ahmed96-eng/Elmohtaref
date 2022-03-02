import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref_client/controller/cubit/Auth_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/Auth_state.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/view/components_widget/app_bar_widget.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/view/screens/auth/set_new_password.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../constant.dart';

class OtpVerification extends StatelessWidget {
  late final String? method;
  OtpVerification({this.method});

  final GlobalKey _formKey = GlobalKey<FormState>();

  final pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizeConfig) {
        final height = sizeConfig.screenHeight!;
        final width = sizeConfig.screenWidth!;
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {},
          builder: (context, state) => Scaffold(
            backgroundColor: mainColor,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(height * 0.1),
                child: AppBarWidgets(
                  title: "",
                  width: width,
                )),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(width * 0.03),
                child: ListView(
                  children: [
                    Text(
                      "otp_verification".tr,
                      style: secondLineStyle,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      "otp_note".tr,
                      style: lineStyleSmallBlack,
                    ),
                    // SizedBox(
                    //   height: height * 0.02,
                    // ),
                    Row(
                      children: [
                        Text(
                          method!,
                          style: lineStyleSmallBlack,
                        ),
                        CommonButton(
                            text: "edit".tr,
                            width: width * 0.15,
                            textColor: Colors.red,
                            onTap: () {
                              method = "";
                              back(context);
                            })
                      ],
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    PinCodeTextField(
                      appContext: context,
                      length: 4,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        // shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        borderWidth: 0,
                        fieldHeight: 50,
                        fieldWidth: 50,
                        disabledColor: Colors.red,
                        // inactiveColor: mainColor,
                        activeColor: Colors.grey[100],
                        inactiveFillColor: Colors.transparent,
                        activeFillColor: Colors.grey[200],
                        selectedColor: Colors.grey[900],
                        selectedFillColor: Colors.grey[100],
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter_this_field_please!".tr;
                        }

                        return null;
                      },
                      enableActiveFill: true,
                      controller: pinCodeController,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {
                        print(value);
                        // setState(() {
                        //   currentText = value;
                        // });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CommonButton(
                      text: "confirm".tr,
                      fontSize: width * 0.04,
                      width: width * 0.85,
                      // height: height * 0.05,
                      containerColor: buttonColor,
                      textColor: buttonTextColor,
                      onTap: (state is SendOTPLoadingState)
                          ? () {}
                          : () {
                              print("ddddddddddddd==> $method");
                              if (pinCodeController.text.isNotEmpty) {
                                AuthCubit.get(context)
                                    .sendOTP(pinCodeController.text, method!)
                                    .then((value) => goTo(
                                        context,
                                        SetNewPassword(
                                          method: method!,
                                        )));
                              } else {
                                showFlutterToast(
                                    message: "enter_this_field_please!".tr,
                                    backgroundColor: secondColor);
                              }
                            },
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Text(
                      "resend_code".tr + " " + "02:59",
                      textAlign: TextAlign.center,
                      style: lineStyleSmallBlack,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
