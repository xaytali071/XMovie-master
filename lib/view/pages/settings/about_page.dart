import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/view/components/widgets/back_ground_widget.dart';

import '../../components/button/custom_shape_button.dart';
import '../../components/style.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGroundWidget(
        child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomShapeButton(
                    child: const Icon(
                      Icons.arrow_back,
                      color: Style.whiteColor,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                Text(
                  "About",
                  style: Style.normalStyle(),
                ),
                40.horizontalSpace,
              ],
            ),
            50.verticalSpace,
            Text(
              "This application was developed by \nKhaytali Najmiddinov",
              style: Style.hintStyle(color: Style.whiteColor),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Text("Version 1.0",style: Style.miniStyle(),),
            Text("2024.03.14",style: Style.miniStyle(),),
          ],
        ),
      ),
    ));
  }
}
