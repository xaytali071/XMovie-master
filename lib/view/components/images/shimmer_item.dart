import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../style.dart';

class ShimmerItem extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const ShimmerItem({Key? key, required this.height, required this.width, required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width.w,
        height: height.h,
        child: Shimmer.fromColors(
          baseColor: Style.greyColor,
          highlightColor: Style.greenColor,
          child:
          Container(width: width.w, height: height.h, color: Style.greyColor),
        ),
      ),
    );
  }
}
