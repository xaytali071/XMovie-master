import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/auth_controller/auth_state.dart';
import 'package:xmovie/model/local_storage.dart';
import 'package:xmovie/view/components/back_ground_widget.dart';
import 'package:xmovie/view/components/button/custom_social_button.dart';
import 'package:xmovie/view/components/delete_account_dialog.dart';
import 'package:xmovie/view/components/images/avatar_image.dart';
import 'package:xmovie/view/components/social_media.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:xmovie/view/components/check_password_dialog.dart';
import 'package:xmovie/view/pages/bottom_navigation_bar.dart';
import 'package:xmovie/view/pages/settings/about_page.dart';
import 'package:xmovie/view/pages/settings/edit_profile_page.dart';
import 'package:xmovie/view/pages/settings/feedback_page.dart';

import '../../../controller/app_controller/app_cubit.dart';
import '../../../controller/movie_controller/movie_cubit.dart';
import '../auth/sign_up_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGroundWidget(child: BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  10.verticalSpace,
                  Text("Settings",style: Style.normalStyle(),),
                  10.verticalSpace,
                  Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 180.h,
                      decoration: BoxDecoration(
                          color: Style.ttColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AvatarImage(
                            image: state.userModel?.avatar ?? "",
                            size: 100,
                          ),
                          10.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.userModel?.firstName ?? "",
                                style: Style.hintStyle(),
                              ),
                              10.horizontalSpace,
                              Text(
                                state.userModel?.lastName ?? "",
                                style: Style.hintStyle(),
                              )
                            ],
                          ),
                        ],
                      )),
                  20.verticalSpace,
                  CustomSocialButton(
                    height: 35,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 8.w),
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Style.greyColor,
                          ),
                          15.horizontalSpace,
                          Text(
                            "Edit profile",
                            style: Style.hintStyle(),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Style.greyColor,
                            size: 15.r,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      if (LocaleStore.getId() == null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                      create: (context) => AuthCubit(),
                                      child: SignUpPage(),
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                      create: (context) => AuthCubit(),
                                      child: EditProfilePage(
                                        firsName: state.userModel?.firstName ?? "",
                                        lastName: state.userModel?.lastName ?? '',
                                      ),
                                    )));
                      }
                    },
                  ),
                  20.verticalSpace,
                  CustomSocialButton(
                    height: 35,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.key,
                            color: Style.greyColor,
                          ),
                          15.horizontalSpace,
                          Text(
                            "Change password",
                            style: Style.hintStyle(),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Style.greyColor,
                            size: 15.r,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      if (LocaleStore.getId() == null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                      create: (context) => AuthCubit(),
                                      child: SignUpPage(),
                                    )));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BlocProvider(
                                create: (context) => AuthCubit(),
                                child: Dialog(
                                  child: CheckPasswordDialog(
                                    oldPassword: state.userModel?.password ?? "",
                                  ),
                                ),
                              );
                            });
                      }
                    },
                  ),
                  20.verticalSpace,
                  CustomSocialButton(
                      height: 35,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              "assets/feedback.svg",
                              color: Style.greyColor,
                            ),
                            15.horizontalSpace,
                            Text(
                              "Feedback",
                              style: Style.hintStyle(),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Style.greyColor,
                              size: 15.r,
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        if (LocaleStore.getId() == null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                        create: (context) => AuthCubit(),
                                        child: SignUpPage(),
                                      )));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                        create: (context) => AuthCubit(),
                                        child: FeedbackPage(),
                                      )));
                        }
                      }),
                  20.verticalSpace,
                  CustomSocialButton(
                    height: 35,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.insert_drive_file_rounded,
                            color: Style.greyColor,
                          ),
                          15.horizontalSpace,
                          Text(
                            "About",
                            style: Style.hintStyle(),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Style.greyColor,
                            size: 15.r,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>AboutPage()));
                    },
                  ),
                  20.verticalSpace,
                  CustomSocialButton(
                      height: 35,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Style.greyColor,
                            ),
                            15.horizontalSpace,
                            Text(
                              "Delete account",
                              style: Style.hintStyle(),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Style.greyColor,
                              size: 15.r,
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        if (LocaleStore.getId() == null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                        create: (context) => AuthCubit(),
                                        child: SignUpPage(),
                                      )));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: BlocProvider(
                                    create: (context) => AuthCubit(),
                                    child: DeleteAccountDialog(),
                                  ),
                                );
                              });
                        }
                      }),
                  20.verticalSpace,
                  CustomSocialMedia()
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
