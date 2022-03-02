import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mohtaref_client/controller/api_dio_helper/dio_helper.dart';
import 'package:mohtaref_client/controller/api_dio_helper/endpoint_dio.dart';
import 'package:mohtaref_client/controller/cached_helper/cached_helper.dart';
import 'package:mohtaref_client/controller/cached_helper/key_constant.dart';
import 'dart:async';

import 'package:mohtaref_client/controller/cubit_states/Auth_state.dart';
import 'package:mohtaref_client/model/auth_model.dart';

import '../../constant.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);

  onInit() {}

  /// start show password

  bool showPassword = true;
  void changeshowPassword(BuildContext context) {
    showPassword = !showPassword;
    emit(ChangeShowPasswordState());
  }

  /// end show password
  ///
  ///
  /// start timer

  Timer? timer;
  int start = 6;
  bool isTimerStart = false;
  void _stopTimerCountDown() {
    timer!.cancel();
    print("STOP");
    emit(AppStopTimerCountDownState());
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    isTimerStart = !isTimerStart;
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          _stopTimerCountDown();
          exit(0);
        } else {
          start--;
          emit(AppStartTimerCountDownState());
        }
      },
    );
  }

  /// end timer
  ///
  ///
  /// start login

  AuthModelModel? authModel;
  Future<void> logIn({String? email, String? password}) async {
    try {
      emit(AuthLoginLoadingState());

      return await DioHelper.postData(endpoint: LOGIN, data: {
        "email": email,
        "password": password,
        "fcm_device_token": deviceToken,
      }).then(
        (value) {
          // if(value.data.statusCode)
          print('pppppppppppppppppp');

          print(value.data);

          print(value);
          authModel = AuthModelModel.fromJson(value.data);
          print(authModel!.data!.username);
          CachedHelper.setData(
              key: loginTokenId, value: authModel!.data!.token.toString());
          userToken = authModel!.data!.token;
          print('kkkkkkkkkkkkkk==> $userToken');
          CachedHelper.setData(
              key: mohtarefClientIdKey, value: authModel!.data!.id.toString());
          totalWalletAmount = double.parse(authModel!.data!.wallet!);
          CachedHelper.setData(
              key: walletAmountKey,
              value: double.parse(authModel!.data!.wallet!));
          emit(AutLoginSuccessState(authModel!));
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(AuthLoginErrorState());
    }
  }

  /// end login
  ///
  ///
  /// start Register

  Future register({
    String? email,
    String? password,
    String? username,
    String? mobile,
    String? long,
    String? lat,
    String? location,
  }) async {
    print("==========>  $deviceToken");
    try {
      emit(AuthRegisterLoadingState());
      CachedHelper.removeData(key: walletAmountKey);
      totalWalletAmount = 0.0;
      await DioHelper.postData(endpoint: REGISTER, data: {
        "email": email,
        "password": password,
        "username": username,
        "mobile": mobile,
        "long": long,
        "lat": lat,
        "location": location,
        "device_token": deviceToken,
      }).then(
        (value) {
          print(deviceToken);
          print(value.data);
          authModel = AuthModelModel.fromJson(value.data);
          // CachedHelper.setData(
          //     key: loginTokenId, value: authModel!.data!.token.toString());
          // userToken = authModel!.data!.token;
          // CachedHelper.setData(
          //     key: mohtarefClientIdKey, value: authModel!.data!.id.toString());
          // mohtarefClientId = authModel!.data!.id;
          // totalWalletAmount = double.parse(authModel!.data!.wallet!);
          // CachedHelper.setData(
          //     key: walletAmountKey,
          //     value: double.parse(authModel!.data!.wallet!));
          emit(AuthRegisterSuccessState(authModel));
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(AuthRegisterErrorState());
    }
  }

  /// End Register
  ///
  ///
  ///start get current address , location

  Position? currentPosition;
  String? currentAddress;
  Future<void> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    print(currentPosition!.latitude);
    print(currentPosition!.longitude);
  }

  Future<void> getAddressFromLatLng() async {
    try {
      print("start");
      List<Placemark> originPlacemarks = await placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);

      Placemark originPlace = originPlacemarks[0];

      print("start1");
      currentAddress =
          "${originPlace.street},${originPlace.subAdministrativeArea}, ${originPlace.administrativeArea}, ${originPlace.country}";
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxx " + "$currentAddress");
    } catch (error) {
      print("ERROR2223333222 message");
    }
  }

  ///end get current address , location
  ///
  ///
  /// start sendSMSorEmail

  Future sendSMSorEmail(String method) async {
    try {
      emit(SendSMSorEmailLoadingState());

      await DioHelper.postData(endpoint: SENDSMSOREMAIL, data: {
        "method": method,
      }).then(
        (value) {
          print('SMSorEmail Success');
          print(value);
          emit(SendSMSorEmailSuccessState());
          // return value;
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(SendSMSorEmailErrorState());
    }
  }

  /// end sendSMSorEmail
  ///
  ///
  /// start send OTP

  Future sendOTP(String otp, String method) async {
    try {
      emit(SendOTPLoadingState());

      await DioHelper.postData(endpoint: SENDOTP, data: {
        "method": method,
        "otp": otp,
      }).then(
        (value) {
          print('OTP Success');
          print(value);
          emit(SendOTPSuccessState());
          // return value;
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(SendOTPErrorState());
    }
  }

  /// end send OTP
  ///
  ///
  /// start setNewPassword

  Future setNewPassword(String newPassword, String method) async {
    try {
      emit(SetNewPasswordLoadingState());

      await DioHelper.postData(endpoint: SETNEWPASSWORD, data: {
        "method": method,
        "password": newPassword,
      }).then(
        (value) {
          print('Set Success');
          print(value);
          emit(SetNewPasswordSuccessState());
          // return value;
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(SetNewPasswordErrorState());
    }
  }

  /// end setNewPassword
  ///
  ///
}
