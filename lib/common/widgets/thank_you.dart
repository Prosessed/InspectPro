import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lottie/lottie.dart';
import 'package:processed/common/controllers/thankyou_controller.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class ThankyouScreen extends StatelessWidget {
  const ThankyouScreen({super.key, required this.message, required this.title});

  final String message;
  final String title;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    ThankyouController thankyouController = Get.put(ThankyouController());
    return Scaffold(
      body: GetBuilder<ThankyouController>(
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset(
                  'assets/images/animations/thankyouanim.json',
                  width: THelperFunctions.screenHeight(),
                  height: THelperFunctions.screenWidth(),
                  fit: BoxFit.fill,
                ),
              ),

              // thank you for submitting text

              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: Text(title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
