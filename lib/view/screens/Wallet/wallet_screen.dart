import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mohtaref_client/constant.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:mohtaref_client/view/components_widget/fixed_text_field_widget.dart';
import 'package:mohtaref_client/view/components_widget/list_tile_widget.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/view/screens/Wallet/add_funds_screen.dart';

class WalletScreen extends StatelessWidget {
  final promotionsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        if (state is AddPromotionLoadingState) {
          showLoadingDialog(context);
        }
        if (state is AddPromotionSuccessState) {
          back(context);
        }
        if (state is AddPromotionErrorState) {
          back(context);
        }
      }, builder: (context, state) {
        // var cubit = AppCubit.get(context);
        return Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: ListView(
            physics: BouncingScrollPhysics(),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height / 3,
                padding: EdgeInsets.all(width * 0.05),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.grey,
                        mainColor!,
                        redColor!,
                      ],
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd),
                  borderRadius: BorderRadius.circular(width * 0.02),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "my_wallet".tr,
                      style: styleBlack,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01),
                      child: Text(
                        "$totalWalletAmount" + " " + "sar".tr,
                        style: fourthLineStyle,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Center(
                      child: CommonButton(
                        text: "add_funds".tr,
                        fontSize: width * 0.04,
                        width: width * 0.6,
                        containerColor: buttonColor,
                        textColor: buttonTextColor,
                        onTap: () {
                          goTo(context, AddFundsScreen());
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(width * 0.02),
                child: Divider(),
              ),

              /// Due
              ///
              // Text(
              //   "due".tr,
              //   style: thirdLineStyle,
              // ),
              ListTileWidget(
                title: "due".tr,
                iconData: FontAwesomeIcons.solidMoneyBillAlt,
                width: width,
                height: height,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.01, horizontal: width * 0.04),
                child: Text(
                  "due".tr + " : " + "$totalDueAmount" + " " + "sar".tr,
                  style: lineStyleSmallBlack,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.02),
                child: Divider(),
              ),

              /// Promotions

              // Text(
              //   "promotions".tr,
              //   style: thirdLineStyle,
              // ),
              Divider(
                color: mainColor,
              ),
              ListTileWidget(
                title: "promotions".tr,
                iconData: Icons.local_offer_rounded,
                width: width,
                height: height,
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: CommonButton(
                  text: "add_promotions".tr,
                  fontSize: width * 0.03,
                  width: width * 0.4,
                  height: height * 0.05,
                  containerColor: buttonColor,
                  textColor: buttonTextColor,
                  onTap: () {
                    showAlertDailog(
                        context: context,
                        isContent: true,
                        contentWidget: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FixedTextField(
                                width: width,
                                height: height,
                                controller: promotionsController,
                                textInputAction: TextInputAction.done,
                                hint: "promotions".tr,
                              ),
                              CommonButton(
                                text: "add_promotions".tr,
                                fontSize: width * 0.04,
                                width: width * 0.6,
                                containerColor: buttonColor,
                                textColor: buttonTextColor,
                                onTap: () {
                                  AppCubit.get(context)
                                      .addPromotions(
                                          code: promotionsController.text)
                                      .then((value) {
                                    promotionsController.clear();
                                    back(context);
                                  });
                                },
                              ),
                            ],
                          ),
                        ));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.01),
                child: Divider(),
              ),

              /// Vouchers
              /*     Text(
                    "vouchers".tr,
                    style: thirdLineStyle,
                  ),
                  ListTileWidget(
                    title: "vouchers".tr,
                    iconData: Icons.panorama_horizontal_select,
                    width: width,
                    height: height,
                    onTap: () {},
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: CommonButton(
                      text: "add_vouchers".tr,
                      fontSize: width * 0.03,
                      width: width * 0.4,
                      height: height * 0.05,
                      containerColor: buttonColor,
                      textColor: buttonTextColor,
                      onTap: () {},
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(width * 0.02),
                  //   child: Divider(),
                  // ),*/
            ],
          ),
        );
      });
    });
  }
}
