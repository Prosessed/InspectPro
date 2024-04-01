import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:processed/features/authentication/controllers/splash_controller.dart';
import 'package:processed/utils/constants/image_strings.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    SplashController splashController = Get.put(SplashController());
    return Scaffold(
      body: GetBuilder<SplashController>(
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                TImages.appLogo,
                height: 150.h,
              )),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: const Text(
                      'Prosessed',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: const Text(
                        'Next-Generation Global \nProcurement Platform',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
