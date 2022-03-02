import 'package:get/get.dart';
import 'package:mohtaref_client/controller/language_helper/language_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageController());
  }
}
