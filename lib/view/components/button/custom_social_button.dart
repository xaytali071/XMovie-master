import 'package:xmovie/view/components/button/button_effect.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSocialButton extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final Color color;
  final VoidCallback onTap;
  const CustomSocialButton({super.key,  this.height=60, required this.child,this.width=double.infinity, required this.onTap,this.color=Style.ttColor});

  @override
  Widget build(BuildContext context) {
    return AnimationButtonEffect(
      child: GestureDetector(
        onTap:onTap,
        child: Container(
          width: width.w,
          height: height.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: color,
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
