import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mohtaref_client/controller/cached_helper/cached_helper.dart';
import 'package:mohtaref_client/controller/cached_helper/key_constant.dart';

class LanguageController extends GetxController {
  var localLanguage = 'ar';
  @override
  void onInit() async {
    super.onInit();
    // CachedHelper _cachedHelper = CachedHelper();

    localLanguage = await CachedHelper.getData(key: languageKey) == null
        ? 'ar'
        : await CachedHelper.getData(key: languageKey);
    Get.updateLocale(Locale(localLanguage));
    update();
  }

  void toggleLanguge(String localValue) async {
    if (localLanguage == localValue) {
      return;
    }
    if (localValue == 'en') {
      localLanguage = 'en';
      CachedHelper.setData(key: languageKey, value: localLanguage);
      print('00000000000000000$localLanguage');
      print(CachedHelper.getData(key: languageKey));
    } else {
      localLanguage = 'ar';
      CachedHelper.setData(key: languageKey, value: localLanguage);
      print('1111111111111111111$localLanguage');
      print(CachedHelper.getData(key: languageKey));
    }
  }
}
