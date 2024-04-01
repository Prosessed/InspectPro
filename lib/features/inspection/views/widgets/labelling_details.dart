import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:processed/common/widgets/upload_button.dart';
import 'package:processed/common/widgets/uploaded_image.dart';
import 'package:processed/features/inspection/controllers/InspectionController.dart';
import 'package:processed/features/inspection/widgets/parameter_title.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/constants/text_strings.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class LabellingDetails extends StatelessWidget {
  const LabellingDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Parameter(parameterTitle: '4. ${TTexts.labelling}'),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.all(TSizes.defaultSpace - 18),
              child: Text(
                '${TTexts.countryNutrition} ',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        InspectionController
                            .instance.isNutritionalContent.value = true;
                      },
                      child: Container(
                        width: 80.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: InspectionController
                                  .instance.isNutritionalContent.value
                              ? isDark
                                  ? TColors.primary
                                  : TColors.primary
                              : null,
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: isDark ? TColors.primary : TColors.black,
                          ),
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        child: Center(
                          child: Text(
                            'Yes',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    GestureDetector(
                      onTap: () {
                        InspectionController
                            .instance.isNutritionalContent.value = false;
                      },
                      child: Container(
                        width: 80.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: !InspectionController
                                  .instance.isNutritionalContent.value
                              ? isDark
                                  ? TColors.primary
                                  : TColors.primary
                              : null,
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: isDark ? TColors.primary : TColors.black,
                          ),
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        child: Center(
                          child: Text(
                            'No',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: TSizes.spaceBtwSections),
            GestureDetector(
              onTap: () => {},
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.h),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UploadButton(
                      imagePath: InspectionController.instance.labelContentPath,
                    ),
                    Obx(() => InspectionController.instance.labelContentPath
                            .toString()
                            .isNotEmpty
                        ? UploadedImage(
                            uploadedImagePath: InspectionController
                                .instance.labelContentPath.value)
                        : const SizedBox.shrink()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
