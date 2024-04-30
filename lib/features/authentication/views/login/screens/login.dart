import 'package:flutter/material.dart';
import 'package:processed/common/styles/spacing_styles.dart';
import 'package:processed/features/authentication/views/login/widgets/login_form.dart';
import 'package:processed/features/authentication/views/login/widgets/login_header.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: AppSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoginHeader(isDark: isDark),
                const LoginForm(),
                // const DividerComponent(
                //   dividerText: TTexts.orSignInWith,
                // ),
                // const SizedBox(
                //   height: TSizes.spaceBtwSections,
                // ),
                // const SocialButtons()
              ],
            )),
      ),
    );
  }
}
