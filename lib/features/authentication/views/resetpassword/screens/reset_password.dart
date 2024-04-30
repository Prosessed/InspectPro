import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/common/widgets/success.dart';
import 'package:processed/features/authentication/controllers/signup_controller.dart';
import 'package:processed/features/authentication/views/resetpassword/controllers/reset_password_controller.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  ResetPasswordController resetPasswordController =
      Get.put(ResetPasswordController());
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
      body: SingleChildScrollView(
        child: Padding(
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
                          'Setting a new password',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Password*',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  Obx(
                    () => TextFormField(
                      controller: resetPasswordController.newPasswordController,
                      obscureText:
                          resetPasswordController.isPasswordVisible.value,
                      // controller: signUpController.passwordController,
                      decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.labelMedium,
                          prefixIcon: const Icon(Iconsax.password_check4),
                          suffixIcon: GestureDetector(
                              onTap: () => resetPasswordController
                                  .togglePasswordVisibility(),
                              child: Icon(
                                resetPasswordController.isPasswordVisible.value
                                    ? Iconsax.eye_slash
                                    : Iconsax.eye,
                              )),
                          labelText: 'Enter new password'),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  // SizedBox(
                  //   height: 150.h,
                  //   child: FlutterPwValidator(
                  //     // controller: signUpController.passwordController,
                  //     minLength: 6,
                  //     uppercaseCharCount: 1,
                  //     lowercaseCharCount: 2,
                  //     numericCharCount: 3,
                  //     specialCharCount: 1,
                  //     width: 300.w,
                  //     height: 100.h,
                  //     onSuccess: () => {},
                  //     onFail: () => {},
                  //   ),
                  // )
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirm Password*',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  Obx(
                    () => TextFormField(
                      controller:
                          resetPasswordController.confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid password!';
                        }
                        return null;
                      },
                      obscureText: resetPasswordController
                          .isConfirmPasswordVisible.value,
                      decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.labelMedium,
                          prefixIcon: const Icon(Iconsax.password_check4),
                          suffixIcon: GestureDetector(
                              onTap: () => resetPasswordController
                                  .toggleConfirmPasswordVisibility(),
                              child: Icon(
                                resetPasswordController
                                        .isConfirmPasswordVisible.value
                                    ? Iconsax.eye_slash
                                    : Iconsax.eye,
                              )),
                          labelText: 'Confirm your password'),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // signUpController.signUp();
                    resetPasswordController.resetPassword();
                  },
                  child: const Text('Reset Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
