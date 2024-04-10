import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/features/authentication/views/resetpassword/controllers/reset_password_controller.dart';
import 'package:processed/features/authentication/views/resetpassword/screens/reset_password.dart';
import 'package:processed/features/authentication/views/signup/screens/crate_new_password.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class ForgotEmail extends StatelessWidget {
  ForgotEmail({super.key});

  ResetPasswordController resetPasswordController =
      Get.put(ResetPasswordController());

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
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Forgot Password',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text(
                        'Recover your account password',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email*',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  controller: resetPasswordController.resetPasswordEmail,
                  decoration: InputDecoration(
                      hintText: 'Enter your Email Address',
                      hintStyle: Theme.of(context).textTheme.labelMedium,
                      labelStyle: TextStyle(fontSize: 12.sp),
                      prefixIcon: const Icon(Iconsax.direct_right),
                      labelText: 'Enter your Email Address'),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => ResetPassword());
                },
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
