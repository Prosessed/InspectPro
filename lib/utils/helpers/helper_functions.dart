import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class THelperFunctions {
  static void showSnackBar(String? desc, BuildContext context, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // behavior: SnackBarBehavior.floating,
        content: Container(
          decoration: BoxDecoration(
              color: isSuccess ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(20.sp)),

          width: 80.w, // Set your desired fixed width
          height: 50.h, // Set your desired small height
          child: Center(
            child: FittedBox(
              child: Text(
                desc!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
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

  static bool isValidPassword(String password) {
    // Define the requirements
    int minLength = 6;
    int uppercaseCharCount = 1;
    int lowercaseCharCount = 2;
    int numericCharCount = 3;
    int specialCharCount = 1;

    // Check the length
    if (password.length < minLength) {
      return false;
    }

    // Count uppercase, lowercase, numeric, and special characters
    int uppercaseChars = password.replaceAll(RegExp(r'[^A-Z]'), '').length;
    int lowercaseChars = password.replaceAll(RegExp(r'[^a-z]'), '').length;
    int numericChars = password.replaceAll(RegExp(r'[^0-9]'), '').length;
    int specialChars = password.replaceAll(RegExp(r'[A-Za-z0-9]'), '').length;

    // Check if the counts meet the requirements
    if (uppercaseChars >= uppercaseCharCount &&
        lowercaseChars >= lowercaseCharCount &&
        numericChars >= numericCharCount &&
        specialChars >= specialCharCount) {
      return true;
    } else {
      return false;
    }
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }
}
