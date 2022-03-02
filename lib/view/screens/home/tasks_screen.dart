import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/controller/cubit_states/app_states.dart';
import 'package:mohtaref_client/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref_client/model/services_model.dart';
import 'package:mohtaref_client/view/components_widget/cached_network_Image_widget.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/components_widget/no_data_widget.dart';
import 'package:mohtaref_client/view/components_widget/rating_widget.dart';
import 'package:mohtaref_client/view/components_widget/style.dart';
import 'package:mohtaref_client/view/screens/home_polyline_map/cancel_task_screen.dart';
import 'package:mohtaref_client/view/screens/home_polyline_map/polyline_map.dart';
import 'package:mohtaref_client/view/screens/notification_handler_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../constant.dart';

class TasksScreen extends StatefulWidget {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ServicesModelData? servicesModelData;
  final int? index;
  TasksScreen({this.index, this.servicesModelData});

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  // final RefreshController refreshController =
  //     RefreshController(initialRefresh: true);
  Timer? timerPeriodic;
  @override
  void initState() {
    timerPeriodic = Timer.periodic(new Duration(seconds: 15), (timer) {
      AppCubit.get(context).getProviders(
        // serviceId: servicesModelData!.id,
        taskId: AppCubit.get(context).createTaskModel!.data!.id,
        lat: (currentPosition!.latitude).toString(),
        long: (currentPosition!.longitude).toString(),
        // isRefresh: false
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    timerPeriodic!.cancel();
    // refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NotificationHandlerWidget.onMessagesNotificationCancelTask(context);
    NotificationHandlerWidget.onAppOpenedNotificationCancelTask(context);
    NotificationHandlerWidget.onMessagesNotificationNewStaffAvailable(context);
    NotificationHandlerWidget.onAppOpenedNotificationNewStaffAvailable(context);
    // NotificationHandlerWidget.onMessagesNotification(context);
    // NotificationHandlerWidget.onAppOpenedNotification(context);
    // NotificationHandlerWidget.onBackGroundNotification(context);

    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        // if (state is AcceptTaskLoadingState) {
        //   showLoadingDialog(context);
        // }
        // if (state is AcceptTaskSuccessState) {
        //   back(context);
        // }
        // if (state is AcceptTaskErrorState) {
        //   back(context);
        // }
      }, builder: (context, state) {
        var homeCubit = AppCubit.get(context);
        var providersData = homeCubit.providersModel != null
            ? homeCubit.providersModel!.data!
            : [];
        // var servicesModelData = homeCubit.servicesModel!.data![index!];
        // AppCubit.get(context).providersModel!.data!.provider!;

        return WillPopScope(
          onWillPop: () async {
            showFlutterToast(message: "no_back".tr, backgroundColor: redColor);
            return false;
          },
          child: Scaffold(
            body: Container(
              height: height,
              width: width,
              child: Stack(
                // alignment: AlignmentDirectional.topCenter,
                children: [
                  /// map
                  GoogleMap(
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    scrollGesturesEnabled: false,
                    zoomControlsEnabled: false,
                    // initialCameraPosition: homeCubit.kGooglePlex,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(currentPosition!.latitude,
                          currentPosition!.longitude),
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      // homeCubit.getCurrentPosition();
                    },
                  ),

                  // /// profile icon
                  // Align(
                  //     alignment: AlignmentDirectional.topEnd,
                  //     child: Padding(
                  //       padding: EdgeInsets.symmetric(
                  //           horizontal: width * 0.02,
                  //           vertical: height * 0.05),
                  //       child: Badge(
                  //           value: "2",
                  //           color: redColor,
                  //           child: InkWell(
                  //             onTap: () {
                  //               print('profile');
                  //               goTo(context, AccountScreen());
                  //             },
                  //             child: CircleAvatar(
                  //               radius: 25,
                  //             ),
                  //           )),
                  //     )),

                  // /// Drawer
                  // Align(
                  //     alignment: AlignmentDirectional.topStart,
                  //     child: Padding(
                  //       padding: EdgeInsets.symmetric(
                  //           horizontal: width * 0.02,
                  //           vertical: height * 0.05),
                  //       child: IconButtonWidget(
                  //         icon: Icons.menu_outlined,
                  //         onpressed: () =>
                  //             _scaffoldKey.currentState!.openDrawer(),
                  //       ),
                  //     )),

                  /// Tasks

                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                      height: providersData.length == 0
                          ? height * 0.7
                          : providersData.length == 1
                              ? height * 0.8
                              : height * 0.9,
                      width: width,
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02, vertical: height * 0.01),
                      color: Colors.white54,
                      child: Column(
                        children: [
                          /// tasks
                          Expanded(
                            child: providersData.length != 0
                                ? ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: providersData.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: width * 0.01,
                                            vertical: height * 0.02),
                                        elevation: 3,
                                        child: Container(
                                          width: width,
                                          height: height * 0.32,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  /// accept or cancel
                                                  Expanded(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircularPercentIndicator(
                                                        radius: width * 0.15,
                                                        animation: true,
                                                        animationDuration: 1200,
                                                        lineWidth: width * 0.02,
                                                        percent: double.parse(
                                                                    providersData[
                                                                            index]
                                                                        .percentage!) >=
                                                                1
                                                            ? 0.0
                                                            : double.parse(
                                                                providersData[
                                                                        index]
                                                                    .percentage!),
                                                        circularStrokeCap:
                                                            CircularStrokeCap
                                                                .butt,
                                                        backgroundColor:
                                                            thirdColor!,
                                                        progressColor:
                                                            Colors.red,
                                                        addAutomaticKeepAlive:
                                                            true,
                                                        animateFromLastPercent:
                                                            true,
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              timerPeriodic!
                                                                  .cancel();
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                  content: Text(
                                                                    "Loading",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              );

                                                              Future.delayed(
                                                                      Duration(
                                                                          seconds:
                                                                              1))
                                                                  .then(
                                                                      (value) {
                                                                homeCubit
                                                                    .getDestinationAddressFromLatLng(
                                                                  destLatitude:
                                                                      double.parse(
                                                                          providersData[index]
                                                                              .lat!),
                                                                  destLongitude:
                                                                      double.parse(
                                                                          providersData[index]
                                                                              .long!),
                                                                );
                                                                homeCubit
                                                                    .acceptTask(
                                                                        mohtarefId:
                                                                            providersData[index]
                                                                                .id,
                                                                        taskId: homeCubit
                                                                            .createTaskModel!
                                                                            .data!
                                                                            .id)
                                                                    .then((value) => goTo(
                                                                        context,
                                                                        PolyLineMapScreen(
                                                                          providersModelData:
                                                                              providersData[index],
                                                                        )));
                                                              });
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              redColor!)),
                                                              child:
                                                                  CircleAvatar(
                                                                radius: width *
                                                                    0.05,
                                                                backgroundColor:
                                                                    redColor,
                                                                child:
                                                                    FittedBox(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .all(width *
                                                                            0.02),
                                                                    child: Text(
                                                                      "accept"
                                                                          .tr,
                                                                      style:
                                                                          firstLineStyle,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.01,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              /// future task for me
                                                              // providersData.clear();
                                                              // print(
                                                              //     "ggggggggggg===>${providersData.length}");
                                                              timerPeriodic!
                                                                  .cancel();
                                                              homeCubit
                                                                  .deleteCacheDir();
                                                              goTo(
                                                                  context,
                                                                  CancelTaskScreen(
                                                                    taskid: AppCubit.get(
                                                                            context)
                                                                        .createTaskModel!
                                                                        .data!
                                                                        .id,
                                                                  ));
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              redColor!)),
                                                              child:
                                                                  CircleAvatar(
                                                                radius: width *
                                                                    0.05,
                                                                backgroundColor:
                                                                    mainColor,
                                                                child:
                                                                    FittedBox(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .all(width *
                                                                            0.02),
                                                                    child: Text(
                                                                      "cancel"
                                                                          .tr,
                                                                      style:
                                                                          lineStyleSmallBlack,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),

                                                  /// general information
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                height * 0.02),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  width * 0.15,
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .all(width *
                                                                        0.02),
                                                                child: Text(
                                                                  providersData[
                                                                          index]
                                                                      .time!,
                                                                  style:
                                                                      smallBlackStyle,
                                                                ),
                                                              ),
                                                            ),
                                                            ClipOval(
                                                              clipBehavior: Clip
                                                                  .antiAliasWithSaveLayer,
                                                              child:
                                                                  CachedNetworkImageWidget(
                                                                key: Key(
                                                                    "cashed_image"),
                                                                width: width *
                                                                    0.16,
                                                                height: height *
                                                                    0.1,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(width *
                                                                            .02),
                                                                image: providersData[
                                                                        index]
                                                                    .profile,
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  width * 0.15,
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .all(width *
                                                                        0.02),
                                                                child: Text(
                                                                  providersData[
                                                                          index]
                                                                      .distance!,
                                                                  style:
                                                                      smallBlackStyle,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // Spacer(),
                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Text(
                                                          providersData[index]
                                                              .userName!,
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Text(
                                                          providersData[index]
                                                              .job!,
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  /// rating block

                                                  Expanded(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "rating".tr,
                                                        style:
                                                            lineStyleSmallBlack,
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.02,
                                                      ),
                                                      RatingMethodWidget(
                                                          width: width * 0.2,
                                                          onRatingUpdate:
                                                              (rate) {},
                                                          ignoreGestures: true,
                                                          initialRating:
                                                              double.parse(
                                                                  providersData[
                                                                          index]
                                                                      .rate!)),
                                                    ],
                                                  )),
                                                ],
                                              ),
                                              Text(
                                                "fixed_fees".tr +
                                                    " : " +
                                                    (providersData[index]
                                                            .servicesFees!)
                                                        .toString() +
                                                    "sar".tr,
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              Text(
                                                "trip_fees".tr +
                                                    " : " +
                                                    (providersData[index]
                                                            .tripFees!)
                                                        .toString() +
                                                    "sar".tr,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "no_providers_found_yet".tr,
                                        textAlign: TextAlign.center,
                                        style: labelStyleMinBlack,
                                      ),
                                      NoDataWidget(
                                          width: width * 0.6,
                                          height: height * 0.2)
                                    ],
                                  ),
                          ),

                          /// cancel tasks
                          InkWell(
                            onTap: () {
                              timerPeriodic!.cancel();

                              providersData.clear();
                              homeCubit
                                  .deleteTask(
                                      taskId:
                                          homeCubit.createTaskModel!.data!.id)
                                  .then((value) => back(context));
                            },
                            child: CircleAvatar(
                              radius: width * 0.14,
                              backgroundColor: mainColor,
                              child: Container(
                                width: width * 0.25,
                                height: height * 0.15,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: redColor!,
                                      width: width * 0.003,
                                    )),
                                child: Icon(
                                  Icons.cancel_presentation_outlined,
                                  color: redColor,
                                  size: width * 0.08,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
