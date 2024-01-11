import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/view/components/images/shimmer_item.dart';

class CustomShimmerLoading extends StatelessWidget {
  const CustomShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 12,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: 140.h),
        itemBuilder: (context, index) {
          return Padding(
            padding:  EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
            child: ShimmerItem(height: 140, width: 130, radius: 10),
          );
        });
  }
}
