import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/common/widgets/masterapp_button.dart';
import 'package:processed/common/widgets/save_draft_button.dart';
import 'package:processed/features/dashboard/controllers/homecontroller.dart';
import 'package:processed/features/inspection/controllers/InspectionController.dart';
import 'package:processed/features/inspection/views/widgets/appearance_details.dart';
import 'package:processed/features/inspection/views/widgets/compilance_details.dart';
import 'package:processed/features/inspection/views/widgets/design_details.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class InspectionPartThree extends StatelessWidget {
  const InspectionPartThree({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          HomeController.instance.isSaveEnabled.value
              ? const SaveDraftButton()
              : const SizedBox.shrink()
        ],
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
                  color: isDark ? TColors.white : TColors.black,
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
            child: Column(children: [
              const AppearanceDetails(),
              const SizedBox(height: TSizes.spaceBtwSections),
              DesignDetails(context),
              const SizedBox(height: TSizes.spaceBtwSections),
              const CompilanceDetails(),
              const SizedBox(height: TSizes.spaceBtwSections),
              MasterAppButton(
                  hintText: 'Submit Inspection',
                  onPressed: () {
                    if (InspectionController.instance.signature.value.isEmpty) {
                      THelperFunctions.showSnackBar(
                          'Please upload signature', context, false);
                      return;
                    } else {
                      InspectionController.instance.createInspectionForm();
                      // ignore: unrelated_type_equality_checks
                      InspectionController.instance.isLoading == true
                          ? _saveData(context)
                          : null;
                    }
                  })
            ]),
          ),
        ),
      ),
    );
  }
}

void _saveData(
  BuildContext context,
) async {
  InspectionController.instance.isLoading.value = true; // Start loading

  // Show the loading dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => Dialog(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            SizedBox(height: 20.h),
            Text('Creating Inspection...',
                style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    ),
  );
}
