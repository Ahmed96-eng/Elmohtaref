import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref_client/controller/cubit/Auth_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/Auth_state.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/screens/auth/sign_in.dart';
import 'package:mohtaref_client/view/screens/auth/sign_up.dart';
import '../../../constant.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizeConfig) {
        final height = sizeConfig.screenHeight!;
        final width = sizeConfig.screenWidth!;
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {},
          builder: (context, state) => Scaffold(
            // backgroundColor: Colors.grey.withOpacity(0.6),
            body: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("asset/images/splash_logo.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: MediaQuery.of(context).size.width / 3,
                      child: Image.asset(
                        "asset/images/main_logo.png",
                        fit: BoxFit.cover,
                        // width: 500,
                        // height: 800,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    CommonButton(
                      text: "sign_in".tr,
                      fontSize: width * 0.05,
                      width: width * 0.85,
                      containerColor: buttonColor,
                      textColor: buttonTextColor,
                      onTap: () {
                        goTo(context, SignIn());
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CommonButton(
                      text: "sign_up".tr,
                      fontSize: width * 0.05,
                      width: width * 0.85,
                      // containerColor: buttonColor,
                      textColor: buttonTextColor,
                      onTap: () {
                        AuthCubit.get(context).getCurrentPosition().then(
                              (value) => AuthCubit.get(context)
                                  .getAddressFromLatLng()
                                  .then(
                                (value) {
                                  goTo(context, SignUp());
                                },
                              ),
                            );
                      },
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
