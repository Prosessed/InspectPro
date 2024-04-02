import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/common/widgets/success.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({super.key});

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
                      'Create a New Password',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text(
                        'Enter your new password',
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
                  'New Password*',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid password!';
                    }
                    return null;
                  },
                  // obscureText: authController.isPasswordVisible.value,
                  // controller: authController.passwordController,
                  decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.labelMedium,
                      prefixIcon: const Icon(Iconsax.password_check4),
                      // suffixIcon: GestureDetector(
                      //     onTap: () =>
                      //         authController.togglePasswordVisibility(),
                      //     child: Icon(
                      //       authController.isPasswordVisible.value
                      //           ? Iconsax.eye_slash
                      //           : Iconsax.eye,
                      //     )),
                      labelText: 'Enter new password'),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confirm Password*',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid password!';
                    }
                    return null;
                  },
                  // obscureText: authController.isPasswordVisible.value,
                  // controller: authController.passwordController,
                  decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.labelMedium,
                      prefixIcon: const Icon(Iconsax.password_check4),
                      // suffixIcon: GestureDetector(
                      //     onTap: () =>
                      //         // authController.togglePasswordVisibility(),
                      //     child: Icon(
                      //       authController.isPasswordVisible.value
                      //           ? Iconsax.eye_slash
                      //           : Iconsax.eye,
                      //     )),
                      labelText: 'Confirm your password'),
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
                  showDialog(
                      context: context,
                      builder: (ctxt) => new SuccessAlertDialog());
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
