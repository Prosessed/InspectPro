import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/image_strings.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.w,
              child: Image.asset(TImages.otp),
            ),
            Text(
              'OTP Verification',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text.rich(
              TextSpan(
                text: 'Enter the OTP sent to ',
                style: Theme.of(context).textTheme.bodyMedium,
                children: const [
                  TextSpan(
                    text: '+91 987987XXXX',
                    style: TextStyle(
                      color: TColors.primary, // Example color, change as needed
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            OtpTextField(
              numberOfFields: 5,
              enabledBorderColor: isDark ? TColors.white : TColors.grey,
              disabledBorderColor: isDark ? TColors.white : TColors.grey,
              borderColor: TColors.primary,
              focusedBorderColor: TColors.primary,
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                      );
                    });
              }, // end onSubmit
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Text.rich(
              TextSpan(
                text: 'Didn’t you receive the OTP? ',
                style: Theme.of(context).textTheme.bodyMedium,
                children: const [
                  TextSpan(
                    text: 'Resend OTP',
                    style: TextStyle(
                      color: TColors.primary, // Example color, change as needed
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => const OtpVerification());
                  },
                  child: const Text('Verify'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
