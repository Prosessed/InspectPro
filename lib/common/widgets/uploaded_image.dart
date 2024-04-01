import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadedImage extends StatelessWidget {
  const UploadedImage({
    super.key,
    required this.uploadedImagePath,
  });

  final String uploadedImagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      width: 80.w,
      height: 50.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.sp)),
          image: DecorationImage(
              fit: BoxFit.fill, image: FileImage(File(uploadedImagePath)))),
    );
  }
}
