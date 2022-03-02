// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mohtaref_client/constant.dart';
// import 'package:mohtaref_client/controller/cached_helper/cached_helper.dart';
// import 'package:mohtaref_client/controller/cached_helper/key_constant.dart';
// import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
// import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
// import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
// import 'package:mohtaref_client/view/components_widget/cached_network_Image_widget.dart';
// import 'package:mohtaref_client/view/components_widget/list_tile_widget.dart';
// import 'package:mohtaref_client/view/components_widget/navigator.dart';
// import 'package:mohtaref_client/view/components_widget/style.dart';
// import 'package:mohtaref_client/view/screens/account/account_screen.dart';
// import 'package:mohtaref_client/view/screens/account/profile/profile_screen.dart';
// import 'package:mohtaref_client/view/screens/auth/welcome_screen.dart';
// import 'package:get/get.dart';

// class DrawerWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveBuilder(builder: (context, sizeConfig) {
//       final height = sizeConfig.screenHeight!;
//       final width = sizeConfig.screenWidth!;
//       return BlocConsumer<AppCubit, AppState>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             var homeCubit = AppCubit.get(context);
//             var profileData = AppCubit.get(context).profilModel!.data;
//             return Drawer(
//               child: ListView(
//                 children: [
//                   Container(
//                     width: width,
//                     height: height / 3,
//                     color: greyColor,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           radius: width * 0.15,
//                           backgroundColor: thirdColor,
//                           child: ClipOval(
//                             clipBehavior: Clip.antiAliasWithSaveLayer,
//                             child: CachedNetworkImageWidget(
//                               width: width * 0.27,
//                               height: height * 0.15,
//                               borderRadius: BorderRadius.circular(width * .02),
//                               image: profileData!.profile,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: height * 0.02,
//                         ),
//                         Text(
//                           profileData.username!,
//                           style: fourthLineStyle,
//                         ),
//                       ],
//                     ),
//                   ),

//                   ///profile
//                   ListTileWidget(
//                     title: "profile".tr,
//                     iconData: Icons.person,
//                     width: width,
//                     height: height,
//                     onTap: () {
//                       goTo(context, ProfileScreen());
//                     },
//                   ),

//                   ///notification

//                   SwitchListTile(
//                     title: Text(
//                       "notification".tr,
//                       style: lineStyleSmallBlack,
//                     ),
//                     secondary: Icon(
//                       Icons.notifications,
//                       color: redColor,
//                     ),
//                     activeColor: redColor,
//                     value: homeCubit.notificationToggle,
//                     onChanged: (bool value) {
//                       homeCubit.changenotificationToggle(context, value);
//                       print(value);
//                     },
//                   ),

//                   ///about
//                   ListTileWidget(
//                     title: "about".tr,
//                     iconData: Icons.view_headline_outlined,
//                     width: width,
//                     height: height,
//                   ),

//                   ///logout
//                   ListTileWidget(
//                     title: "logout".tr,
//                     iconData: Icons.exit_to_app,
//                     width: width,
//                     height: height,
//                     onTap: () {
//                       CachedHelper.removeData(key: loginTokenId).then((value) {
//                         homeCubit.profilModel = null;
//                         CachedHelper.removeData(key: mohtarefClientIdKey);
//                         goToAndFinish(context, WelcomeScreen());
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             );
//           });
//     });
//   }
// }
