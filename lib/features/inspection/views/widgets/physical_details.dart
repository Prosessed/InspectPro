import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

class PhysicalDetails extends StatelessWidget {
  const PhysicalDetails({
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
              parameterTitle: '1. ${TTexts.physical}',
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
            )
          ],
        ),
        FormInputFeild(
          controller: InspectionController.instance.moistureController,
          labelText: TTexts.moisturePercentage,
          icon: Iconsax.percentage_square,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        GestureDetector(
          onTap: () => {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UploadButton(
                imagePath:
                    InspectionController.instance.moistureContentImagePath,
              ),
              Obx(() => InspectionController.instance.moistureContentImagePath
                      .toString()
                      .isNotEmpty
                  ? UploadedImage(
                      uploadedImagePath: InspectionController
                          .instance.moistureContentImagePath.value)
                  : const SizedBox.shrink()),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        FormInputFeild(
          controller: InspectionController.instance.sortexController,
          labelText: TTexts.sortexPercentage,
          icon: Iconsax.percentage_square,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        GestureDetector(
          onTap: () => {},
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UploadButton(
                  imagePath:
                      InspectionController.instance.sortexPercentageImagePath,
                ),
                Obx(() => InspectionController
                        .instance.sortexPercentageImagePath
                        .toString()
                        .isNotEmpty
                    ? UploadedImage(
                        uploadedImagePath: InspectionController
                            .instance.sortexPercentageImagePath.value)
                    : const SizedBox.shrink()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
