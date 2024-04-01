import 'package:flutter/material.dart';
import 'package:processed/features/authentication/controllers/onboardingcontroller.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/device/device_utility.dart';
import 'package:processed/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DotIndicators extends StatelessWidget {
  const DotIndicators({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final isDark = THelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: TSizes.defaultSpace,
      child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClicked,
          count: 3,
          effect: ExpandingDotsEffect(
              activeDotColor: isDark ? TColors.light : TColors.black,
              dotHeight: 6)),
    );
  }
}
