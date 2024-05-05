import 'package:xmovie/view/components/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TypeWidget extends StatelessWidget {
  final String? type;
  const TypeWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return type==null || type=="" ? const SizedBox.shrink() : Container(
      height: 15.h,
      width: type=="New" || type=="Top" ? 30.w : type=="Best seller" ? 60.w : 70.w,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Style.boldPink,
            // Style.primaryColor,
            Style.primaryColor,
          ]
        ),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r),bottomRight: Radius.circular(8.r))
      ),
      child: Center(
        child: Text(type ?? "",style: Style.miniStyle(color: Style.whiteColor,weight: FontWeight.w700,),),
      ),
    );
  }
}
