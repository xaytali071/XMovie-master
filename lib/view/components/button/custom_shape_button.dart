import 'package:xmovie/view/components/button/button_effect.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomShapeButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final double size;
  const CustomShapeButton({super.key, required this.child, required this.onTap,  this.size=45});

  @override
  Widget build(BuildContext context) {
    return AnimationButtonEffect(
      child: Container(
        width: size.w,
        height: size.h,
        decoration: const BoxDecoration(
          color: Style.greenColor,
          shape: BoxShape.circle
        ),
        child: GestureDetector(
          onTap:onTap,
          child: Container(
            margin: EdgeInsets.only(top:1.h,left:1.w),
            width: 45.w,
            height: 45.h,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Style.primaryColor,
                  Style.boldPink,
                ]),
                shape: BoxShape.circle
            ),
            child:child ,
          ),
        ),
      ),
    );
  }
}
