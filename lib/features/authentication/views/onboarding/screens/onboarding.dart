import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:processed/features/authentication/controllers/onboardingcontroller.dart';
import 'package:processed/features/authentication/views/onboarding/widgets/dot_indicators.dart';
import 'package:processed/features/authentication/views/onboarding/widgets/onboarding_next_button.dart';
import 'package:processed/features/authentication/views/onboarding/widgets/onboarding_page.dart';
import 'package:processed/features/authentication/views/onboarding/widgets/skip_button.dart';
import 'package:processed/utils/constants/image_strings.dart';
import 'package:processed/utils/constants/text_strings.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final OnBoardingController onBoardingController =
      Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: onBoardingController.pageController,
            onPageChanged: (value) => onBoardingController.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: isDark
                    ? TImages.onboardingImage1Dark
                    : TImages.onboardingImage1,
                title: TTexts.onBoardingTitle1,
                subtitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: isDark
                    ? TImages.onboardingImage2Dark
                    : TImages.onboardingImage2,
                title: TTexts.onBoardingTitle2,
                subtitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: isDark
                    ? TImages.onboardingImage3Dark
                    : TImages.onboardingImage3,
                title: TTexts.onBoardingTitle3,
                subtitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          const SkipButton(),
          const DotIndicators(),
          const OnboardingNextButton(),
        ],
      ),
    );
  }
}
