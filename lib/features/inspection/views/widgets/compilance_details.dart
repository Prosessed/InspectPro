import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/common/widgets/signature_pad.dart';
import 'package:processed/common/widgets/upload_button.dart';
import 'package:processed/common/widgets/uploaded_image.dart';
import 'package:processed/features/inspection/controllers/InspectionController.dart';
import 'package:processed/features/inspection/views/widgets/form_feild.dart';
import 'package:processed/features/inspection/widgets/parameter_title.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/constants/text_strings.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class CompilanceDetails extends StatelessWidget {
  const CompilanceDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Parameter(parameterTitle: '7. ${TTexts.complicance}'),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16.h),
          child: Text(
            TTexts.certifcates,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        FormInputFeild(
            isNumber: false,
            controller: InspectionController.instance.certificatesController,
            labelText: TTexts.complicance,
            icon: Iconsax.book),

        // -- Complicance Image

        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        GestureDetector(
          onTap: () => {},
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UploadButton(
                  imagePath:
                      InspectionController.instance.complicanceContentImagePath,
                ),

                // -- Export Quality Image

                Obx(() => InspectionController
                        .instance.complicanceContentImagePath
                        .toString()
                        .isNotEmpty
                    ? UploadedImage(
                        uploadedImagePath: InspectionController
                            .instance.complicanceContentImagePath.value)
                    : const SizedBox.shrink()),
              ],
            ),
          ),
        ),

        // upload signature button

        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Get.to(() => SignaturePad(), transition: Transition.zoom);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.green,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.h),
                child: Text(
                  'Signature',
                  style: TextStyle(
                      color: isDark ? TColors.white : TColors.black,
                      fontSize: 13.0),
                ),
              ),
            ),

            Obx(
              () => Container(
                width: THelperFunctions.screenWidth() * 0.6,
                height: THelperFunctions.screenHeight() * 0.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.memory(
                                InspectionController.instance.signature.value)
                            .image)),
              ),
            )

            // upload signature button
          ],
        )
      ],
    );
  }
}
