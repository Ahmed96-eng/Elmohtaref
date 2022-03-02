import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref_client/controller/cubit/Auth_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/Auth_state.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/view/components_widget/app_bar_widget.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';
import 'package:mohtaref_client/view/components_widget/text_form_field_widget.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/view/screens/auth/otp_verification.dart';
import '../../../constant.dart';

class EnterPhoneNumberScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController methodController = TextEditingController();
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
            // appBar: AppBar(),
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
                      "enter_the_phone_number_or_email".tr,
                      style: secondLineStyle,
                    ),
                    Container(
                      height: height * 0.15,
                      child: Row(
                        children: [
                          Image.asset(
                            "asset/images/saudi_flag.png",
                            fit: BoxFit.fill,
                            width: width * 0.15,
                            height: height * 0.1,
                          ),
                          Expanded(
                            child: TextFormFieldWidget(
                              hint: "phone_or_email_hint".tr,
                              controller: methodController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              valdiator: (value) {
                                if (value!.isEmpty) {
                                  return "enter_this_field_please!".tr;
                                }
                                return null;
                              },
                              // isPhone: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      "confirm_terms".tr,
                      textAlign: TextAlign.center,
                      style: lineStyleSmallBlack,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CommonButton(
                      text: "continue".tr,
                      fontSize: width * 0.04,
                      width: width * 0.85,
                      // height: height * 0.05,
                      containerColor: buttonColor,
                      textColor: buttonTextColor,
                      onTap: () {
                        if (!_formKey.currentState!.validate() &&
                            methodController.text.isEmpty) {
                          showFlutterToast(
                              message:
                                  "enter_the_phone_number_or_email_please!".tr);
                        } else
                          showAlertDailog(
                            context: context,
                            labelYes: "send".tr,
                            labelNo: "cancel".tr,
                            message: "otp_message".tr +
                                " " +
                                "${methodController.text}",
                            titlle: "confirm".tr,
                            isContent: false,
                            onPressNo: () {
                              back(context);
                            },
                            onPressYes: (state is SendSMSorEmailLoadingState)
                                ? () {}
                                : () {
                                    AuthCubit.get(context)
                                        .sendSMSorEmail(methodController.text)
                                        .then((value) => goTo(
                                            context,
                                            OtpVerification(
                                              method: methodController.text,
                                            )));
                                  },
                          );
                      },
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
