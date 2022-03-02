import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref_client/controller/cached_helper/cached_helper.dart';
import 'package:mohtaref_client/controller/cached_helper/key_constant.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit/Auth_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/Auth_state.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/view/components_widget/app_bar_widget.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';
import 'package:mohtaref_client/view/components_widget/text_form_field_widget.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/view/screens/auth/enter_phone_number.dart';
import 'package:mohtaref_client/view/screens/home/bottom_nav_bar_layout.dart';
import '../../../constant.dart';

class SignIn extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizeConfig) {
        final height = sizeConfig.screenHeight!;
        final width = sizeConfig.screenWidth!;
        return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          if (state is AutLoginSuccessState) {
            AppCubit.get(context)
                .getProfile(state.authModelModel!.data!.id.toString())
                .then((value) async {
              // CachedHelper.setData(
              //     key: mohtarefClientIdKey,
              //     value: state.authModelModel!.data!.id);

              mohtarefClientId =
                  CachedHelper.getData(key: mohtarefClientIdKey) == null
                      ? state.authModelModel!.data!.id
                      : CachedHelper.getData(key: mohtarefClientIdKey);
              await AppCubit.get(context).getSlider();
              await AppCubit.get(context).getServices();
              await AppCubit.get(context).getContacts();
              await AppCubit.get(context).getOrders();
              goToAndFinish(context, BotomNavBarLayout());
            });
            print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
          }
        }, builder: (context, state) {
          var authCubit = AuthCubit.get(context);
          return Scaffold(
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
                      "sign_in".tr,
                      style: secondLineStyle,
                    ),
                    TextFormFieldWidget(
                      hint: "email_hint".tr,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      valdiator: (value) {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.text);
                        if (value!.isEmpty) {
                          return "enter_this_field_please!".tr;
                        } else if (!value.contains('@')) {
                          return "enter_the_correct_email_please!".tr;
                        } else if (!emailValid) {
                          return "enter_the_correct_email_please!".tr;
                        }
                        return null;
                      },
                    ),
                    TextFormFieldWidget(
                      hint: "password_hint".tr,
                      controller: passwordController,
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
                        } else if (value.length < 6) {
                          return "enter_the_correct_password_please!".tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    CommonButton(
                      text: (state is AuthLoginLoadingState)
                          ? "loading".tr
                          : "sign_in".tr,
                      fontSize: width * 0.04,
                      width: width * 0.85,
                      // height: height * 0.05,
                      containerColor: buttonColor,
                      textColor: buttonTextColor,
                      onTap: (state is AuthLoginLoadingState)
                          ? () {
                              showFlutterToast(
                                  message: "loading".tr,
                                  backgroundColor: darkColor);
                            }
                          : () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              } else {
                                authCubit.logIn(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CommonButton(
                      text: "forgot_password".tr,
                      fontSize: width * 0.04,
                      width: width * 0.85,
                      // containerColor: buttonColor,
                      textColor: buttonColor,
                      onTap: () {
                        goTo(context, EnterPhoneNumberScreen());
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
