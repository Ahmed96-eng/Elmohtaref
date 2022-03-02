import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mohtaref_client/controller/api_dio_helper/dio_helper.dart';
import 'package:mohtaref_client/controller/bloc_observer.dart';
import 'package:mohtaref_client/view/screens/internet_connection/restart_app.dart';
import 'package:mohtaref_client/view/screens/splash_screen.dart';
import 'constant.dart';
import 'controller/cached_helper/cached_helper.dart';
import 'controller/cached_helper/key_constant.dart';
import 'controller/cubit/App_cubit.dart';
import 'controller/cubit/Auth_cubit.dart';
import 'controller/language_helper/Binding.dart';
import 'features/language/translation_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachedHelper.init();
  AppCubit().onInit();
  AuthCubit().onInit();
  FirebaseMessaging.instance.getToken().then((value) {
    print("Device Token is :: ->  $value");
    deviceToken = value;
    CachedHelper.setData(key: deviceTokenKey, value: value);
  });
  deviceToken = CachedHelper.getData(key: deviceTokenKey);

  // FirebaseMessaging.instance.subscribeToTopic('1');
  // FirebaseMessaging.onMessage.listen((event) {
  //   print(event);
  //   return showFlutterToast(message: "onMessage", backgroundColor: redColor);
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print(event);
  //   return showFlutterToast(
  //       message: "onMessageOpenedApp", backgroundColor: redColor);
  // });

  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  print("Device Token string is :: ->  $deviceToken");
  lang = CachedHelper.getData(key: languageKey) ?? 'ar';
  langScreen = CachedHelper.getData(key: langScreenKey);
  print("lllllllllllllllllllllllaaaaannngggg--->$lang");
  print("llllllangScreeeeeen--->$langScreen");
  await Jiffy.locale(lang);
  mohtarefClientId = CachedHelper.getData(key: mohtarefClientIdKey);
  userToken = CachedHelper.getData(key: loginTokenId);
  totalWalletAmount = CachedHelper.getData(key: walletAmountKey) == null
      ? totalWalletAmount
      : CachedHelper.getData(key: walletAmountKey);
  CachedHelper.prefs!.reload();

  print("userId is $mohtarefClientId");
  runApp(RestartWidget(
    child: MyApp(
        // screenWidget: screenWidget,
        ),
  ));
}

class MyApp extends StatelessWidget {
  final Widget? screenWidget;

  const MyApp({this.screenWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => AppCubit()
            ..getServices()
            ..getSlider()
            ..getContacts()
            ..resetPolyline()
            // ..getOrders()

            // ..getProfileData()
            // ..getProfile(mohtarefClientId!)
            ..getCurrentPosition(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Mohtaref Client',
        debugShowCheckedModeBanner: false,
        initialBinding: Binding(),
        transitionDuration: Duration(milliseconds: 500),
        translations: TranslationApp(),
        locale: Locale(lang ?? 'ar'),
        fallbackLocale: Locale(lang ?? 'ar'),
        theme: ThemeData(
          primarySwatch: Colors.grey,
          // hintColor: redColor,
          // inputDecorationTheme: InputDecorationTheme(
          //   border: OutlineInputBorder(
          //     borderSide: BorderSide(color: redColor!),
          //   ),
          //   // labelStyle: TextStyle(color: kYellow, fontSize: 24.0),
          // ),
          appBarTheme: AppBarTheme(
            backwardsCompatibility: false,
            // color: Colors.white,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              // statusBarColor: mainColor,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
