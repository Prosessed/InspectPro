import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Parameter extends StatelessWidget {
  const Parameter({
    super.key,
    required this.parameterTitle,
  });

  final String parameterTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      child: Text(
        parameterTitle,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
