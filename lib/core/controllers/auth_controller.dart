import 'package:get/get.dart';
import 'package:unico/utils/shared_preference.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  var isLoading = false.obs;

  signInWithMail() async {
    isLoading.value = true;
  }

  logout() async {
    await prefs?.clear();
  }
}
