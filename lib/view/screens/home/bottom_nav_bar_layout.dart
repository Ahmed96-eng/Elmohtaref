import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/view/components_widget/home_widget/fab_bottom_bar_widget.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/screens/notification_handler_widget.dart';
import '../../../constant.dart';

class BotomNavBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // NotificationHandlerWidget.onMessageConfirmNotification(context);
    // NotificationHandlerWidget.onAppOpenedConfirmNotification(context);
    // NotificationHandlerWidget.onBackGroundConfirmNotification(context);
    NotificationHandlerWidget.onMessagesNotificationCancelTask(context);
    NotificationHandlerWidget.onAppOpenedNotificationCancelTask(context);
    // NotificationHandlerWidget.onBackGroundNotificationCancelTask(context);
    // NotificationHandlerWidget.onMessagesNotification(context);
    // NotificationHandlerWidget.onAppOpenedNotification(context);
    // NotificationHandlerWidget.onBackGroundNotification(context);
    return ResponsiveBuilder(
      builder: (context, sizeConfig) {
        final height = sizeConfig.screenHeight!;
        final width = sizeConfig.screenWidth!;

        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            // AppCubit.get(context).homeModel.data!.length;
            // runs every 1 second

            return WillPopScope(
              onWillPop: () {
                if (AppCubit.get(context).currentIndex == 0) {
                  return showAlertDailog(
                    context: context,
                    isContent: false,
                    titlle: "exit_application".tr,
                    message: "are_you_sure_?".tr,
                    labelNo: "no".tr,
                    labelYes: "yes".tr,
                    onPressNo: () => back(context),
                    onPressYes: () => exit(0),
                  );
                }
                return AppCubit.get(context).willPopScop(context);
              },
              child: Scaffold(
                // backgroundColor: greyColor,
                extendBody: true, extendBodyBehindAppBar: true,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () {},
                //   clipBehavior: Clip.antiAliasWithSaveLayer,
                //   backgroundColor: secondColor,
                //   child: Icon(
                //     Icons.phone_in_talk_outlined,
                //     color: mainColor,
                //   ),
                //   elevation: 1.0,
                // ),

                floatingActionButton: SpeedDial(
                  backgroundColor: secondColor,
                  foregroundColor: mainColor,
                  icon: FontAwesomeIcons.phoneAlt,
                  activeForegroundColor: mainColor,
                  useRotationAnimation: true,
                  children: [
                    if (AppCubit.get(context).contactsModel!.facebook! != "")
                      SpeedDialChild(
                        child: FaIcon(
                          // label: 'FaceBook',
                          FontAwesomeIcons.facebook,
                          color: mainColor,
                        ),
                        backgroundColor: secondColor,
                        onTap: () {
                          // print(AppCubit.get(context).contactsModel!.facebook!);
                          // String faceBookId = "100007367652809";
                          // String faceBookURlAndroid =
                          //     "https://www.facebook.com/profile.php?id=$faceBookId";
                          // String faceBookURLIos = "fb://profile/$faceBookId";
                          String faceBookLink =
                              AppCubit.get(context).contactsModel!.facebook!;
                          openContactUsURL(
                            context,
                            isWhatsApp: false,
                            isFacebook: true,
                            isTelegram: false,
                            isInstegram: false,
                            errorMessage: "open_faild".tr,
                            facebookUrlAndroid: faceBookLink,
                            facebookUrlIos: faceBookLink,
                          );
                        },
                      ),
                    if (AppCubit.get(context).contactsModel!.mobile! != "")
                      SpeedDialChild(
                        // label: 'Phone',
                        child: FaIcon(
                          FontAwesomeIcons.phoneAlt,
                          color: mainColor,
                        ),
                        backgroundColor: secondColor,
                        onTap: () {
                          String phoneNumber =
                              AppCubit.get(context).contactsModel!.mobile!;
                          String phoneAndroid = "tel:$phoneNumber";
                          openContactUsURL(
                            context,
                            isWhatsApp: false,
                            isFacebook: false,
                            isTelegram: false,
                            isInstegram: false,
                            errorMessage: "open_faild".tr,
                            phone: phoneAndroid,
                          );
                        },
                      ),
                    if (AppCubit.get(context).contactsModel!.mobile! != "")
                      SpeedDialChild(
                        // label: 'whatsapp',
                        child: FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: mainColor,
                        ),
                        backgroundColor: secondColor,
                        onTap: () {
                          String whatsapp =
                              AppCubit.get(context).contactsModel!.mobile!;
                          String whatsappURlAndroid =
                              "whatsapp://send?phone=+02$whatsapp";
                          String whatappURLIos = "https://wa.me/+02$whatsapp";
                          openContactUsURL(
                            context,
                            isWhatsApp: true,
                            isFacebook: false,
                            isTelegram: false,
                            isInstegram: false,
                            errorMessage: "open_faild".tr,
                            whatsappUrlIos: whatappURLIos,
                            whatsappUrlAndroid: whatsappURlAndroid,
                          );
                        },
                      ),
                    if (AppCubit.get(context).contactsModel!.instagram! != "")
                      SpeedDialChild(
                        child: FaIcon(
                          FontAwesomeIcons.instagram,
                          color: mainColor,
                        ),
                        backgroundColor: secondColor,
                        onTap: () {
                          String instegramURl =
                              AppCubit.get(context).contactsModel!.instagram!;
                          // String instegramURl =
                          //     "https://www.instagram.com/tawakl/";
                          openContactUsURL(
                            context,
                            isWhatsApp: false,
                            isFacebook: false,
                            isTelegram: false,
                            isInstegram: true,
                            errorMessage: "open_faild".tr,
                            instegramUrlAndroid: instegramURl,
                            instegramUrlIos: instegramURl,
                          );
                        },
                      ),
                    if (AppCubit.get(context).contactsModel!.telegram! != "")
                      SpeedDialChild(
                        child: FaIcon(
                          FontAwesomeIcons.telegramPlane,
                          color: mainColor,
                        ),
                        backgroundColor: secondColor,
                        onTap: () {
                          String telegramUrl =
                              AppCubit.get(context).contactsModel!.telegram!;
                          // String telegramUrl = "https://web.telegram.org/";
                          openContactUsURL(
                            context,
                            isWhatsApp: false,
                            isFacebook: false,
                            isTelegram: true,
                            isInstegram: false,
                            errorMessage: "open_faild".tr,
                            telegramUrlAndroid: telegramUrl,
                            telegramUrlIos: telegramUrl,
                          );
                        },
                      ),
                  ],
                  visible: true,
                ),

                // floatingActionButton: Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: ExpandableFab(
                //     distance: 90.0,
                //     children: [
                //       ActionButton(
                //         onPressed: () {},
                //         icon: const Icon(Icons.format_size),
                //       ),
                //       ActionButton(
                //         onPressed: () {},
                //         icon: const Icon(Icons.insert_photo),
                //       ),
                //       ActionButton(
                //         onPressed: () {},
                //         icon: const Icon(Icons.videocam),
                //       ),
                //     ],
                //   ),
                // ),

                // body: AppCubit.get(context)
                //     .screens[AppCubit.get(context).currentIndex],
/////////////////////////
                body: Stack(children: [
                  constantBackgroundScreens(height, width),
                  AppCubit.get(context)
                      .screens[AppCubit.get(context).currentIndex]
                ]),
                //////////////////
                // bottomNavigationBar: BottomNavigationBar(
                //   enableFeedback: false,
                //   type: BottomNavigationBarType.fixed,
                //   currentIndex: AppCubit.get(context).currentIndex,
                //   onTap: (value) {
                //     if (AppCubit.get(context).currentIndex == 3)
                //       AppCubit.get(context).currentIndex = 2;
                //     else
                //       AppCubit.get(context)
                //           .changeBottomnavBarIndex(value, context);
                //   },
                //   elevation: 5,
                //   showSelectedLabels: false,
                //   showUnselectedLabels: false,
                //   backgroundColor: secondColor,
                //   selectedItemColor: redColor,
                //   unselectedItemColor: mainColor,
                // items: [
                //   BottomNavigationBarItem(
                //     icon: Icon(
                //       Icons.home,
                //       size: height * 0.04,
                //     ),
                //     label: "",
                //   ),
                //   BottomNavigationBarItem(
                //     icon: Icon(
                //       Icons.shopping_basket_outlined,
                //       size: height * 0.04,
                //     ),
                //     label: "",
                //   ),
                //   BottomNavigationBarItem(
                //     icon: Icon(
                //       Icons.person,
                //       size: height * 0.04,
                //     ),
                //     label: "",
                //   ),
                //   BottomNavigationBarItem(
                //     icon: Icon(
                //       Icons.shopping_basket_outlined,
                //       color: Colors.transparent,
                //       size: height * 0.04,
                //     ),
                //     label: "",
                //   ),
                // ],
                // ),

                bottomNavigationBar: FABBottomAppBar(
                  backgroundColor: secondColor,
                  centerItemText: '',
                  color: mainColor,
                  iconSize: width * 0.06,
                  selectedColor: AppCubit.get(context).selectedColor,
                  currentIndex: AppCubit.get(context).currentIndex,
                  notchedShape: CircularNotchedRectangle(),
                  onTabSelected: (index) {
                    AppCubit.get(context)
                        .changeBottomnavBarIndex(index, context);
                  },
                  items: [
                    FABBottomAppBarItem(
                      iconData: FontAwesomeIcons.home,
                      text: '',
                    ),
                    FABBottomAppBarItem(
                        iconData: FontAwesomeIcons.shoppingBag, text: ''),
                    FABBottomAppBarItem(
                        iconData: FontAwesomeIcons.wallet, text: ''),
                    FABBottomAppBarItem(
                        iconData: FontAwesomeIcons.userAlt, text: ''),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
