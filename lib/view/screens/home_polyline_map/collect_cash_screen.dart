// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mohtaref_client/constant.dart';
// import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
// import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
// import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
// import 'package:mohtaref_client/view/components_widget/app_bar_widget.dart';
// import 'package:get/get.dart';
// import 'package:mohtaref_client/view/components_widget/common_button.dart';
// import 'package:mohtaref_client/view/components_widget/navigator.dart';
// import 'package:mohtaref_client/view/components_widget/style.dart';
// import 'package:mohtaref_client/view/screens/home_polyline_map/rating_mohtaref.dart';

// class CollectCashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveBuilder(builder: (context, sizeConfig) {
//       final height = sizeConfig.screenHeight!;
//       final width = sizeConfig.screenWidth!;
//       return BlocConsumer<AppCubit, AppState>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             var homeCubit = AppCubit.get(context);
//             return Scaffold(
//               appBar: PreferredSize(
//                   preferredSize: Size.fromHeight(height * 0.1),
//                   child: AppBarWidgets(
//                     title: "service".tr + " " + "#0001",
//                     width: width,
//                   )),
//               body: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // SizedBox(
//                   //   height: height * 0.01,
//                   // ),
//                   Container(
//                     width: width,
//                     height: height * 0.3,
//                     color: mainColor,
//                     margin: EdgeInsets.symmetric(vertical: height * 0.01),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "154.2",
//                               style: thirdLineStyle,
//                             ),
//                             SizedBox(
//                               width: width * 0.01,
//                             ),
//                             Text(
//                               "sar".tr,
//                               textAlign: TextAlign.justify,
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: height * 0.01,
//                         ),
//                         Text(
//                           "collect_cash".tr +
//                               " " +
//                               "${homeCubit.profilModel!.data!.username}",
//                           style: thirdLineStyle,
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: width * 0.1, vertical: height * 0.02),
//                           child: Divider(),
//                         ),
//                         CommonButton(
//                             width: width * 0.85,
//                             height: height * 0.08,
//                             containerColor: mainColor,
//                             textColor: redColor,
//                             text: "more_details".tr,
//                             onTap: () {}),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: height * 0.01),
//                     child: CommonButton(
//                         width: width * 0.85,
//                         height: height * 0.08,
//                         containerColor: redColor,
//                         textColor: mainColor,
//                         text: "done".tr,
//                         onTap: () {
//                           goTo(context, RatingUser());
//                         }),
//                   ),
//                 ],
//               ),
//             );
//           });
//     });
//   }
// }
