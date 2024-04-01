import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/common/widgets/upload_button.dart';
import 'package:processed/features/inspection/controllers/InspectionController.dart';
import 'package:processed/features/inspection/views/widgets/form_feild.dart';
import 'package:processed/features/inspection/widgets/parameter_title.dart';
import 'package:processed/utils/constants/text_strings.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/uploaded_image.dart';

class ChemicalDetails extends StatelessWidget {
  const ChemicalDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Parameter(
          parameterTitle: '2. ${TTexts.chemical}',
        ),
        FormInputFeild(
          controller: InspectionController.instance.brokenPercentageController,
          labelText: TTexts.brokenPercentage,
          icon: Iconsax.percentage_square,
        ),
        SizedBox(height: 16.h),
        GestureDetector(
          onTap: () => {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UploadButton(
                imagePath: InspectionController.instance.brokenContentImagePath,
              ),
              Obx(() => InspectionController
                      .instance.brokenContentImagePath.value.isNotEmpty
                  ? UploadedImage(
                      uploadedImagePath: InspectionController
                          .instance.brokenContentImagePath.value,
                    )
                  : const SizedBox.shrink())
            ],
          ),
        ),
      ],
    );
  }
}
