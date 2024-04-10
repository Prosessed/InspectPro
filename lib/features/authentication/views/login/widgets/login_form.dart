import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
import 'package:processed/utils/helpers/helper_functions.dart';
import 'package:processed/utils/http/http_client.dart';
import 'package:processed/utils/validators/validators.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: TSizes.spaceBtwSections),
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !AppValidations.isValidEmail(value)) {
                          return 'Please enter a valid email address';
                        }
                      },
                      controller: authController.emailController,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                            fontSize: 10.sp,
                          ),
                          labelStyle: TextStyle(fontSize: 12.sp),
                          prefixIcon: const Icon(Iconsax.direct_right),
                          labelText: TTexts.email),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    Obx(() => TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid password';
                            }
                            return null;
                          },
                          obscureText: authController.isPasswordVisible.value,
                          controller: authController.passwordController,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(
                                fontSize: 10.sp,
                              ),
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
                      onTap: () => Get.to(ForgotEmail()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password ?',
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
                          if (_formKey.currentState!.validate()) {
                            authController.loginWithEmailAndPassword(
                                authController.emailController.text,
                                authController.passwordController.text);
                          } else {
                            THelperFunctions.showSnackBar(
                                'Oops!',
                                'Email or Password cannot be empty',
                                Get.context!,
                                ContentType.failure);
                          }
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
              )),
        ],
      ),
    );
  }
}
