import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:processed/utils/constants/sizes.dart';

class THelperFunctions {
  static void showSnackBar(String? message, String? desc, BuildContext context,
      ContentType contentType) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // behavior: SnackBarBehavior.floating,
        content: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: AwesomeSnackbarContent(
            title: message!,
            message: desc!,

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: contentType,
            // to configure for material banner
            // inMaterialBanner: true,
          ),
        )));
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }
}
