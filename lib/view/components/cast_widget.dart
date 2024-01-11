import 'package:xmovie/view/components/button/button_effect.dart';
import 'package:xmovie/view/components/images/custom_network_image.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/movie_model.dart';

class CastActorWidget extends StatelessWidget {
  final List<CastModel>? listOfCast;
  const CastActorWidget({super.key, required this.listOfCast,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145.h,
      child: ListView.builder(
        shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listOfCast?.length ?? 0,
          itemBuilder: (context,index){
        return Padding(
          padding:  EdgeInsets.all(5.r),
          child: AnimationButtonEffect(
            child: Container(
              width: 90.w,
              height: 130.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Style.primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImageNetwork(image: listOfCast?[index].image,width: 90.w,height: 85.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 85.w,
                          child: Text(listOfCast?[index].name ?? "",style: Style.miniStyle(),overflow: TextOverflow.ellipsis,maxLines: 2,)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
