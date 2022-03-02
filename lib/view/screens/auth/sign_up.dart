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
import '../../../constant.dart';

class SignUp extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizeConfig) {
        final height = sizeConfig.screenHeight!;
        final width = sizeConfig.screenWidth!;
        return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          if (state is AuthRegisterSuccessState)
            AuthCubit.get(context).startTimer();
          // goToAndFinish(context, SignIn());
        }, builder: (context, state) {
          var authCubit = AuthCubit.get(context);
          addressController.text = AuthCubit.get(context).currentAddress!;
          return Scaffold(
            backgroundColor: mainColor,
            // appBar: AppBar(),
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(height * 0.1),
                child: AppBarWidgets(
                  title: "",
                  width: width,
                )),
            body: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.03),
                    child: ListView(
                      children: [
                        Text(
                          "sign_up".tr,
                          style: secondLineStyle,
                        ),
                        TextFormFieldWidget(
                          hint: "name_hint".tr,
                          controller: userNameController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          valdiator: (value) {
                            if (value!.isEmpty) {
                              return "enter_this_field_please!".tr;
                            }
                            return null;
                          },
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
                                  hint: "phone_hint_1".tr,
                                  controller: phoneController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  // isPhone: true,
                                  valdiator: (value) {
                                    String pattern =
                                        r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$';
                                    RegExp regex = new RegExp(pattern);
                                    if (value!.length == 0) {
                                      return "enter_the_phone_number_please!"
                                          .tr;
                                      // } else if (!regex.hasMatch(value)) {
                                      //   return "enter_the_correct_phone_number_please!"
                                      //       .tr;
                                    } else if (value.isEmpty) {
                                      return "enter_this_field_please!".tr;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextFormFieldWidget(
                          hint: "address_hint".tr,
                          controller: addressController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          valdiator: (value) {
                            if (value!.isEmpty) {
                              return "enter_this_field_please!".tr;
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
                          text: (state is AuthRegisterLoadingState)
                              ? "loading".tr
                              : "continue".tr,
                          fontSize: width * 0.04,
                          width: width * 0.85,
                          // height: height * 0.05,
                          containerColor: buttonColor,
                          textColor: buttonTextColor,
                          onTap: (state is AuthRegisterLoadingState)
                              ? () {}
                              : () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("terms_title".tr),
                                      content: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Text("terms".tr)),
                                      actions: [
                                        CommonButton(
                                            text: "agree".tr,
                                            textColor: buttonColor,
                                            onTap: () {
                                              back(context);

                                              print(emailController.text);
                                              print(userNameController.text);
                                              print(passwordController.text);
                                              print(phoneController.text);
                                              print(addressController.text);
                                              print(deviceToken);

                                              print(authCubit
                                                  .currentPosition!.latitude);
                                              print(authCubit
                                                  .currentPosition!.longitude);
                                              if (!_formKey.currentState!
                                                  .validate()) {
                                                return;
                                              } else {
                                                authCubit.register(
                                                  email: emailController.text,
                                                  username:
                                                      userNameController.text,
                                                  password:
                                                      passwordController.text,
                                                  mobile: phoneController.text,
                                                  location:
                                                      addressController.text,
                                                  lat: (authCubit
                                                          .currentPosition!
                                                          .latitude)
                                                      .toString(),
                                                  long: (authCubit
                                                          .currentPosition!
                                                          .longitude)
                                                      .toString(),
                                                );
                                              }
                                            }),
                                        // CommonButton(
                                        //     text: "no".tr,
                                        //     textColor: buttonColor,
                                        //     onTap: () {
                                        //       back(context);
                                        //     }),
                                      ],
                                    ),
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
                if (AuthCubit.get(context).isTimerStart == true)
                  CustomExitAppAlert(width: width, height: height),
              ],
            ),
          );
        });
      },
    );
  }
}

class CustomExitAppAlert extends StatelessWidget {
  const CustomExitAppAlert({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.withOpacity(0.5),
      child: Center(
        child: Container(
          width: width * 0.8,
          height: height * 0.4,
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.1),
            color: mainColor,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: MediaQuery.of(context).size.width * 0.2,
                  child: Image.asset(
                    "asset/images/main_logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: "app_exit_in".tr,
                      style: labelStyleMinBlack,
                    ),
                    TextSpan(
                        text: (AuthCubit.get(context).start).toString() +
                            " " +
                            "sec".tr,
                        style: fifthLineStyle),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
