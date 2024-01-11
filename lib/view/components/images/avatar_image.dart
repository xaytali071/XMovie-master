import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style.dart';

class AvatarImage extends StatelessWidget {
  final double size;
  final String? image;
  const AvatarImage({super.key, this.size=40, required this.image});

  @override
  Widget build(BuildContext context) {
    return image==null || image=="" ?  Container(
        width: size.w,
        height: size.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Style.ttColor,

        ),
        child: Center(
          child: Icon(Icons.person,size: size-20.r,color: Style.greyColor,),
        )
    ) : Container(
      width: size.w,
      height: size.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(image ?? ""),
              fit: BoxFit.cover
            )
      ),
    );
  }
}
