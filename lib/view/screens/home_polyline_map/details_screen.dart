import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mohtaref_client/constant.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/view/components_widget/app_bar_widget.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:mohtaref_client/view/components_widget/home_widget/list_tile_details_widget.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';
import 'package:mohtaref_client/view/screens/home/bottom_nav_bar_layout.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var homeCubit = AppCubit.get(context);
            var taskDetailsData = AppCubit.get(context).taskDetailsModel!.data!;

            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(height * 0.1),
                  child: AppBarWidgets(
                    title: "details".tr,
                    width: width,
                    closeIcon: true,
                  )),
              body: ListView(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(currentAddress!),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(homeCubit.destinationAddress!),
                  ),

                  /// logo image
                  Container(
                    width: width,
                    height: height * 0.25,
                    color: greyColor,
                    child: Image.asset(
                      "asset/images/main_logo.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),

                  /// total price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        taskDetailsData.total!,
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
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Center(
                    child: Text(
                      "payment_success_cash".tr,
                      style: thirdLineStyle,
                    ),
                  ),
                  // SizedBox(
                  //   height: height * 0.01,
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: height * 0.01),
                    child: Divider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        timeEstmate!,
                        style: lineStyleSmallBlack,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Center(
                    child: Text(
                      "time".tr,
                      style: labelStyleMinBlack,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: height * 0.01),
                    child: Divider(),
                  ),
                  ListTile(
                    title: Text(
                      "date_time".tr,
                      style: lineStyleSmallBlack,
                    ),
                    trailing: Text(
                      Jiffy(taskDetailsData.createdAt!).yMMMEd,
                      style: lineStyleSmallBlack,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "service_type".tr,
                      style: lineStyleSmallBlack,
                    ),
                    trailing: Text(
                      taskDetailsData.serviceName!,
                      style: lineStyleSmallBlack,
                    ),
                  ),
                  // ListTile(
                  //   title: Text(
                  //     "additional_items".tr,
                  //     style: lineStyleSmallBlack,
                  //   ),
                  //   trailing: Text(
                  //     "additional_items_data",
                  //     style: lineStyleSmallBlack,
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: height * 0.01),
                    child: Divider(),
                  ),

                  ListTileWalletWidget(
                    width: width,
                    height: height * 0.9,
                    title: "task_fares".tr,
                    amount: taskDetailsData.taskFees,
                  ),
                  ListTileWalletWidget(
                    width: width,
                    height: height * 0.9,
                    title: "fees".tr,
                    amount: taskDetailsData.serviceAmount,
                  ),
                  ListTileWalletWidget(
                    width: width,
                    height: height * 0.9,
                    title: "+tax".tr,
                    amount: taskDetailsData.vat,
                  ),
                  ListTileWalletWidget(
                    width: width,
                    height: height * 0.9,
                    title: "items".tr,
                    amount: taskDetailsData.items,
                  ),
                  if (taskDetailsData.couponCode != "")
                    ListTileWalletWidget(
                      width: width,
                      height: height * 0.9,
                      title: "discount".tr,
                      amount: taskDetailsData.coupon,
                    ),
                  ListTileWalletWidget(
                    width: width,
                    height: height * 0.9,
                    title: "top_up_added".tr,
                    amount: taskDetailsData.distance,
                  ),
                  Divider(
                    indent: width * 0.05,
                    endIndent: width * 0.05,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ListTileWalletWidget(
                    width: width,
                    height: height,
                    title: "total_earning".tr,
                    amount: taskDetailsData.total,
                    isTotal: true,
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Center(
                    child: CommonButton(
                        width: width * 0.85,
                        height: height * 0.08,
                        containerColor: redColor,
                        textColor: mainColor,
                        fontSize: width * 0.04,
                        text: "done".tr,
                        onTap: () {
                          homeCubit.googleMapController!.dispose();
                          homeCubit.resetPolyline().then((value) {
                            homeCubit.getProfileData();
                            // homeCubit.currentPage = 1;
                            homeCubit.providersModel!.data!.clear();
                            // homeCubit.providersList!.clear();
                            homeCubit.stopTimer();
                            // homeCubit.getCurrentPosition();

                            // homeCubit.taskCustomerData!.clear();
                            // homeCubit.taskDetails!.clear();
                            // homeCubit.tasksModel = null;
                            // SchedulerBinding.instance!
                            //     .addPostFrameCallback((_) {
                            //   goToAndFinish(context, HomeScreen());
                            // });
                            homeCubit.deleteCacheDir();
                            SchedulerBinding.instance!
                                .addPostFrameCallback((_) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BotomNavBarLayout(),
                                ),
                                (route) => true,
                              );
                            });
                          });
                        }),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            );
          });
    });
  }
}
