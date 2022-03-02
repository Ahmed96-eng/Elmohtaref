import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/controller/cubit/Auth_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/Auth_state.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/view/components_widget/app_bar_widget.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/components_widget/text_form_field_widget.dart';
import 'package:mohtaref_client/view/screens/auth/sign_in.dart';
import '../../../constant.dart';

class SetNewPassword extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final String? method;
  SetNewPassword({this.method});
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            var authCubit = AuthCubit.get(context);
            return Scaffold(
              backgroundColor: mainColor,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(height * 0.1),
                  child: AppBarWidgets(
                    title: "reset_password".tr,
                    width: width,
                  )),
              body: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(width * 0.03),
                  child: ListView(
                    children: [
                      TextFormFieldWidget(
                        hint: "password_hint".tr,
                        controller: passwordController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        iconData: authCubit.showPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        onTap: () => authCubit.changeshowPassword(context),
                        obscurePassword: authCubit.showPassword,
                        valdiator: (value) {
                          if (value!.isEmpty) {
                            return "enter_this_field_please!".tr;
                          } else if (value.length < 6) {
                            return "enter_the_correct_password_please!".tr;
                          }
                          return null;
                        },
                      ),
                      TextFormFieldWidget(
                        hint: "confirm_hint".tr,
                        controller: confirmPasswordController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        iconData: authCubit.showPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        onTap: () => authCubit.changeshowPassword(context),
                        obscurePassword: authCubit.showPassword,
                        valdiator: (value) {
                          if (value!.isEmpty) {
                            return "enter_this_field_please!".tr;
                          } else if (value != passwordController.text) {
                            return "enter_the_correct_password_please!".tr;
                          } else if (value.length !=
                              passwordController.text.length) {
                            return "enter_the_correct_password_please!".tr;
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CommonButton(
                        text: "reset".tr,
                        fontSize: width * 0.04,
                        width: width * 0.85,
                        // height: height * 0.05,
                        containerColor: buttonColor,
                        textColor: buttonTextColor,
                        onTap: (state is SetNewPasswordLoadingState)
                            ? () {
                                showFlutterToast(
                                    message: "loading".tr,
                                    backgroundColor: darkColor);
                              }
                            : () {
                                print("ddddddddddddd==> $method");
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                } else if (passwordController.text.isEmpty ||
                                    confirmPasswordController.text.isEmpty) {
                                  return showFlutterToast(
                                      message: "enter_this_field_please!".tr,
                                      backgroundColor: darkColor);
                                } else {
                                  authCubit
                                      .setNewPassword(
                                          passwordController.text, method!)
                                      .then((value) =>
                                          goToAndFinish(context, SignIn()));
                                }
                                // showAlertDailog(
                                //   context: context,
                                //   labelYes: "okay".tr,
                                //   labelNo: "".tr,
                                //   message: "reset_message".tr,
                                //   titlle: "thank_you".tr,
                                //   isContent: false,
                                //   onPressNo: () {
                                //     // back(context);
                                //   },
                                //   onPressYes: () {
                                //     if (!_formKey.currentState!.validate()) {
                                //       return;
                                //     } else {
                                //       authCubit
                                //           .setNewPassword(passwordController.text, method!)
                                //           .then((value) => goToAndFinish(context, SignIn()));
                                //     }
                                //   },
                                // );
                              },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}
