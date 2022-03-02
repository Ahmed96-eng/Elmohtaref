import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mohtaref_client/view/components_widget/common_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

Position? currentPosition;
String? currentAddress;
String? timeEstmate;

String? userToken;
String? mohtarefClientId;
String? lang;
bool? langScreen;
String mapKey = "AIzaSyBmX3cxNy7VH9WLrzoh6FLGkjtZ0g3tLSE";
String? deviceToken;
double? totalWalletAmount = 0.0;
double? totalDueAmount = 0.0;
Color? mainColor = Colors.white;
Color? mainColorOpacity = Colors.cyan.withOpacity(0.3);
Color? secondColor = Colors.black;
Color? thirdColor = Colors.grey[200];
Color? greyColor = Colors.grey[600];
Color? redColor = Color(0xffbb0a1e);
Color? darkColor = Color(0XFF282F39);

Color? buttonColor = Color(0xffbb0a1e);
Color? buttonTextColor = Colors.white;

checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
    }
  } on SocketException catch (_) {
    print('not connected');
  }
}

showFlutterToast({
  String? message,
  Color? backgroundColor = Colors.black38,
}) =>
    Fluttertoast.showToast(
        msg: message!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: mainColor,
        fontSize: 16.0);

showAlertDailog(
        {required BuildContext? context,
        String? titlle = "",
        String? message = "",
        String? labelNo = "",
        String? labelYes = "",
        bool? isContent = true,
        Widget? contentWidget,
        VoidCallback? onPressNo,
        VoidCallback? onPressYes}) =>
    showDialog(
      context: context!,
      builder: (ctx) => AlertDialog(
        // backgroundColor: mainColorOpacity,
        // contentPadding: EdgeInsets.all(8),
        // titlePadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: new Text(
          titlle!,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
        content: isContent!
            ? contentWidget
            : Text(
                message!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 18),
              ),
        actions: <Widget>[
          CommonButton(
            text: labelNo,
            textColor: buttonColor,
            onTap: onPressNo,
          ),
          CommonButton(
            text: labelYes,
            textColor: buttonColor,
            onTap: onPressYes,
          ),
        ],
      ),
    );
showLoadingDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          content: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: MediaQuery.of(context).size.width * 0.05,
            children: [
              CircularProgressIndicator(
                color: redColor,
              ),
              Text(
                "loading".tr,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
openContactUsURL(BuildContext context,
    {bool? isWhatsApp,
    bool? isFacebook,
    bool? isInstegram,
    bool? isTelegram,
    String? facebookUrlAndroid,
    String? facebookUrlIos,
    String? whatsappUrlAndroid,
    String? whatsappUrlIos,
    String? instegramUrlAndroid,
    String? instegramUrlIos,
    String? telegramUrlAndroid,
    String? telegramUrlIos,
    String? phone,
    String? errorMessage}) async {
  if (Platform.isIOS) {
    // for iOS phone only

    if (await canLaunch(isWhatsApp!
        ? whatsappUrlIos!
        : isFacebook!
            ? facebookUrlIos!
            : isTelegram!
                ? telegramUrlIos!
                : isInstegram!
                    ? instegramUrlIos!
                    : phone!)) {
      await launch(
          isWhatsApp
              ? whatsappUrlIos!
              : isFacebook!
                  ? facebookUrlIos!
                  : isTelegram!
                      ? telegramUrlIos!
                      : isInstegram!
                          ? instegramUrlIos!
                          : phone!,
          forceSafariVC: false);
    } else {
      showFlutterToast(message: errorMessage);
    }
  } else {
    // android , web
    if (await canLaunch(isWhatsApp!
        ? whatsappUrlAndroid!
        : isFacebook!
            ? facebookUrlAndroid!
            : isTelegram!
                ? telegramUrlAndroid!
                : isInstegram!
                    ? instegramUrlAndroid!
                    : phone!)) {
      await launch(isWhatsApp
          ? whatsappUrlAndroid!
          : isFacebook!
              ? facebookUrlAndroid!
              : isTelegram!
                  ? telegramUrlAndroid!
                  : isInstegram!
                      ? instegramUrlAndroid!
                      : phone!);
    } else {
      showFlutterToast(message: errorMessage);
    }
  }
}

Widget constantBackgroundScreens(double height, double width) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("asset/images/splash_logo.png"),
        scale: 1,
        colorFilter:
            ColorFilter.mode(Colors.white.withOpacity(0.4), BlendMode.dstATop),
        fit: BoxFit.fill,
      ),
    ),
  );
}
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print(message);
//   return showFlutterToast(
//       message: "onBackgroundMessage", backgroundColor: redColor);
// }
