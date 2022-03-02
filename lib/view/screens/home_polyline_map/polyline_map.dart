import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mohtaref_client/constant.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/model/providers_model.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/view/components_widget/fixed_text_field_widget.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';
import 'package:mohtaref_client/view/screens/chat/chat_screen.dart';
import 'package:mohtaref_client/view/screens/home_polyline_map/arrived_screen.dart';
import 'package:mohtaref_client/view/screens/home_polyline_map/cancel_task_screen.dart';
import 'package:mohtaref_client/view/screens/notification_handler_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PolyLineMapScreen extends StatefulWidget {
  final ProvidersModelData? providersModelData;

  const PolyLineMapScreen({this.providersModelData});

  @override
  _PolyLineMapScreenState createState() => _PolyLineMapScreenState();
}

class _PolyLineMapScreenState extends State<PolyLineMapScreen> {
  final titleComplaintController = TextEditingController();
  final descriptionComplaintController = TextEditingController();
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
    // print("cccccccccccccccccc---> ${widget.customerData!.email!}");
    NotificationHandlerWidget.onMessagesNotificationCancelTask(context);
    NotificationHandlerWidget.onAppOpenedNotificationCancelTask(context);
    NotificationHandlerWidget.onBackGroundNotificationCancelTask(context);
    NotificationHandlerWidget.onMessagesArriveNotificationFromMohtaref(context);
    NotificationHandlerWidget.onAppOpenedArriveNotificationFromMohtaref(
        context);
    NotificationHandlerWidget.onBackGroundArriveNotificationFromMohtaref(
        context);
    print("nnnnnnnnnnn---------->${arriveNotification!}");
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var homeCubit = AppCubit.get(context);
            return WillPopScope(
              onWillPop: () async {
                showFlutterToast(
                    message: "no_back".tr, backgroundColor: redColor);
                return false;
              },
              child: Scaffold(
                body: Stack(
                  alignment: AlignmentDirectional.topCenter,
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
                      // trafficEnabled: true,
                      initialCameraPosition: homeCubit.kGooglePlex,
                      // initialCameraPosition: CameraPosition(
                      //   target: LatLng(currentPosition!.latitude,
                      //       currentPosition!.longitude),
                      // ),
                      onMapCreated: homeCubit.onMapCreated,
                      // onMapCreated: (GoogleMapController controller) {
                      //   homeCubit.mapController.complete(controller);
                      //   // homeCubit.getCurrentPosition();
                      // },
                      markers: Set<Marker>.of(homeCubit.markers.values),
                      polylines: Set<Polyline>.of(homeCubit.polylines.values),
                    ),

                    /// location Address
                    Container(
                      margin: EdgeInsets.only(top: height * 0.05),
                      width: width * 0.9,
                      // height: height * 0.1,
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(width * 0.1),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.person_pin_circle_outlined,
                          color: redColor,
                        ),
                        title: Text("$currentAddress"),
                      ),
                    ),
                    // some information
                    if (homeCubit.cancelTaskExpand == false)
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
                              ListTile(
                                leading: IconButton(
                                  icon: Icon(Icons.phone),
                                  onPressed: () async {
                                    String phoneNumber =
                                        widget.providersModelData!.mobile!;
                                    // widget.customerData!.mobile!;
                                    // another solution
                                    // String phoneNumber = Uri.encodeComponent('0114919223');
                                    await canLaunch("tel:$phoneNumber")
                                        ? launch("tel:$phoneNumber")
                                        : showFlutterToast(
                                            message: "call_faild".tr);
                                  },
                                ),
                                title: Container(
                                  height: height * 0.1,
                                  width: width / 2,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(widget
                                                .providersModelData!.time!
                                                .toString()),
                                            CircleAvatar(),
                                            Text(widget
                                                .providersModelData!.distance!
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                      Text(
                                          "picking up ${widget.providersModelData!.userName!}"),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.05),
                                child: Divider(),
                              ),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SocialWidget(
                                    title: "complaint".tr,
                                    icon: Icons.speaker_notes_outlined,
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              FixedTextField(
                                                width: width,
                                                height: height * 0.3,
                                                hint: "title_complaint".tr,
                                                radiusValue: width * 0.02,
                                                controller:
                                                    titleComplaintController,
                                                icon:
                                                    Icons.description_outlined,
                                                iconColor: redColor,
                                              ),
                                              FixedTextField(
                                                width: width,
                                                height: height * 0.3,
                                                hint:
                                                    "description_complaint".tr,
                                                radiusValue: width * 0.02,
                                                controller:
                                                    descriptionComplaintController,
                                                textInputAction:
                                                    TextInputAction.done,
                                                icon:
                                                    Icons.description_outlined,
                                                iconColor: redColor,
                                              ),
                                              SizedBox(height: height * 0.02),
                                              CommonButton(
                                                  width: width * 0.85,
                                                  height: height * 0.09,
                                                  containerColor: redColor,
                                                  textColor: mainColor,
                                                  text: "send_complaint".tr,
                                                  onTap: () {
                                                    if (titleComplaintController
                                                            .text.isEmpty ||
                                                        descriptionComplaintController
                                                            .text.isEmpty) {
                                                      showFlutterToast(
                                                          message:
                                                              "check_empty_fields_please"
                                                                  .tr,
                                                          backgroundColor:
                                                              darkColor);
                                                    } else {
                                                      homeCubit
                                                          .sendComplaint(
                                                              title:
                                                                  titleComplaintController
                                                                      .text,
                                                              description:
                                                                  descriptionComplaintController
                                                                      .text)
                                                          .then((value) => [
                                                                back(context),
                                                                titleComplaintController
                                                                    .clear(),
                                                                descriptionComplaintController
                                                                    .clear(),
                                                              ]);
                                                    }
                                                  })
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SocialWidget(
                                    title: "chat".tr,
                                    icon: Icons.forum_outlined,
                                    onTap: () {
                                      print(
                                          "recevierId--> ${widget.providersModelData!.id!}");
                                      // AppCubit.get(context).getSenderMessages()
                                      // .then((value) =>
                                      AppCubit.get(context).getMessages(
                                              widget.providersModelData!.id!)
                                          // )
                                          ;
                                      goTo(
                                          context,
                                          ChatScreen(
                                            reciverId:
                                                widget.providersModelData!.id!,
                                            username: widget
                                                .providersModelData!.userName!,
                                            userImg: widget
                                                .providersModelData!.profile!,
                                          ));
                                    },
                                  ),
                                  SocialWidget(
                                    title: "message".tr,
                                    icon: Icons.sms_outlined,
                                    onTap: () async {
                                      String androidUrl =
                                          'sms:${widget.providersModelData!.mobile}?body=message';
                                      // 'sms:${widget.customerData!.mobile!}?body=message';
                                      String iosUrl =
                                          'sms:+${widget.providersModelData!.mobile}&body=message';
                                      // 'sms:+${widget.customerData!.mobile!}&body=message';
                                      // await launch("sms:$androidUrl");
                                      print(androidUrl);
                                      print(Platform.isAndroid);
                                      print(Platform.isIOS);
                                      //                                     await canLaunch("sms:01145919223")
                                      //                                         ? launch("sms:01145919223")
                                      //                                         // : showFlutterToast(
                                      //                                         //     message: "call_faild".tr);
                                      // :print("errrrrror");
                                      if (Platform.isAndroid) {
                                        //FOR Android
                                        await launch(
                                          androidUrl,
                                          enableJavaScript: true,
                                        );
                                      } else if (Platform.isIOS) {
                                        await launch(
                                          iosUrl,
                                          enableJavaScript: true,
                                        );
                                      } else {
                                        showFlutterToast(
                                            message: "send_message_faild".tr);
                                      }
                                    },
                                  ),
                                  SocialWidget(
                                    title: "cancel".tr,
                                    icon: Icons.close_outlined,
                                    onTap: () {
                                      homeCubit.changeCancelTaskExpand(context);
                                    },
                                  ),
                                ],
                              )),
                              if (arriveNotification! == "arrive")
                                CommonButton(
                                    width: width * 0.85,
                                    height: height * 0.08,
                                    containerColor: redColor,
                                    textColor: mainColor,
                                    text: "arrived".tr,
                                    onTap: () {
                                      homeCubit.startTimer();
                                      goTo(
                                          context,
                                          ArrivedScreen(
                                            taskId: homeCubit
                                                .createTaskModel!.data!.id,
                                            // providerReciverId:
                                            //     widget.providersModelData!.id!,
                                            providersModelData:
                                                widget.providersModelData!,
                                          ));
                                      homeCubit.resetPolyline();
                                      arriveNotification = "";
                                    }),
                              SizedBox(
                                height: height * 0.01,
                              ),
                            ],
                          ),
                        ),
                      ),

                    // cancel task

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
                                  "cancel".tr +
                                      " " +
                                      homeCubit.createTaskModel!.data!.title!,
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
                                  onTap: (state is CancelTaskLoadingState)
                                      ? () {
                                          showFlutterToast(
                                              message: "loading".tr,
                                              backgroundColor: darkColor);
                                        }
                                      : () {
                                          homeCubit.googleMapController!
                                              .dispose();
                                          homeCubit.resetPolyline();
                                          // homeCubit.currentPage = 1;

                                          // homeCubit.providersList!.clear();
                                          // homeCubit.stopTimer();

                                          // homeCubit.providersModel!.data!.clear();
                                          homeCubit.deleteMessages(
                                              widget.providersModelData!.id!);
                                          homeCubit
                                              .cancelTask(
                                            taskId: homeCubit
                                                .createTaskModel!.data!.id,
                                            mohtarefId:
                                                widget.providersModelData!.id,
                                          )
                                              .then((value) {
                                            goTo(
                                                context,
                                                CancelTaskScreen(
                                                  taskid: homeCubit
                                                      .createTaskModel!
                                                      .data!
                                                      .id,
                                                ));
                                            homeCubit.deleteCacheDir();
                                            homeCubit.providersModel!.data!
                                                .clear();
                                          });
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
                      )
                  ],
                ),
              ),
            );
          });
    });
  }
}

class SocialWidget extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final GestureTapCallback? onTap;

  const SocialWidget({this.title, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon!),
            Text(title!),
          ],
        ),
      ),
    );
  }
}
