import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/features/inspection/controllers/InspectionController.dart';
import 'package:processed/features/inspection/views/widgets/appearance_details.dart';
import 'package:processed/features/inspection/views/widgets/chemical_details.dart';
import 'package:processed/features/inspection/views/widgets/compilance_details.dart';
import 'package:processed/features/inspection/views/widgets/design_details.dart';
import 'package:processed/features/inspection/views/widgets/form_feild.dart';
import 'package:processed/features/inspection/views/widgets/labelling_details.dart';
import 'package:processed/features/inspection/views/widgets/packaging_details.dart';
import 'package:processed/features/inspection/views/widgets/physical_details.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class InspectionDetails extends StatelessWidget {
  const InspectionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    InspectionController controller = Get.put(InspectionController());
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: () {
                controller.createDraft();

                _saveData(controller, context);
              },
              child: Icon(
                Icons.drafts_outlined,
                color: isDark ? TColors.primary : TColors.white,
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: isDark
            ? GestureDetector(
                onTap: () {
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
              controller.inspectionTemplateValue.value.toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PhysicalDetails(),

                const SizedBox(height: TSizes.spaceBtwSections),

                const ChemicalDetails(),

                const SizedBox(height: TSizes.spaceBtwSections),
                const PackagingDetails(),

                const SizedBox(height: TSizes.spaceBtwInputFields),

                FormInputFeild(
                    controller:
                        InspectionController.instance.noOfLayersController,
                    labelText: 'No. of Layers',
                    icon: Iconsax.data),

                const SizedBox(height: TSizes.spaceBtwSections),

                // labelling
                const LabellingDetails(),

                const SizedBox(height: TSizes.spaceBtwSections),

                const AppearanceDetails(),

                const SizedBox(height: TSizes.spaceBtwSections),

                DesignDetails(context),

                const SizedBox(height: TSizes.spaceBtwSections),

                const CompilanceDetails()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _saveData(
  InspectionController controller,
  BuildContext context,
) async {
  controller.isLoading.value = true; // Start loading

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
            Text('Saving as Draft...',
                style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    ),
  );
}
