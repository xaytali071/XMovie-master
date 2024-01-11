import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/view/components/back_ground_widget.dart';

import '../../components/button/custom_shape_button.dart';
import '../../components/style.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGroundWidget(child: SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomShapeButton(child: Icon(Icons.arrow_back,color: Style.whiteColor,), onTap: (){
                Navigator.pop(context);
              }),
              Text("About", style: Style.normalStyle(),),
              40.horizontalSpace,
            ],
          ),
        ],),
      ),
    ));
  }
}
