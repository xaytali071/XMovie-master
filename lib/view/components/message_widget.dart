import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/view/components/images/custom_network_image.dart';
import 'package:xmovie/view/components/style.dart';

class MessageWidget extends StatelessWidget {
  final String image;
  final String title;
  final String body;
  final String time;
  const MessageWidget({super.key, required this.image, required this.title, required this.body, required this.time});

  @override
  Widget build(BuildContext context) {
    return  DecoratedBox(
      decoration: BoxDecoration(
        color: Style.ttColor,
        borderRadius: BorderRadius.circular(10.r)
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.all(5.r),
                child: Text(title,style: Style.inputStyle(color: Style.whiteColor),maxLines: 2,overflow: TextOverflow.ellipsis,),
              ),
              image=="" ? SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 10.h,
              ) :
              CustomImageNetwork(image:image,height: 150,radius: 0,),
              Padding(
                padding:  EdgeInsets.all(5.r),
                child: Text(body,style: Style.miniStyle(color: Style.greyColor),maxLines: 2,overflow: TextOverflow.ellipsis,),
              ),
              10.verticalSpace,
            ],
          ),

          Positioned(
              bottom: 3,
              right: 7,
              child: Text(time.substring(0,16),style: Style.miniStyle(),))
        ],
      ),
    );
  }
}
