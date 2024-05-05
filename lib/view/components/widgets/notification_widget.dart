import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/view/components/style.dart';

class NotificationWidget extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  const NotificationWidget({super.key, required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 35.w,
        height: 35.h,
        child: Stack(
          children: [
            const Icon(
              Icons.notifications,
              color: Style.whiteColor,
              size: 30,
            ),
            Positioned(
              right: 8.w,
              top: 0.h,
              child: count==0 ? const SizedBox.shrink() : Container(
                width: 15.w,
                height: 15.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Style.redColor,
                ),
                child: Center(child: Text(count.toString(),style: Style.miniStyle(size: 7,weight: FontWeight.w600),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
