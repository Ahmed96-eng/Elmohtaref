import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mohtaref_client/constant.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/model/providers_model.dart';
import 'package:mohtaref_client/view/components_widget/cached_network_Image_widget.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:mohtaref_client/view/components_widget/fixed_text_field_widget.dart';
import 'package:mohtaref_client/view/components_widget/icon_button_widget.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';
import 'package:mohtaref_client/view/screens/home_polyline_map/rating_mohtaref.dart';
import 'package:mohtaref_client/view/screens/notification_handler_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import 'cancel_task_screen.dart';

class ArrivedScreen extends StatefulWidget {
  // final String? providerReciverId;
  final String? taskId;
  final ProvidersModelData? providersModelData;
  ArrivedScreen({
    // this.providerReciverId,
    this.taskId,
    this.providersModelData,
  });

  @override
  _ArrivedScreenState createState() => _ArrivedScreenState();
}

class _ArrivedScreenState extends State<ArrivedScreen> {
  @override
  void initState() {
    super.initState();
    var cubit = AppCubit.get(context);
    setState(() {
      cubit.orginMarker();

      cubit.destinationMarker(
        destLatitude: double.parse(widget.providersModelData!.lat!),
        destLongitude: double.parse(widget.providersModelData!.long!),
      );
      print("zzzzzzzzzzzzzz--->${widget.providersModelData!.lat!}");
      print("zzzzzzzzzzzzzz--->${widget.providersModelData!.long!}");
    });
    cubit.getPolyline(
      double.parse(widget.providersModelData!.lat!),
      double.parse(widget.providersModelData!.long!),
    );
  }

