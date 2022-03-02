import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: "https://el-mohtaref.com/api_customer/",
          receiveDataWhenStatusError: true),
    );
  }

  static getData({
    required String? endpoint,
    // String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${userToken == null ? "" : userToken}",
      "lang": lang == null ? "ar" : lang,
    };
    try {
      return await dio!.get(
        endpoint!,
      );
    } on DioError catch (error) {
      print(error);
      throw error;
    }
  }

  static postData({
    required String? endpoint,
    required Map<String, dynamic>? data,
    // String? token,
  }) async {
    FormData formData = FormData.fromMap(data!);
    dio!.options.headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${userToken == null ? "" : userToken}",
      "lang": lang == null ? "ar" : lang,
    };
    try {
      return await dio!.post(
        endpoint!,
        data: formData,
      );
    } on DioError catch (error) {
      print(error);
      throw error;
    }
  }

  static Future<Response> putData({
    @required String? endpoint,
    @required Map<String, dynamic>? data,
    // dynamic quray,
    // String lang = 'en',
    // String? token,
  }) async {
    dio!.options.headers = {
      // "lang": lang,
      // 'Content-Type': 'application/json',
      // "Authorization": token,
    };
    return await dio!.put(
      endpoint!,
      data: data,
      // queryParameters: quray ?? null,
    );
  }
}
