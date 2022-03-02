import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/screens/home/bottom_nav_bar_layout.dart';
import 'package:mohtaref_client/view/screens/home/tasks_screen.dart';

String? feesAmount;
String? sparesAmount;
String? totalAmount;
String? confirmBody = "";
String? arriveNotification = "";

abstract class NotificationHandlerWidget {
  ///  ///
  // static void onMessagesNotification(BuildContext context) =>
  //     FirebaseMessaging.onMessage.listen((event) {
  //       // print("onMessage-->${event.notification!.body}");

  //       print("goto onMessage");

  //       if (event.notification!.body!.contains("success"))
  //         // goTo(context, PolyLineMapScreen());
  //         showFlutterToast(
  //             message: "onMessage Success", backgroundColor: Colors.green);
  //       if (event.notification!.body!.contains("cancel"))
  //         // goTo(context, PolyLineMapScreen());
  //         showFlutterToast(
  //             message: "onMessage Cancel", backgroundColor: Colors.green);
  //     });

  // static void onAppOpenedNotification(BuildContext context) =>
  //     FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //       print("onMessageOpenedApp-->${event.notification!.body}");
  //       print("goto onMessageOpenedApp");

  //       if (event.notification!.body!.contains("success"))
  //         // goTo(context, PolyLineMapScreen());
  //         showFlutterToast(
  //             message: "onMessageOpenedApp Success",
  //             backgroundColor: Colors.green);
  //       if (event.notification!.body!.contains("cancel"))
  //         // goTo(context, PolyLineMapScreen());
  //         showFlutterToast(
  //             message: "onMessageOpenedApp Cancel",
  //             backgroundColor: Colors.green);
  //     });

  // static void onBackGroundNotification(BuildContext context) async {
  //   await Firebase.initializeApp();
  //   FirebaseMessaging.onBackgroundMessage((RemoteMessage? message) async {
  //     print("goto onBackgroundMessage");
  //     // print("onBackgroundMessage-->${message!.notification!.body}");

  //     // if (message!.notification!.body!.contains("success"))
  //     // goTo(context, PolyLineMapScreen());
  //     return showFlutterToast(
  //         message: "onBackgroundMessage Success",
  //         backgroundColor: Colors.green);
  //     // if (message.notification!.body!.contains("cancel"))
  //     // goTo(context, PolyLineMapScreen());
  //     // showFlutterToast(
  //     //     message: "onBackgroundMessage Cancel",
  //     //     backgroundColor: Colors.green);
  //   });
  // }

  ///  ///
  ///
  ///
  /// start ConfirmNotification

  static void onMessageConfirmNotification(BuildContext context) =>
      FirebaseMessaging.onMessage.listen((event) {
        print("onMessage-->${event.notification!.body}");
        print("onMessage-->${event.data}");
        // print("onMessage-->${(event.data['spares'])}");
        // print("onMessage-->${(event.data['total'])}");
        var total = jsonDecode(event.data['total']);
        var spares = jsonDecode(event.data['spares']);
        var fees = jsonDecode(event.data['fees']);
        print("ddddddddddddd->${total['price']}");
        print("fffffffffff->${spares['price']}");
        print("gggggggggg->${fees['price']}");

        print("goto onMessage");
        var status = event.data['status'];
        if (status.contains("confirm_pay")) {
          var homeCubit = AppCubit.get(context);
          homeCubit.polylineCoordinates.clear();
          homeCubit.markers.clear();
          homeCubit.polylines.clear();
          homeCubit..stopTimer();

          // homeCubit.confirmNotificationAlertExpand(context);
          confirmBody = status;
          feesAmount = fees['price'];
          sparesAmount = spares['price'];
          totalAmount = total['price'];
          print("nnnnnnnnnnnnnnn$confirmBody");
          print("nnnnnnnnnnnnnnn$feesAmount");
          print("nnnnnnnnnnnnnnn$sparesAmount");
          print("nnnnnnnnnnnnnnn$totalAmount");
        }

        // showFlutterToast(
        //     message: "onMessage Confirm", backgroundColor: Colors.green);
      });

  static void onAppOpenedConfirmNotification(BuildContext context) =>
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        // print("onMessageOpenedApp--> ${event.data['customer']}");
        // print("onMessageOpenedApp--> ${event.data['task_details']}");
        print("onMessageOpenedApp-->${event.notification!.body}");
        print("goto onMessageOpenedApp");
        var total = jsonDecode(event.data['total']);
        var spares = jsonDecode(event.data['spares']);
        var fees = jsonDecode(event.data['fees']);
        print("ddddddddddddd->${total['price']}");
        print("fffffffffff->${spares['price']}");

