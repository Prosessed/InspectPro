import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/features/authentication/views/otp/views/otp_screen.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/image_strings.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: TColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            icon: const Image(
              image: AssetImage(TImages.googlePay),
              width: TSizes.iconMd,
              height: TSizes.iconMd,
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(
          width: TSizes.md,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: TColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            icon: const Icon(Iconsax.call),
            onPressed: () {
              Get.to(() => const OtpScreen());
            },
          ),
        ),
      ],
    );
  }
}
