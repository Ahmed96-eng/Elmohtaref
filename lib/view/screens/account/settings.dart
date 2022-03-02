import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref_client/controller/cached_helper/cached_helper.dart';
import 'package:mohtaref_client/controller/cached_helper/key_constant.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/controller/language_helper/language_controller.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/model/profile_model.dart';
import 'package:mohtaref_client/view/components_widget/app_bar_widget.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/view/components_widget/list_tile_widget.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';
import 'package:mohtaref_client/view/screens/account/profile/profile_screen.dart';
import 'package:mohtaref_client/view/screens/auth/enter_phone_number.dart';
import 'package:mohtaref_client/view/screens/auth/welcome_screen.dart';

import '../../../constant.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var homeCubit = AppCubit.get(context);
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(height * 0.1),
                  child: AppBarWidgets(
                    title: "setting".tr,
                    width: width,
                    closeIcon: true,
                  )),
              body: ListView(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    height: height * 0.45,
                    child: Column(
                      children: [
                        ListTileWidget(
                          title: "profile".tr,
                          height: height,
                          width: width,
                          iconData: Icons.person_outline,
                          onTap: () {
                            goTo(context, ProfileScreen());
                          },
                        ),

                        /// LanguageController
                        Container(
                          width: width,
                          height: height * 0.1,
                          child: GetBuilder<LanguageController>(
                            init: LanguageController(),
                            builder: (controller) => Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05,
                                  vertical: height * 0.01),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.language,
                                    // size: height * 0.045,
                                    color: redColor,
                                  ),
                                  SizedBox(
                                    width: width * 0.04,
                                  ),
                                  DropdownButton(
                                    underline: SizedBox(),
                                    icon: SizedBox(),
                                    // icon: Icon(
                                    //   Icons.language,
                                    //   size: height * 0.045,
                                    //   color: mainColor,
                                    // ),
                                    items: [
                                      DropdownMenuItem(
                                        child: Text(
                                          "EN".tr,
                                          style: lineStyleSmallBlack,
                                        ),
                                        value: 'en',
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          "AR".tr,
                                          style: lineStyleSmallBlack,
                                        ),
                                        value: 'ar',
                                      ),
                                    ],
                                    value: controller.localLanguage,
                                    onChanged: (String? value) {
                                      controller.localLanguage = value!;
                                      CachedHelper.setData(
                                          key: languageKey, value: value);
                                      print(CachedHelper.getData(
                                          key: languageKey));
                                      controller.toggleLanguge(value);
                                      Get.updateLocale(Locale(value));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        ListTileWidget(
                          title: "change_password".tr,
                          height: height,
                          width: width,
                          iconData: Icons.change_circle_outlined,
                          onTap: () {
                            goTo(context, EnterPhoneNumberScreen());
                          },
                        ),
                        // AccountWidget(
                        //   title: "my_earning".tr,
                        //   height: height,
                        //   width: width,
                        //   iconData: Icons.attach_money,
                        //   onTap: () {
                        //     goTo(context, WalletScreen());
                        //   },
                        // ),
                        // AccountWidget(
                        //   title: "summary".tr,
                        //   height: height,
                        //   width: width,
                        //   iconData: Icons.summarize_outlined,
                        //   onTap: () {
                        //     goTo(context, SummaryScreen());
                        //   },
                        // ),
                        ListTileWidget(
                          title: "delete_account".tr,
                          height: height,
                          width: width,
                          iconData: Icons.person_off_outlined,
                          onTap: () {
                            showAlertDailog(
                                context: context,
                                isContent: false,
                                labelYes: "delete_account".tr,
                                labelNo: "cancel".tr,
                                titlle: "are_you_sure_?".tr,
                                message: "delete_account_message".tr,
                                onPressNo: () {
                                  back(context);
                                },
                                onPressYes: () {
                                  print("object");

                                  AppCubit.get(context)
                                      .deleteAccount()
                                      .then((value) {
                                    homeCubit.deleteCacheDir();
                                    CachedHelper.removeData(key: loginTokenId);
                                    CachedHelper.removeData(
                                        key: walletAmountKey);
                                    totalWalletAmount = 0.0;
                                    homeCubit.profilModel!.data = ProfileData();
                                    CachedHelper.removeData(
                                        key: mohtarefClientIdKey);
                                    SchedulerBinding.instance!
                                        .addPostFrameCallback((_) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              WelcomeScreen(),
                                        ),
                                        (route) => true,
                                      );
                                    });
                                  });
                                  homeCubit.backToCurrentIndex();
                                  back(context);
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03,
                    ),
                    child: Text(
                      "help".tr,
                      style: thirdLineStyle,
                    ),
                  ),
                  Container(
                    height: height * 0.45,
                    child: Column(
                      children: [
                        ListTileWidget(
                          title: "terms_condition".tr,
                          height: height,
                          width: width,
                          iconData: Icons.article_outlined,
                        ),
                        ListTileWidget(
                          title: "privacy".tr,
                          height: height,
                          width: width,
                          iconData: Icons.article_outlined,
                        ),
                        ListTileWidget(
                          title: "about".tr,
                          height: height,
                          width: width,
                          iconData: Icons.article_outlined,
                        ),
                        // ListTileWidget(
                        //   title: "contact_us".tr,
                        //   height: height,
                        //   width: width,
                        //   iconData: Icons.perm_phone_msg_outlined,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}
