import 'package:xmovie/view/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormFieldSend extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final Widget? sufix;
  final Widget? perfix;
  final int maxLine;
  final double height;
  final Color filledColor;
  final TextInputType keyBoardType;
  final Function(String)? onChanged;

  const CustomTextFormFieldSend(
      {super.key,
        required this.hint,
        this.controller,
        this.sufix,
        this.perfix,
        this.onChanged,
        this.filledColor=Style.ttColor,
        this.keyBoardType = TextInputType.text,
        this.maxLine=1,
        this.height=40
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyBoardType,
      maxLines:maxLine,
      style: Style.inputStyle(color: Style.whiteColor.withOpacity(0.8)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Style.hintStyle(),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none),
        fillColor: filledColor,
        filled: true,
        constraints: BoxConstraints.tightFor(height:height.h),
        contentPadding: EdgeInsets.only(left: 10.w,right:10.w),
        suffixIcon: sufix,
        prefixIcon: perfix,
      ),
    );
  }
}
