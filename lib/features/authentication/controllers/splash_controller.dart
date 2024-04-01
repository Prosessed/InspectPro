import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:processed/features/authentication/views/login/screens/login.dart';
import 'package:processed/features/authentication/views/onboarding/screens/onboarding.dart';
import 'package:processed/navigation_menu.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    // Check if the user has seen the boarding screens before

    // Navigate to the appropriate screen
    Timer(const Duration(seconds: 3), () async {
      // checkFirstSeen();
      checkFirstSeen();
    });
  }

  Future<void> checkFirstSeen() async {
    bool seen = GetStorage().read('seen') ?? false;

    if (seen) {
      // If the user has already seen the onboarding screen, go to the login page

      if (GetStorage().read('isLoggedIn') == true) {
        Get.off(const NavigationMenu());
      } else {
        Get.off(const LoginScreen());
      }
    } else {
      // If the user has not seen the onboarding screen, go to the onboarding screen
      GetStorage().write('seen', true);
      Get.off(OnBoardingScreen());
    }
  }
}
