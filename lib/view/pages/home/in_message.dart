import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/view/components/widgets/back_ground_widget.dart';
import 'package:xmovie/view/components/images/custom_network_image.dart';
import 'package:xmovie/view/components/style.dart';

class InMessagePage extends StatefulWidget {
  final String image;
  final String title;
  final String body;
  final String time;
  final String id;
  const InMessagePage({super.key, required this.image, required this.title, required this.body, required this.time, required this.id});

  @override
  State<InMessagePage> createState() => _InMessagePageState();
}

class _InMessagePageState extends State<InMessagePage> {
  @override
  void initState() {
    context.read<AuthCubit>().readMessage(messageDocId:widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BackGroundWidget(child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(widget.title,style: Style.hintStyle(),),
            ),
            10.verticalSpace,
            widget.image=="" ? SizedBox(height: 10.h,) :
            Padding(
              padding:  EdgeInsets.all(4.r),
              child: CustomImageNetwork(image: widget.image,height: 300,),
            ),
            10.verticalSpace,
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(widget.body,style: Style.miniStyle(),),
            ),
          ],
        ),
      ),
    ));
  }
}