  @override
  Widget build(BuildContext context) {
    NotificationHandlerWidget.onMessageConfirmNotification(context);
    NotificationHandlerWidget.onAppOpenedConfirmNotification(context);
    // NotificationHandlerWidget.onBackGroundConfirmNotification(context);
    NotificationHandlerWidget.onMessagesNotificationCancelTask(context);
    NotificationHandlerWidget.onAppOpenedNotificationCancelTask(context);
    // NotificationHandlerWidget.onBackGroundNotificationCancelTask(context);
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        if (state is PaymentsLoadingState) showLoadingDialog(context);
        if (state is PaymentsSuccessState) back(context);
        if (state is PaymentsErrorState) back(context);
      }, builder: (context, state) {
        var homeCubit = AppCubit.get(context);
        String twoDigit(int numDigit) => numDigit.toString().padLeft(2, '0');
        final second = twoDigit(homeCubit.duration.inSeconds.remainder(60));
        final minutes = twoDigit(homeCubit.duration.inMinutes.remainder(60));

        final hours = twoDigit(homeCubit.duration.inHours);
        return WillPopScope(
          onWillPop: () async {
            showFlutterToast(message: "no_back".tr, backgroundColor: redColor);
            return false;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              // alignment: AlignmentDirectional.bottomCenter,
              children: [
                /// MAP
                GoogleMap(
                  padding: EdgeInsets.only(
                      bottom: height * 0.35, top: height * 0.15),
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  initialCameraPosition: homeCubit.kGooglePlex,
                  onMapCreated: homeCubit.onMapCreated,
                  markers: Set<Marker>.of(homeCubit.markers.values),
                  polylines: Set<Polyline>.of(homeCubit.polylines.values),
                ),

                Container(
                  height: height * 0.7,
                  width: width,
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: height * 0.1),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(width * 0.05)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: IconButtonWidget(
                          circleAvatarColor: mainColor,
                          radius: width * 0.1,
                          icon: Icons.close,
                          size: width * 0.08,
                          borderColor: redColor,
                          onpressed: () {
                            homeCubit.changeCancelTaskExpand(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.05),
                        child: Text(
                          "$second : $minutes : $hours",
                          style: secondLineStyle,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Container(
                          width: width,
                          height: height * 0.3,
                          color: mainColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ListTile(
                                contentPadding:
                                    EdgeInsets.only(top: height * 0.01),
                                leading: IconButton(
                                  icon: Icon(Icons.phone),
                                  onPressed: () async {
                                    String phoneNumber =
                                        widget.providersModelData!.mobile!;

                                    await canLaunch("tel:$phoneNumber")
                                        ? launch("tel:$phoneNumber")
                                        : showFlutterToast(
                                            message: "call_faild".tr);
                                  },
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(widget.providersModelData!.time!),
                                    ClipOval(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: CachedNetworkImageWidget(
                                        width: width * 0.15,
                                        height: height * 0.08,
                                        borderRadius:
                                            BorderRadius.circular(width * .02),
                                        image:
                                            widget.providersModelData!.profile!,
                                      ),
                                    ),
                                    Text(widget.providersModelData!.distance!),
                                  ],
                                ),
                                // subtitle: Text("arrived_jone"),
                              ),
                              Text(
                                "tech".tr +
                                    " " +
                                    "${widget.providersModelData!.userName!}" +
                                    " " +
                                    "arrived".tr,
                                style: labelStyleMinBlack,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02),
                                child: Divider(),
                              ),
                              // CommonButton(
                              //     width: width * 0.85,
                              //     height: height * 0.08,
                              //     containerColor: redColor,
                              //     textColor: mainColor,
                              //     text: "complete".tr,
                              //     onTap: () {
                              //       homeCubit.polylineCoordinates.clear();
                              //       homeCubit.markers.clear();
                              //       homeCubit.polylines.clear();
                              //       homeCubit.stopTimer();
                              //       showAlertDailog(
                              //           isContent: true,
                              //           context: context,
                              //           labelNo: "cancel".tr,
                              //           labelYes: "done".tr,
                              //           titlle: "confirm_fees".tr,
                              //           contentWidget: SingleChildScrollView(
                              //             child: Column(
                              //               mainAxisSize: MainAxisSize.min,
                              //               children: [
                              //                 // TextFormFieldWidget(
                              //                 //   hint:
                              //                 //       "please_enter_fees_amount"
                              //                 //           .tr,
                              //                 //   keyboardType:
                              //                 //       TextInputType.number,
                              //                 //   textInputAction:
                              //                 //       TextInputAction.next,
                              //                 // ),
                              //                 // TextFormFieldWidget(
                              //                 //   hint:
                              //                 //       "please_buy_items_amount"
                              //                 //           .tr,
                              //                 //   keyboardType:
                              //                 //       TextInputType.number,
                              //                 //   textInputAction:
                              //                 //       TextInputAction.done,
                              //                 // ),

                              //                 FixedTextField(
                              //                   width: width,
                              //                   height: height,
                              //                   radiusValue: width * 0.1,
                              //                   hint: "fees".tr +
                              //                       " " +
                              //                       " : " +
                              //                       "sar".tr,
                              //                   icon: Icons.paid_rounded,
                              //                   iconColor: redColor,
                              //                   enabled: false,
                              //                 ),
                              //                 FixedTextField(
                              //                   width: width,
                              //                   height: height,
                              //                   radiusValue: width * 0.1,
                              //                   hint: "items".tr +
                              //                       " " +
                              //                       " : " +
                              //                       "sar".tr,
                              //                   icon: Icons.paid_rounded,
                              //                   iconColor: redColor,
                              //                   enabled: false,
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //           onPressNo: () {
                              //             back(context);
                              //           },
                              //           onPressYes: () {
                              //             homeCubit.deleteMessages(
                              //                 providerReciverId!);
                              //             // homeCubit.stopTimer();
                              //             print("fffffffffffffffff" +
                              //                 " " +
                              //                 "sec : $second" +
                              //                 " " +
                              //                 "min : $minutes" +
                              //                 " " +
                              //                 "hour : $hours");
                              //             print("fffffffffffffffff" +
                              //                 " " +
                              //                 "$hours" +
                              //                 ":" +
                              //                 "$minutes" +
                              //                 ":" +
                              //                 "$second");
                              //             timeEstmate = (hours == "00")
                              //                 ? "$minutes " + "mins".tr
                              //                 : "$hours " +
                              //                     "hrs".tr +
                              //                     " , " +
                              //                     "$minutes " +
                              //                     "mins".tr;
                              //             goTo(context, RatingUser());
                              //           });
                              //     }),

                              SizedBox(
                                height: height * 0.01,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (homeCubit.cancelTaskExpand == true)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      width: width,
                      height: height * 0.35,
                      color: mainColor,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.05,
                                vertical: height * 0.02),
                            child: Text(
                              "cancel_task".tr,
                              style: labelStyleMinBlack,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.05,
                                vertical: height * 0.01),
                            child: Divider(),
                          ),
                          CommonButton(
                              width: width * 0.85,
                              height: height * 0.08,
                              containerColor: redColor,
                              textColor: mainColor,
                              text: "yes".tr,
                              onTap: () {
                                homeCubit.resetPolyline();
                                homeCubit.googleMapController!.dispose();
                                homeCubit.stopTimer();
                                // homeCubit.currentPage = 1;
                                homeCubit.providersModel!.data!.clear();
                                // homeCubit.providersList!.clear();
                                homeCubit.deleteMessages(
                                    widget.providersModelData!.id!);
                                homeCubit.deleteCacheDir();
                                homeCubit
                                    .cancelTask(
                                      taskId: widget.taskId,
                                      mohtarefId: widget.providersModelData!.id,
                                    )
                                    .then((value) => goTo(
                                        context,
                                        CancelTaskScreen(
                                          taskid: widget.taskId,
                                        )));
                              }),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          CommonButton(
                              width: width * 0.85,
                              height: height * 0.08,
                              containerColor: mainColor,
                              borderColor: redColor,
                              textColor: redColor,
                              text: "no".tr,
                              onTap: () {
                                homeCubit.changeCancelTaskExpand(context);
                              }),
                          SizedBox(
                            height: height * 0.01,
                          ),
                        ],
                      ),
                    ),
                  ),
                // if (homeCubit.storesExpand == true)
                //   Positioned(
                //     bottom: 0,
                //     right: 0,
                //     left: 0,
                //     child: Container(
                //       width: width,
                //       height: height,
                //       color: Colors.grey.withOpacity(0.9),
                //       child: Column(
                //         children: [
                //           SizedBox(
                //             height: height * 0.03,
                //           ),
                //           Expanded(
                //               child: ListView.separated(
                //             padding: EdgeInsets.symmetric(
                //                 vertical: height * 0.03,
                //                 horizontal: width * 0.03),
                //             physics: BouncingScrollPhysics(),
                //             itemBuilder: (context, index) {
                //               return Container(
                //                 // margin: EdgeInsets.symmetric(
                //                 //     vertical: height * 0.03,
                //                 //     horizontal: width * 0.03),
                //                 width: width,
                //                 height: height * 0.18,
                //                 decoration: BoxDecoration(
                //                     color: mainColor,
                //                     borderRadius: BorderRadius.only(
                //                       topLeft: Radius.circular(width * 0.1),
                //                     )),

                //                 child: Column(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: [
                //                     ListTile(
                //                       contentPadding:
                //                           EdgeInsets.only(top: height * 0.01),
                //                       leading: IconButton(
                //                         icon: Icon(Icons.phone),
                //                         onPressed: () async {
                //                           String phoneNumber = '0114919223';
                //                           // another solution
                //                           // String phoneNumber = Uri.encodeComponent('0114919223');
                //                           await canLaunch("tel:$phoneNumber")
                //                               ? launch("tel:$phoneNumber")
                //                               : showFlutterToast(
                //                                   message: "call_faild".tr);
                //                         },
                //                       ),
                //                       title: Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceAround,
                //                         children: [
                //                           Text("2 min"),
                //                           CircleAvatar(
                //                             radius: width * 0.08,
                //                           ),
                //                           Text("0.5 mi"),
                //                         ],
                //                       ),
                //                       // subtitle: Text("arrived_jone"),
                //                     ),
                //                     // SizedBox(
                //                     //   height: height * 0.015,
                //                     // ),
                //                     // Text("store name"),
                //                   ],
                //                 ),
                //               );
                //             },
                //             separatorBuilder: (context, index) => SizedBox(
                //               height: height * 0.05,
                //             ),
                //             itemCount: 10,
                //           )),
                //           SizedBox(
                //             height: height * 0.03,
                //           ),
                //           CommonButton(
                //               width: width * 0.85,
                //               height: height * 0.08,
                //               containerColor: mainColor,
                //               borderColor: redColor,
                //               textColor: redColor,
                //               text: "back".tr,
                //               onTap: () {
                //                 homeCubit.changeStoresExpand(context);
                //               }),
                //           SizedBox(
                //             height: height * 0.02,
                //           ),
                //         ],
                //       ),
                //     ),
                //   )

                /// Notification Alert

                if (confirmBody!.contains("confirm_pay"))
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                      height: height * 0.8,
                      width: width,
                      color: mainColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "pay_confirm".tr,
                            style: secondLineStyle,
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          FixedTextField(
                            width: width,
                            height: height,
                            isBold: true,
                            radiusValue: width * 0.1,
                            hint: "fees".tr +
                                " " +
                                " : " +
                                feesAmount! +
                                "sar".tr,
                            icon: Icons.paid_rounded,
                            iconColor: redColor,
                            enabled: false,
                          ),
                          FixedTextField(
                            width: width,
                            height: height,
                            isBold: true,
                            radiusValue: width * 0.1,
                            hint: "items".tr +
                                " " +
                                " : " +
                                sparesAmount! +
                                "sar".tr,
                            icon: Icons.paid_rounded,
                            iconColor: redColor,
                            enabled: false,
                          ),
                          FixedTextField(
                            width: width,
                            height: height,
                            isBold: true,
                            radiusValue: width * 0.1,
                            hint: "total".tr +
                                " " +
                                " : " +
                                totalAmount! +
                                "sar".tr,
                            icon: Icons.paid_rounded,
                            iconColor: redColor,
                            enabled: false,
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CommonButton(
                                height: height * 0.08,
                                width: width * 0.45,
                                fontSize: width * 0.04,
                                text: "cash".tr,
                                textColor: mainColor,
                                containerColor: redColor,
                                onTap: () {
                                  homeCubit.deleteMessages(
                                      widget.providersModelData!.id!);
                                  // homeCubit.stopTimer();
                                  // print("fffffffffffffffff" +
                                  //     " " +
                                  //     "sec : $second" +
                                  //     " " +
                                  //     "min : $minutes" +
                                  //     " " +
                                  //     "hour : $hours");
                                  // print("fffffffffffffffff" +
                                  //     " " +
                                  //     "$hours" +
                                  //     ":" +
                                  //     "$minutes" +
                                  //     ":" +
                                  //     "$second");
                                  timeEstmate = (hours == "00")
                                      ? "$minutes " + "mins".tr
                                      : "$hours " +
                                          "hrs".tr +
                                          " , " +
                                          "$minutes " +
                                          "mins".tr;

                                  homeCubit
                                      .payment(
                                          taskId: widget.taskId!,
                                          paymentMethod: "cash",
                                          total: totalAmount.toString(),
                                          staffId:
                                              widget.providersModelData!.id!)
                                      .then((value) {
                                    confirmBody = "";
                                    homeCubit.getProfileData();
                                    homeCubit
                                        .getTaskDetails(widget.taskId)
                                        .then((value) => goTo(
                                            context,
                                            RatingUser(
                                              providersModelData:
                                                  widget.providersModelData!,
                                            )));
                                  });
                                },
                              ),
                              CommonButton(
                                height: height * 0.08,
                                width: width * 0.45,
                                fontSize: width * 0.04,
                                text: "wallet".tr,
                                textColor: mainColor,
                                containerColor: redColor,
                                onTap: () {
                                  homeCubit.deleteMessages(
                                      widget.providersModelData!.id!);

                                  timeEstmate = (hours == "00")
                                      ? "$minutes " + "mins".tr
                                      : "$hours " +
                                          "hrs".tr +
                                          " , " +
                                          "$minutes " +
                                          "mins".tr;
                                  if (totalWalletAmount == 0.0) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => WillPopScope(
                                        onWillPop: () async {
                                          showFlutterToast(
                                              message: "no_back".tr,
                                              backgroundColor: redColor);
                                          return false;
                                        },
                                        child: AlertDialog(
                                          title: Text(
                                            "attention".tr,
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "empty_wallet".tr,
                                                textAlign: TextAlign.center,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: CommonButton(
                                                        text: "cash".tr,
                                                        width: width * 0.35,
                                                        height: height * 0.08,
                                                        fontSize: width * 0.04,
                                                        textColor: mainColor,
                                                        containerColor:
                                                            redColor,
                                                        onTap: () {
                                                          homeCubit
                                                              .payment(
                                                                  taskId: widget
                                                                      .taskId!,
                                                                  paymentMethod:
                                                                      "cash",
                                                                  total: totalAmount
                                                                      .toString(),
                                                                  staffId: widget
                                                                      .providersModelData!
                                                                      .id!)
                                                              .then((value) {
                                                            confirmBody = "";
                                                            homeCubit
                                                                .getProfileData();
                                                            homeCubit
                                                                .getTaskDetails(
                                                                    widget
                                                                        .taskId)
                                                                .then((value) =>
                                                                    goTo(
                                                                        context,
                                                                        RatingUser(
                                                                          providersModelData:
                                                                              widget.providersModelData!,
                                                                        )));
                                                          });
                                                        }),
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.05,
                                                  ),
                                                  Expanded(
                                                    child: CommonButton(
                                                        text: "cancel".tr,
                                                        width: width * 0.35,
                                                        height: height * 0.08,
                                                        fontSize: width * 0.04,
                                                        textColor: mainColor,
                                                        containerColor:
                                                            redColor,
                                                        onTap: () {
                                                          showAlertDailog(
                                                            context: context,
                                                            labelNo: "no".tr,
                                                            labelYes: "done".tr,
                                                            isContent: false,
                                                            titlle:
                                                                "are_you_sure_?"
                                                                    .tr,
                                                            message:
                                                                "cancel_payment_message"
                                                                    .tr,
                                                            onPressNo: () {
                                                              back(context);
                                                            },
                                                            onPressYes: () {
                                                              homeCubit
                                                                  .googleMapController!
                                                                  .dispose();
                                                              homeCubit
                                                                  .providersModel!
                                                                  .data!
                                                                  .clear();
                                                              homeCubit
                                                                  .deleteCacheDir();
                                                              homeCubit
                                                                  .deleteMessages(
                                                                      widget
                                                                          .providersModelData!
                                                                          .id!);
                                                              homeCubit
                                                                  .cancelPayment(
                                                                      taskId: widget
                                                                          .taskId!,
                                                                      due: totalAmount
                                                                          .toString(),
                                                                      staffId: widget
                                                                          .providersModelData!
                                                                          .id!)
                                                                  .then(
                                                                    (value) => [
                                                                      goToAndFinish(
                                                                          context,
                                                                          CancelTaskScreen(
                                                                            taskid:
                                                                                widget.taskId,
                                                                          )),
                                                                      homeCubit
                                                                          .getProfileData(),
                                                                      confirmBody =
                                                                          "",
                                                                      print(
                                                                          "CANCEL PAYMENT"),
                                                                    ],
                                                                  );
                                                            },
                                                          );
                                                        }),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                    // showFlutterToast(
                                    //     message: "empty_wallet".tr,
                                    //     backgroundColor: redColor);

                                  } else {
                                    homeCubit
                                        .payment(
                                            taskId: widget.taskId!,
                                            paymentMethod: "wallet",
                                            total: totalAmount.toString(),
                                            staffId:
                                                widget.providersModelData!.id!)
                                        .then(
                                      (value) {
                                        confirmBody = "";
                                        homeCubit.getProfileData();
                                        homeCubit
                                            .getTaskDetails(widget.taskId)
                                            .then((value) => goTo(
                                                context,
                                                RatingUser(
                                                  providersModelData: widget
                                                      .providersModelData!,
                                                )));
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CommonButton(
                              height: height * 0.08,
                              width: width * 0.8,
                              fontSize: width * 0.04,
                              text: "cancel".tr,
                              textColor: mainColor,
                              containerColor: redColor,
                              onTap: () {
                                // confirmBody = "";
                                // back(context);
                                showAlertDailog(
                                  context: context,
                                  labelNo: "no".tr,
                                  labelYes: "done".tr,
                                  isContent: false,
                                  titlle: "are_you_sure_?".tr,
                                  message: "cancel_payment_message".tr,
                                  onPressNo: () {
                                    back(context);
                                  },
                                  onPressYes: () {
                                    homeCubit.googleMapController!.dispose();
                                    homeCubit.providersModel!.data!.clear();
                                    homeCubit.deleteCacheDir();
                                    homeCubit.deleteMessages(
                                        widget.providersModelData!.id!);
                                    homeCubit
                                        .cancelPayment(
                                            taskId: widget.taskId!,
                                            due: totalAmount.toString(),
                                            staffId:
                                                widget.providersModelData!.id!)
                                        .then(
                                          (value) => [
                                            goToAndFinish(
                                                context,
                                                CancelTaskScreen(
                                                  taskid: widget.taskId,
                                                )),
                                            homeCubit.getProfileData(),
                                            confirmBody = "",
                                            print("CANCEL PAYMENT"),
                                          ],
                                        );
                                  },
                                );
                              }),
                        ],
                      ),
                    ),
                  )
                // showAlertDailog(
                //     isContent: true,
                //     context: context,
                //     labelNo: "cancel".tr,
                //     labelYes: "done".tr,
                //     titlle: "confirm_fees".tr,
                // contentWidget: SingleChildScrollView(
                //   child: Column(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       FixedTextField(
                //         width: width,
                //         height: height,
                //         radiusValue: width * 0.1,
                //         hint: "fees".tr +
                //             " " +
                //             " : " +
                //             totalAmount! +
                //             "sar".tr,
                //         icon: Icons.paid_rounded,
                //         iconColor: redColor,
                //         enabled: false,
                //       ),
                //       FixedTextField(
                //         width: width,
                //         height: height,
                //         radiusValue: width * 0.1,
                //         hint: "items".tr +
                //             " " +
                //             " : " +
                //             sparesAmount! +
                //             "sar".tr,
                //         icon: Icons.paid_rounded,
                //         iconColor: redColor,
                //         enabled: false,
                //       ),
                //     ],
                //   ),
                // ),
                //     onPressNo: () {
                //       back(context);
                //     },
                //     onPressYes: () {
                // homeCubit.deleteMessages(providerReciverId!);
                // // homeCubit.stopTimer();
                // print("fffffffffffffffff" +
                //     " " +
                //     "sec : $second" +
                //     " " +
                //     "min : $minutes" +
                //     " " +
                //     "hour : $hours");
                // print("fffffffffffffffff" +
                //     " " +
                //     "$hours" +
                //     ":" +
                //     "$minutes" +
                //     ":" +
                //     "$second");
                // timeEstmate = (hours == "00")
                //     ? "$minutes " + "mins".tr
                //     : "$hours " +
                //         "hrs".tr +
                //         " , " +
                //         "$minutes " +
                //         "mins".tr;
                // goTo(context, RatingUser());
                //     }),
              ],
            ),
          ),
        );
      });
    });
  }
}
