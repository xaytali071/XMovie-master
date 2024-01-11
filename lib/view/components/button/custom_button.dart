import 'package:xmovie/view/components/button/button_effect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final String text;
  final VoidCallback onTap;
  const CustomButton({super.key,  this.height=45, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimationButtonEffect(
      child: GestureDetector(
        onTap:onTap ,
        child: Container(
          width:double.infinity,
          height: height.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Style.primaryColor,
                  Style.boldPink,
                ]
            ),
            borderRadius: BorderRadius.circular(15.r)
          ),
          child: Center(child: Text(text,style: Style.hintStyle(color: Style.whiteColor),),),
        ),
      ),
    );
  }
}
