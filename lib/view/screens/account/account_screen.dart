import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mohtaref_client/constant.dart';
import 'package:mohtaref_client/controller/cached_helper/cached_helper.dart';
import 'package:mohtaref_client/controller/cached_helper/key_constant.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/model/profile_model.dart';
import 'package:mohtaref_client/view/components_widget/account_widget/circle_header_widget.dart';
import 'package:mohtaref_client/view/components_widget/list_tile_widget.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';
import 'package:mohtaref_client/view/screens/account/profile/profile_screen.dart';
import 'package:mohtaref_client/view/screens/account/ratings.dart';
import 'package:mohtaref_client/view/screens/account/settings.dart';
import 'package:mohtaref_client/view/screens/auth/welcome_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var profileData = AppCubit.get(context).profilModel!.data;
            var homeCubit = AppCubit.get(context);

            return Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(
                      height: height * 0.3,
                      width: width, color: Colors.black26,
                      // color: darkColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // InkWell(
                          //   onTap: () {
                          //     goTo(context, WalletScreen());
                          //   },
                          //   child: AccountCircleHeader(
                          //     width: width * 0.18,
                          //     height: height * 0.18,
                          //     image: "asset/images/wallet.png",
                          //     title: "wallet".tr,
                          //   ),
                          // ),
                          CircleHeaderWidget(
                            width: width * 0.3,
                            height: height * 0.3,
                            image: profileData!.profile!,
                            title: profileData.username!,
                            // isStack: true,
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     goTo(context, SummaryScreen());
                          //   },
                          //   child: AccountCircleHeader(
                          //     width: width * 0.18,
                          //     height: height * 0.18,
                          //     image: "asset/images/summary.png",
                          //     title: "summary".tr,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'help'.tr,
                            style: firstLineStyle,
                          ),
                          InkWell(
                            onTap: () {
                              // homeCubit.willPopScop(context);
                              homeCubit.backToCurrentIndex();
                            },
                            child: Icon(
                              Icons.close,
                              color: mainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: height * 0.13,
                  width: width,
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.01, vertical: height * 0.01),
                  // color: mainColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Jiffy(DateTime.now()).MMMMEEEEd,
                        style: lineStyleSmallBlack,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "my_wallet".tr + " : ",
                            style: styleBlack,
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Text(
                            totalWalletAmount.toString(),
                            style: thirdLineStyle,
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Text(
                            "sar".tr,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    children: [
                      // ListTileWidget(
                      //   title: "home".tr,
                      //   iconData: Icons.home,
                      //   width: width,
                      //   height: height,
                      //   onTap: () {
                      //     goTo(context, HomeScreen());
                      //   },
                      // ),
                      ListTileWidget(
                        title: "rating".tr,
                        iconData: Icons.star,
                        width: width,
                        height: height,
                        dividerColor: mainColor,
                        onTap: () {
                          goTo(context, Ratings());
                        },
                      ),
                      ListTileWidget(
                        title: "profile".tr,
                        iconData: Icons.person,
                        width: width,
                        height: height,
                        dividerColor: mainColor,
                        onTap: () {
                          goTo(context, ProfileScreen());
                        },
                      ),

                      ///notification  soon

                      // SwitchListTile(
                      //   title: Text(
                      //     "notification".tr,
                      //     style: lineStyleSmallBlack,
                      //   ),
                      //   secondary: Icon(
                      //     Icons.notifications,
                      //     color: redColor,
                      //   ),
                      //   activeColor: redColor,
                      //   value: homeCubit.notificationToggle,
                      //   onChanged: (bool value) {
                      //     homeCubit.changenotificationToggle(context, value);
                      //     print(value);
                      //   },
                      // ),

                      ListTileWidget(
                        title: "setting".tr,
                        iconData: Icons.settings,
                        width: width,
                        height: height,
                        dividerColor: mainColor,
                        onTap: () {
                          goTo(context, Settings());
                          // goTo(context, CancelTaskScreen());
                        },
                      ),

                      ListTileWidget(
                        title: "logout".tr,
                        iconData: Icons.exit_to_app,
                        width: width,
                        height: height,
                        onTap: () {
                          showAlertDailog(
                            context: context,
                            titlle: "logout".tr,
                            message: "are_you_sure_?".tr,
                            labelNo: "no".tr,
                            labelYes: "yes".tr,
                            isContent: false,
                            onPressNo: () => back(context),
                            onPressYes: () {
                              CachedHelper.removeData(key: loginTokenId)
                                  .then((value) {
                                CachedHelper.removeData(key: walletAmountKey);
                                totalWalletAmount = 0.0;
                                homeCubit.profilModel!.data = ProfileData();
                                CachedHelper.removeData(
                                    key: mohtarefClientIdKey);
                                goToAndFinish(context, WelcomeScreen());
                                homeCubit.backToCurrentIndex();
                                print("object");
                                print(homeCubit.profilModel!.data!.email);
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
    });
  }
}
