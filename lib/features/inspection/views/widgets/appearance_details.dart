import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/common/widgets/circular_container_component.dart';
import 'package:processed/common/widgets/upload_button.dart';
import 'package:processed/common/widgets/uploaded_image.dart';
import 'package:processed/features/inspection/controllers/InspectionController.dart';
import 'package:processed/features/inspection/views/widgets/form_feild.dart';
import 'package:processed/features/inspection/widgets/parameter_title.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/constants/text_strings.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class AppearanceDetails extends StatelessWidget {
  const AppearanceDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Parameter(
              parameterTitle: '5. ${TTexts.appearance}',
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 3; i++)
                    CircularContainerComponent(
                      margin: const EdgeInsets.only(right: 10),
                      width: 20.w,
                      backgroundColor:
                          InspectionController.instance.carouselIndex.value == i
                              ? TColors.primary
                              : TColors.grey,
                      height: 20.h,
                    )
                ],
              ),
            ),
          ],
        ),
        FormInputFeild(
            controller: InspectionController.instance.riceLengthController,
            labelText: TTexts.lengthOfGrain,
            icon: Iconsax.ruler),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        GestureDetector(
          onTap: () => {},
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 5.h),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UploadButton(
                  imagePath: InspectionController.instance.lengthImageFilePath,
                ),

                // -- Export Quality Image

                Obx(() => InspectionController.instance.lengthImageFilePath
                        .toString()
                        .isNotEmpty
                    ? UploadedImage(
                        uploadedImagePath: InspectionController
                            .instance.lengthImageFilePath.value)
                    : const SizedBox.shrink()),
              ],
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        FormInputFeild(
            controller:
                InspectionController.instance.allowancePercentageController,
            labelText: TTexts.allowancePercentage,
            icon: Iconsax.percentage_square),
      ],
    );
  }
}
