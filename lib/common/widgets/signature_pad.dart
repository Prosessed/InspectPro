import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:processed/common/controllers/signature_pad_controller.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/helpers/helper_functions.dart';
import 'package:signature/signature.dart';

class SignaturePad extends StatelessWidget {
  SignaturePadController controller = Get.put(SignaturePadController());

  SignaturePad({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    controller.signatureController = SignatureController(
      penStrokeWidth: 5,
      penColor: isDark ? TColors.white : TColors.black,
    );

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: isDark ? TColors.white : TColors.black,
            ),
          ),
          title: const Text('Draw your Signature below '),
          actions: [
            IconButton(
              tooltip: 'Save',
              onPressed: () {
                controller.exportImage(context);
                Get.back();
                // controller.signatureController.toPngBytes();
              },
              icon: Icon(
                Icons.upload,
                size: 25.sp,
                color: TColors.primary,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  border: Border.all(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                child: Signature(
                  width: 300.w,
                  height: 500.h,
                  controller: controller.signatureController,
                  backgroundColor: isDark ? Colors.transparent : Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SignatureIcon(
                    controller: controller,
                    icon: Icons.undo,
                    onPressed: () {
                      controller.signatureController.undo();
                    },
                  ),
                  SignatureIcon(
                    controller: controller,
                    icon: Icons.clear,
                    onPressed: () {
                      controller.signatureController.clear();
                    },
                  ),
                  SignatureIcon(
                      controller: controller,
                      icon: Icons.redo,
                      onPressed: () {
                        controller.signatureController.redo();
                      }),
                ],
              ),
            ],
          ),
        ));
  }
}

class SignatureIcon extends StatelessWidget {
  const SignatureIcon({
    super.key,
    required this.controller,
    required this.icon,
    required this.onPressed,
  });

  final SignaturePadController controller;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return FloatingActionButton(
      backgroundColor: isDark ? Colors.purple : TColors.primary,
      onPressed: () {
        onPressed();
        // controller.signatureController.undo();
      },
      child: Icon(
        icon,
        color: isDark ? TColors.white : TColors.black,
      ),
    );
  }
}
