import 'package:flutter/material.dart';
import 'package:processed/utils/constants/colors.dart';

class CircularContainerComponent extends StatelessWidget {
  const CircularContainerComponent({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.padding = 0,
    this.radius = 400,
    this.margin,
    this.backgroundColor = TColors.white,
  });

  final double? width, height;
  final double padding;
  final Color? backgroundColor;
  final Widget? child;
  final double radius;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(radius)),
      child: child,
    );
  }
}
