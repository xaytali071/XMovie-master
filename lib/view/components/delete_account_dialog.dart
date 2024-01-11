import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/auth_controller/auth_state.dart';
import 'package:xmovie/view/components/button/custom_social_button.dart';
import 'package:xmovie/view/components/style.dart';

import '../../controller/app_controller/app_cubit.dart';
import '../../controller/movie_controller/movie_cubit.dart';
import '../pages/bottom_navigation_bar.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          width: MediaQuery
              .sizeOf(context)
              .width,
          height: 150.h,
          decoration: BoxDecoration(
              color: Style.primaryColor,
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                  image: AssetImage("assets/Background.png"),
                  fit: BoxFit.cover)),
          child: state.isLoading ? SizedBox(
              width: 100.w,
              height: 100.h,
              child: CircularProgressIndicator()) : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              20.verticalSpace,
              Text(
                "Are you sure you want to delete your account?",
                style: Style.inputStyle(color: Style.whiteColor),
                textAlign: TextAlign.center,
              ),
              30.verticalSpace,
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomSocialButton(
                    child: Text(
                      "Yes",
                      style: Style.hintStyle(color: Style.whiteColor),
                    ),
                    onTap: () {
                      context.read<AuthCubit>().deleteAccount(() {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>MultiBlocProvider(
                            providers: [
                              BlocProvider(create: (_)=>AppCubit()),
                              BlocProvider(create: (_)=>MovieCubit()),
                              BlocProvider(create: (_)=>AuthCubit())
                            ],
                            child: BottomBar())), (route) => false);
                      });
                    },
                    color: Style.disRedColor,
                    width: 80,
                    height: 40,
                  ),
                  CustomSocialButton(
                    child: Text(
                      "No",
                      style: Style.hintStyle(color: Style.whiteColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    width: 80,
                    height: 40,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
