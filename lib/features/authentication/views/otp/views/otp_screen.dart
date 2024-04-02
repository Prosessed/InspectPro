import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/features/authentication/views/otp/views/otp_verification.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/image_strings.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
            Text(
              'We will send you one-time password \nto your mobile number',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Text(
              'Enter Mobile Number',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    prefixIcon: const Icon(Iconsax.call),
                    labelText: 'Mobile Number*'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => const OtpVerification());
                  },
                  child: const Text('Get OTP'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
