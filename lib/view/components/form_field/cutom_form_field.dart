import 'package:xmovie/view/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final Widget? sufix;
  final TextInputType ketboardType;

  const CustomFormField({
    super.key,
    required this.hint,
    required this.controller,
    this.sufix,
    this.ketboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Style.primaryColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Style.primaryColor)),
        constraints: BoxConstraints.tightFor(height: 35.h),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
        suffixIcon: sufix,
      ),
      keyboardType: ketboardType,
    );
  }
}
