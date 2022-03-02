import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/view/components_widget/app_bar_widget.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/components_widget/text_form_field_widget.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/view/screens/home/bottom_nav_bar_layout.dart';
import '../../../constant.dart';

class AddFundsScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final accountNumber = TextEditingController();
  final accountExpiryMonth = TextEditingController();
  final accountExpiryYear = TextEditingController();
  final accountSecurityCode = TextEditingController();
  final fundsAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        if (state is AddFundsErrorState) {
          print("errrrrrrrrrrrrrrrrrror");
          back(context);
          showFlutterToast(
              message: "add_funds_error".tr, backgroundColor: redColor);
        }
        if (state is AddFundsSuccessState) {
          // back(context);
          goTo(context, BotomNavBarLayout());
          // back(context);
        }
        if (state is AddFundsLoadingState) {
          showLoadingDialog(context);
        }
      }, builder: (context, state) {
        // var profileData = AppCubit.get(context).profilModel!.data;
        return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(height * 0.1),
                child: AppBarWidgets(
                  title: "add_funds".tr,
                  width: width,
                )),
            body: Container(
              width: width,
              height: height,
              child: Column(
                children: [
                  Expanded(
                    // flex: 2,
                    child: Form(
                      key: formKey,
                      child: Container(
                        margin: EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.02,
                              ),
                              // Text("add_credit_card".tr),
                              // SizedBox(
                              //   height: height * 0.02,
                              // ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormFieldWidget(
                                      hint: "account_number_hint".tr,
                                      controller: accountNumber,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormFieldWidget(
                                      hint: "security_code_hint".tr,
                                      controller: accountSecurityCode,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormFieldWidget(
                                      hint: "expire_hint_month".tr,
                                      controller: accountExpiryMonth,
                                      keyboardType: TextInputType.datetime,
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormFieldWidget(
                                      hint: "expire_hint_year".tr,
                                      controller: accountExpiryYear,
                                      keyboardType: TextInputType.datetime,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ),
                                ],
                              ),
                              TextFormFieldWidget(
                                hint: "funds_amount".tr,
                                controller: fundsAmount,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  CommonButton(
                      text: "add_credit_card".tr,
                      width: width * 0.85,
                      containerColor: buttonColor,
                      textColor: buttonTextColor,
                      onTap: () {
                        AppCubit.get(context).addFunds(
                          cardNumber: accountNumber.text,
                          cvc: accountSecurityCode.text,
                          expMonth: accountExpiryMonth.text,
                          expYear: accountExpiryYear.text,
                          amount: fundsAmount.text,
                        );

                        // .then((value) => showFlutterToast(
                        //     message: "add_funds".tr,
                        //     backgroundColor: Colors.green));
                      }),
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
