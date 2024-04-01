import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:processed/utils/constants/sizes.dart';

class FormInputFeild extends StatelessWidget {
  const FormInputFeild(
      {super.key,
      required this.controller,
      required this.labelText,
      this.isNumber = true,
      required this.icon});

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 300.w,
      // height: 60.h,
      margin: const EdgeInsets.all(TSizes.defaultSpace - 18),
      child: TextFormField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: Icon(icon),
            labelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            )),
      ),
    );
  }
}
