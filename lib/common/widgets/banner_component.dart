import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class BannerComponent extends StatelessWidget {
  const BannerComponent(
      {super.key,
      this.width = 300,
      this.height = 150,
      required this.imageUrl,
      this.applyBorderRadius = true,
      this.fit = BoxFit.contain,
      this.padding,
      this.isNetworkImage = false,
      this.onTap,
      this.border,
      this.borderRadius = TSizes.md});

  final double? width, height;
  final String imageUrl;
  final bool applyBorderRadius;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onTap;
  final BoxBorder? border;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            border: Border.all(
                color: isDark ? TColors.grey : TColors.black, width: 0.2),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: ClipRRect(
          borderRadius: applyBorderRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.circular(0),
          child: Image.asset(
            height: 200.h,
            width: 200.w,
            imageUrl,
          ),
        ),
      ),
    );
  }
}
