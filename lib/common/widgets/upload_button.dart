import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/features/inspection/controllers/InspectionController.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class UploadButton extends StatelessWidget {
  final RxString imagePath;
  const UploadButton({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => showUploadOptions(context, imagePath),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        height: 20.h,
        width: 134.w,
        child: Row(
          children: [
            Icon(
              Icons.cloud_upload,
              color: isDark ? TColors.primary : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

void showUploadOptions(BuildContext context, RxString imagePath) {
  Get.dialog(AlertDialog(
    title: Text(
      "Upload Options",
      style: Theme.of(context).textTheme.titleMedium,
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Iconsax.gallery),
          title: const Text('Gallery'),
          onTap: () async {
            await InspectionController.instance.pickImageFromGallery(imagePath);

            Get.back();
          },
        ),
        ListTile(
          leading: const Icon(Iconsax.camera),
          title: const Text('Camera'),
          onTap: () async {
            await InspectionController.instance.pickImageFromCamera(imagePath);

            Get.back();
          },
        ),
      ],
    ),
  ));
}
