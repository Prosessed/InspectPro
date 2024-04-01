import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:processed/features/authentication/views/login/screens/login.dart';
import 'package:processed/navigation_menu.dart';

class ThankyouController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // Check if the user has seen the boarding screens before

    Timer(const Duration(seconds: 4), () {
      if (GetStorage().read('user_email') == null) {
        Get.off(() => const LoginScreen());
      } else {
        Get.until((route) => route.isFirst);
        Get.off(() => const NavigationMenu());
      }
    });
  }
}
