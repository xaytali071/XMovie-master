import 'dart:io';

import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/auth_controller/auth_state.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarButton extends StatelessWidget {
  final double size;

  const AvatarButton({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AuthCubit>().getImageGallery(() {});
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return state.imagePath==null ?
            Container(
            width: size.w,
            height: size.h,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Style.ttColor,

            ),
            child: Center(
              child: Icon(Icons.photo_camera_rounded,size: size-20.r,color: Style.greyColor,),
            )
          ) : Container(
              width: size.w,
              height: size.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Style.ttColor,
                image: DecorationImage(
                    image: FileImage(File(state.imagePath ?? "")),
                    fit: BoxFit.cover
                ),
              ),
          );
        },
      ),
    );
  }
}
