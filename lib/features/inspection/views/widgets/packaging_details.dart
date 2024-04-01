import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

class PackagingDetails extends StatelessWidget {
  const PackagingDetails({
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
              parameterTitle: '3. ${TTexts.packaging}',
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
        )

        // -- Packaging
        ,

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(TSizes.defaultSpace - 18),
              child: Text(
                '${TTexts.doesExportQuality} ',
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
                        InspectionController.instance.isExportQuality.value =
                            true;
                      },
                      child: Container(
                        width: 80.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: InspectionController
                                  .instance.isExportQuality.value
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
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    GestureDetector(
                      onTap: () {
                        InspectionController.instance.isExportQuality.value =
                            false;
                      },
                      child: Container(
                        width: 80.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: !InspectionController
                                  .instance.isExportQuality.value
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

            // -- Export Quality Image

            const SizedBox(height: TSizes.spaceBtwSections),
            GestureDetector(
              onTap: () => {},
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.h),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UploadButton(
                      imagePath:
                          InspectionController.instance.exportQualityImagePath,
                    ),

                    // -- Export Quality Image

                    Obx(() => InspectionController
                            .instance.exportQualityImagePath
                            .toString()
                            .isNotEmpty
                        ? UploadedImage(
                            uploadedImagePath: InspectionController
                                .instance.exportQualityImagePath.value)
                        : const SizedBox.shrink()),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwSections),

        Container(
          margin: const EdgeInsets.all(TSizes.defaultSpace - 18),
          child: Text(
            '${TTexts.noOfLayers} ',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwInputFields),

        FormInputFeild(
          controller: InspectionController.instance.noOfLayersController,
          labelText: TTexts.noOfLayerstitle,
          icon: Iconsax.percentage_square,
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        GestureDetector(
          onTap: () => {},
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.h),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UploadButton(
                  imagePath: InspectionController.instance.noOfLayersImagePath,
                ),
                Obx(() => InspectionController.instance.noOfLayersImagePath
                        .toString()
                        .isNotEmpty
                    ? UploadedImage(
                        uploadedImagePath: InspectionController
                            .instance.noOfLayersImagePath.value)
                    : const SizedBox.shrink()),
              ],
            ),
          ),
        ),

        // -- Packaging Image

        // const SizedBox(height: TSizes.spaceBtwSections + 30),

        // no .of layer
      ],
    );
  }
}
