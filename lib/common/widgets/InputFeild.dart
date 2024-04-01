import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputItem extends StatelessWidget {
  const InputItem(
      {super.key,
      required this.placeHolder,
      required this.footerHolder,
      required this.controller});

  final String placeHolder;
  final String footerHolder;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10.sp),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintStyle: const TextStyle(color: Colors.grey),
              label: Text(placeHolder),
              border: const OutlineInputBorder(),
              hintText: placeHolder,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 30.w),
          child: Text(
            footerHolder,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}
