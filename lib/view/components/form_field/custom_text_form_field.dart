import 'package:xmovie/view/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final Widget? sufix;
  final Widget? perfix;
  final Color filledColor;
  final Color borderColor;
  final double heigth;
  final int maxLine;
  final TextCapitalization capitalization;
  final TextInputType keyBoardType;
  final bool obscure;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextFormField(
      {super.key,
      required this.hint,
      this.controller,
      this.sufix,
      this.perfix,
      this.onChanged,
        this.borderColor=Style.transperntcolor,
        this.filledColor=Style.ttColor,
        this.capitalization=TextCapitalization.none,
      this.keyBoardType = TextInputType.text,
      this.obscure=false,
        this.validator,
         this.heigth=35,
         this.maxLine=1
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyBoardType,
      style: Style.inputStyle(),
      obscureText: obscure,
      textCapitalization: capitalization,
      validator: validator,
      maxLines: maxLine,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Style.hintStyle(),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: borderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: borderColor)),
        fillColor: filledColor,
        filled: true,
        constraints: BoxConstraints.tightFor(height: heigth.h),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
        suffixIcon: sufix,
        prefixIcon: perfix,
      ),
    );
  }
}
