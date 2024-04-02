import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/image_strings.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class SuccessAlertDialog extends StatelessWidget {
  SuccessAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return AlertDialog(
      content: Container(
        width: 250.w,
        height: 300.h,
        decoration: BoxDecoration(
          // border: Border.all(color: TColors.white),s
          borderRadius: const BorderRadius.all(
            Radius.circular(TSizes.borderRadiusLg + 4),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Iconsax.tick_circle,
              size: 30.sp,
              color: TColors.primary,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              'Success',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'Your password is succesfully changed',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Container(
              decoration: BoxDecoration(
                color: TColors.primary,
                borderRadius: BorderRadius.all(Radius.circular(5.sp)),
              ),
              width: 123.w,
              height: 46.h,
              child: Center(
                child: Text(
                  'Continue',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
