import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/features/authentication/controllers/login_controller.dart';
import 'package:processed/features/authentication/views/resetpassword/screens/email_screen.dart';
import 'package:processed/features/authentication/views/signup/screens/signup_screen.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    GlobalKey<FormState> form = GlobalKey<FormState>();

    return Form(
        key: form,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                      return 'Enter a valid email!';
                    }
                    return null;
                  },
                  controller: authController.emailController,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 12.sp),
                      prefixIcon: const Icon(Iconsax.direct_right),
                      labelText: TTexts.email),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                Obx(() => TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid password!';
                        }
                        return null;
                      },
                      obscureText: authController.isPasswordVisible.value,
                      controller: authController.passwordController,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 12.sp),
                          prefixIcon: const Icon(Iconsax.password_check4),
                          suffixIcon: GestureDetector(
                              onTap: () =>
                                  authController.togglePasswordVisibility(),
                              child: Icon(
                                authController.isPasswordVisible.value
                                    ? Iconsax.eye_slash
                                    : Iconsax.eye,
                              )),
                          labelText: TTexts.password),
                    )),
                const SizedBox(height: TSizes.inputFieldRadius),
                GestureDetector(
                  onTap: () => Get.to(const ForgotEmail()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password',
                        style: Theme.of(context).textTheme.labelSmall,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      authController.loginWithEmailAndPassword(
                          authController.emailController.text,
                          authController.passwordController.text);
                    },
                    child: const Text(TTexts.signIn),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.to(() => const SignUpScreen());
                    },
                    child: const Text(TTexts.createAccount),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
