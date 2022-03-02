import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mohtaref_client/controller/cubit/App_cubit.dart';
import 'package:mohtaref_client/view/components_widget/navigator.dart';
import 'package:mohtaref_client/view/screens/auth/welcome_screen.dart';
import 'package:mohtaref_client/view/screens/language_screen.dart';
import '../../constant.dart';
import 'home/bottom_nav_bar_layout.dart';
import 'internet_connection/no_internet_connection.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() async {
    Widget? screenWidget;
    print("llllllangScreeeeeen7777777777777--->$langScreen");

    if (langScreen == true) {
      if (userToken != null)
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            screenWidget = BotomNavBarLayout();
            print('connected');
          }
        } on SocketException catch (_) {
          // showFlutterToast(message: "check_connection".tr);
          screenWidget = NoInternetConnection();
          print('not connected');
        }
      // screenWidget = BotomNavBarLayout();
      else
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            screenWidget = WelcomeScreen();
            print('connected');
          }
        } on SocketException catch (_) {
          screenWidget = NoInternetConnection();
          print('not connected');
        }
      var cubit = AppCubit.get(context);
      (userToken != null)
          ? cubit.getOrders().then((value) => cubit.getProfileData()).then(
              (value) => Navigator.pushReplacement(
                  context, createRoute(screenWidget!)))
          : Navigator.pushReplacement(context, createRoute(screenWidget!));
    } else {
      screenWidget = LanguageScreen();
      goTo(_scaffoldKey.currentContext, screenWidget);
    }
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseMessaging.onMessage.listen((event) {
    //   print(event);
    //   showFlutterToast(message: "onMessage", backgroundColor: redColor);
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   print(event);

    //   showFlutterToast(
    //       message: "onMessageOpenedApp", backgroundColor: redColor);
    // });
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    return Scaffold(
      key: _scaffoldKey,
      body: initScreen(context),
    );
  }
}

initScreen(BuildContext context) {
  return Scaffold(
    // backgroundColor: Colors.grey.withOpacity(0.6),
    body: Container(
      // width: double.infinity,
      // height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("asset/images/splash_logo.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: MediaQuery.of(context).size.width / 3,
          child: Image.asset(
            "asset/images/main_logo.png",
            fit: BoxFit.cover,
            // width: 500,
            // height: 800,
          ),
        ),
      ),
    ),
  );
}
