
import 'package:xmovie/view/components/images/custom_network_image.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComentWidget extends StatelessWidget {
  final String? image;
  final String fristName;
  final String lastName;
  final String title;
  const ComentWidget({super.key, required this.image, required this.fristName, required this.lastName, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Style.greyColor,
          borderRadius: BorderRadius.circular(10.r)
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  image==null || image=="" ? Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Style.greyColor
                    ),
                    child: Center(child: Text(fristName[0].toUpperCase()),),
                  ) :
                 SizedBox(
                     width: 30.w,
                     height: 30.h,
                     child: ClipOval(child: CustomImageNetwork(image: image,))),
                 5.horizontalSpace,
                 Text(fristName,style: Style.miniStyle(size: 10),),
                 Text(lastName ,style: Style.miniStyle(size: 10),),
                ],
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(title,style: Style.miniStyle(),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
