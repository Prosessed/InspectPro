import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/features/authentication/views/login/screens/login.dart';
import 'package:processed/features/authentication/views/resetpassword/controllers/reset_password_controller.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  ResetPasswordController resetPasswordController =
      Get.find<ResetPasswordController>();
  ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: TColors.grey)),
              child: Center(
                child: Icon(Iconsax.arrow_left,
                    color: isDark ? TColors.white : TColors.primary),
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Column(
                    children: [
                      Center(
                        child: Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                          child: Icon(
                            Icons.done,
                            color: isDark ? Colors.white : Colors.black,
                            size: 32.sp,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.inputFieldRadius,
                      ),
                      Center(
                        child: Text(
                          'Instructions sent successfully to ${resetPasswordController.resetPasswordEmail.text}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.inputFieldRadius,
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 5.h),
                          child: Text(
                            'Open your inbox & create a new password',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      SizedBox(
                        width: 200.w,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => const LoginScreen());
                          },
                          child: const Text('Continue'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
