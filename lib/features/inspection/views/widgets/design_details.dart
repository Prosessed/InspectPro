import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:processed/common/widgets/upload_button.dart';
import 'package:processed/common/widgets/uploaded_image.dart';
import 'package:processed/features/inspection/controllers/InspectionController.dart';
import 'package:processed/features/inspection/widgets/parameter_title.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/constants/text_strings.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

Column DesignDetails(BuildContext context) {
  final isDark = THelperFunctions.isDarkMode(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Parameter(parameterTitle: '6. ${TTexts.design}'),
      Obx(
        () => DropdownSearch<String>(
          popupProps: PopupProps.dialog(
            fit: FlexFit.loose,
            dialogProps: DialogProps(
              backgroundColor: isDark ? Colors.black : Colors.white,
            ),
          ),
          selectedItem: InspectionController.instance.riceColor.value,
          items: InspectionController.instance.riceColorOptions,
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(),
          ),
        ),
      ),
      // -- Rice Colour Image

      const SizedBox(height: TSizes.spaceBtwSections),
      GestureDetector(
        onTap: () => {},
        child: Container(
          // margin: EdgeInsets.symmetric(horizontal: 5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UploadButton(
                imagePath: InspectionController.instance.riceColourImagePath,
              ),

              // -- Export Quality Image

              Obx(() => InspectionController.instance.riceColourImagePath
                      .toString()
                      .isNotEmpty
                  ? UploadedImage(
                      uploadedImagePath: InspectionController
                          .instance.riceColourImagePath.value)
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    ],
  );
}
