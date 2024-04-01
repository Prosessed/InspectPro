import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/common/widgets/masterapp_button.dart';
import 'package:processed/common/widgets/save_draft_button.dart';
import 'package:processed/features/dashboard/controllers/homecontroller.dart';
import 'package:processed/features/inspection/controllers/InspectionController.dart';
import 'package:processed/features/inspection/views/inspection_flow/inspection_part_three.dart';
import 'package:processed/features/inspection/views/widgets/labelling_details.dart';
import 'package:processed/features/inspection/views/widgets/packaging_details.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class InspectionPartTwo extends StatelessWidget {
  const InspectionPartTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          HomeController.instance.isSaveEnabled.value
              ? const SaveDraftButton()
              : const SizedBox.shrink()
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: isDark
            ? GestureDetector(
                onTap: () {
                  if (InspectionController.instance.carouselIndex.value != 0) {
                    InspectionController.instance.carouselIndex.value -= 1;
                  }

                  Get.back();
                },
                child: Icon(
                  isDark ? Iconsax.arrow_left_2 : Iconsax.arrow_left_2,
                  // size: 20.sp
                  color: isDark ? TColors.white : TColors.primary,
                ),
              )
            : null,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Inspection Template',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              InspectionController.instance.inspectionTemplateValue.value
                  .toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(TSizes.defaultSpace),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const PackagingDetails(),
              const SizedBox(height: TSizes.spaceBtwSections),
              const LabellingDetails(),
              const SizedBox(height: TSizes.spaceBtwSections),
              MasterAppButton(
                  hintText: 'Next',
                  onPressed: () {
                    if (InspectionController.instance.carouselIndex.value !=
                        2) {
                      InspectionController.instance.carouselIndex.value += 1;
                    }
                    Get.to(() => const InspectionPartThree());
                  })
            ]),
          ),
        ),
      ),
    );
  }
}