        print("goto onMessage");
        var status = event.data['status'];
        if (status.contains("confirm")) {
          var homeCubit = AppCubit.get(context);
          homeCubit.polylineCoordinates.clear();
          homeCubit.markers.clear();
          homeCubit.polylines.clear();
          homeCubit..stopTimer();

          // homeCubit.confirmNotificationAlertExpand(context);
          confirmBody = status;
          feesAmount = fees['price'];
          sparesAmount = spares['price'];
          totalAmount = total['price'];
          print("nnnnnnnnnnnnnnn$sparesAmount");
          print("nnnnnnnnnnnnnnn$totalAmount");
        }
      });

  static void onBackGroundConfirmNotification(BuildContext context) async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print("goto onBackgroundMessage");
      print("onBackgroundMessage-->${message.notification!.body}");
      var total = jsonDecode(message.data['total']);
      var spares = jsonDecode(message.data['spares']);
      var fees = jsonDecode(message.data['fees']);
      print("ddddddddddddd->${total['price']}");
      print("fffffffffff->${spares['price']}");
      var status = message.data['status'];
      if (status.contains("confirm")) {
        var homeCubit = AppCubit.get(context);
        homeCubit.polylineCoordinates.clear();
        homeCubit.markers.clear();
        homeCubit.polylines.clear();
        homeCubit..stopTimer();

        // homeCubit.confirmNotificationAlertExpand(context);
        confirmBody = status;
        feesAmount = fees['price'];
        sparesAmount = spares['price'];
        totalAmount = total['price'];
        print("nnnnnnnnnnnnnnn$sparesAmount");
        print("nnnnnnnnnnnnnnn$totalAmount");
      }
    });
  }

  /// end ConfirmNotification
  ///
  ///
  /// start Notification CancelTask

  static void onMessagesNotificationCancelTask(BuildContext context) =>
      FirebaseMessaging.onMessage.listen((event) {
        print("onMessage-->${event.notification!.body}");
        print("onMessage-->new ---> ${event.data['status']}");

        print("goto onMessage");
        var status = event.data['status'];
        print("onMessage-->new status ---> $status}");
        if (status.contains("cancel_task")) {
          var cubit = AppCubit.get(context);
          cubit.providersModel!.data!.clear();
          cubit.resetPolyline();
          cubit.googleMapController!.dispose();
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BotomNavBarLayout(),
              ),
              (route) => true,
            );
          });
        }

        // showFlutterToast(message: "onMessage", backgroundColor: Colors.green);
      });

  static void onAppOpenedNotificationCancelTask(BuildContext context) =>
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print("onMessageOpenedApp-->${event.notification!.body}");

        var status = event.data['status'];
        if (status.contains("cancel_task")) {
          var cubit = AppCubit.get(context);

          cubit.resetPolyline();
          cubit.googleMapController!.dispose();
          cubit.providersModel!.data!.clear();
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BotomNavBarLayout(),
              ),
              (route) => true,
            );
          });
        }
        // showFlutterToast(
        // message: "onMessageOpenedApp", backgroundColor: Colors.green);
      });

  static void onBackGroundNotificationCancelTask(BuildContext context) async {
    await Firebase.initializeApp();
    FirebaseMessaging?.onBackgroundMessage((RemoteMessage message) async {
      print("goto onBackgroundMessage");
      print("onBackgroundMessage-->${message.notification!.body}");
      var status = message.data['status'];
      if (status.contains("cancel_task")) {
        var cubit = AppCubit.get(context);
        cubit.providersModel!.data!.clear();
        cubit.resetPolyline();
        cubit.googleMapController!.dispose();
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => BotomNavBarLayout(),
            ),
            (route) => true,
          ).then((value) => status = '');
        });
      }
      // return showFlutterToast(
      // message: "onBackgroundMessage", backgroundColor: Colors.green);
    });
  }

  /// end Notification CancelTask
  ///
  ///
  /// start Notification NewStaffAvilable

  static void onMessagesNotificationNewStaffAvailable(BuildContext context) =>
      FirebaseMessaging.onMessage.listen((event) {
        print("onMessage-->${event.notification!.body}");
        print("onMessage-->new ---> ${event.data['status']}");

        print("goto onMessage");
        var status = event.data['status'];
        print("onMessage-->new status ---> $status}");
        // if (status.contains("new_staff_available")) {
        //   goTo(context, TasksScreen());
        // }

        // showFlutterToast(message: "onMessage", backgroundColor: Colors.green);
      });

  static void onAppOpenedNotificationNewStaffAvailable(BuildContext context) =>
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print("onMessageOpenedApp-->${event.notification!.body}");

        // var status = event.data['status'];
        // if (status.contains("new_staff_available")) {
        //   goTo(context, TasksScreen());
        // }
        // showFlutterToast(
        // message: "onMessageOpenedApp", backgroundColor: Colors.green);
      });

  static void onBackGroundNotificationNewStaffAvailable(
      BuildContext context) async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print("goto onBackgroundMessage");
      print("onBackgroundMessage-->${message.notification!.body}");
      // var status = message.data['status'];
      // if (status.contains("new_staff_available")) {
      //   goTo(context, TasksScreen());
      // }
      // return showFlutterToast(
      // message: "onBackgroundMessage", backgroundColor: Colors.green);
    });
  }

  /// end Notification NewStaffAvilable
  ///
  ///
  /// start Notification ArriveNotificationFromMohtaref

  static void onMessagesArriveNotificationFromMohtaref(BuildContext context) =>
      FirebaseMessaging.onMessage.listen((event) {
        print("onMessage-->${event.notification!.body}");
        print("onMessage-->new ---> ${event.data['status']}");

        print("goto onMessage");
        var status = event.data['status'];
        print("onMessage-->new status ---> $status}");

        arriveNotification = status;

        print("kkkkkkkk---------->$arriveNotification");
        var homeCubit = AppCubit.get(context);
        homeCubit.refresh();

        // showFlutterToast(message: "onMessage", backgroundColor: Colors.green);
      });

  static void onAppOpenedArriveNotificationFromMohtaref(BuildContext context) =>
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print("onMessageOpenedApp-->${event.notification!.body}");

        var status = event.data['status'];

        arriveNotification = status;
        print("kkkkkkkk---------->$arriveNotification");
        var homeCubit = AppCubit.get(context);
        homeCubit.refresh();
      });

  static void onBackGroundArriveNotificationFromMohtaref(
      BuildContext context) async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print("goto onBackgroundMessage");
      print("onBackgroundMessage-->${message.notification!.body}");
      var status = message.data['status'];

      arriveNotification = status;
      print("kkkkkkkk---------->$arriveNotification");
      var homeCubit = AppCubit.get(context);
      homeCubit.refresh();
    });
  }

  /// end Notification ArriveNotificationFromMohtaref
}
