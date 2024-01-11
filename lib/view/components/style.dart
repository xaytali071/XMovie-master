import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Style{
  Style._();
  static const pinkColor=Color(0xffFE53BB);
  static const greenColor=Color(0xff60FFCA);
  static const primaryColor=Color(0xff2c186c);
  static const disPrimaryColor=Color(0x992c186c);
  static const greyColor=Color(0x70FFFFFF);
  static const ttColor=Color(0x20FFFFFF);
  static const blackColor=Color(0xff000000);
  static const transperntcolor=Colors.transparent;
  static const whiteColor=Color(0xffFFFFFF);
  static const redColor=Color(0xffE00E0E);
  static const disRedColor=Color(0x60E00E0E);
  static const boldPink=Color(0xffB6116B);

  static TextStyle normalStyle({double size=20,FontWeight weight=FontWeight.w700,Color color=Style.whiteColor})=>
     GoogleFonts.poppins(
      fontSize: size.sp,
       fontWeight: weight,
       color: color
  );

  static TextStyle hintStyle({double size=12,FontWeight weight=FontWeight.w700,Color color=Style.greyColor})=>
      GoogleFonts.poppins(
          fontSize: size.sp,
          fontWeight: weight,
          color: color
      );

  static TextStyle inputStyle({double size=12,FontWeight weight=FontWeight.w600,Color color=Style.greyColor})=>
      GoogleFonts.poppins(
          fontSize: size.sp,
          fontWeight: weight,
          color: color
      );

  static TextStyle miniStyle({double size=8,FontWeight weight=FontWeight.w500,Color color=Style.whiteColor})=>
      GoogleFonts.poppins(
          fontSize: size.sp,
          fontWeight: weight,
          color: color
      );
}