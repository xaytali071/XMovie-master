import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/auth_controller/auth_state.dart';
import 'package:xmovie/model/local_storage.dart';
import 'package:xmovie/view/components/widgets/back_ground_widget.dart';
import 'package:xmovie/view/components/button/custom_social_button.dart';
import 'package:xmovie/view/components/dialog/delete_account_dialog.dart';
import 'package:xmovie/view/components/images/avatar_image.dart';
import 'package:xmovie/view/components/widgets/social_media.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:xmovie/view/components/dialog/check_password_dialog.dart';
import 'package:xmovie/view/pages/auth/login_page.dart';
import 'package:xmovie/view/pages/settings/about_page.dart';
import 'package:xmovie/view/pages/settings/edit_profile_page.dart';
import 'package:xmovie/view/pages/settings/feedback_page.dart';

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
                  Text(
                    "Settings",
                    style: Style.normalStyle(),
                  ),
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
                          const Icon(
                            Icons.edit,
                            color: Style.greyColor,
                          ),
                          15.horizontalSpace,
                          Text(
                            "Edit profile",
                            style: Style.hintStyle(),
                          ),
                          const Spacer(),
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
                                      child: const LoginPage(),
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                      create: (context) => AuthCubit(),
                                      child: EditProfilePage(
                                        firsName:
                                            state.userModel?.firstName ?? "",
                                        lastName:
                                            state.userModel?.lastName ?? '',
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
                          const Icon(
                            Icons.key,
                            color: Style.greyColor,
                          ),
                          15.horizontalSpace,
                          Text(
                            "Change password",
                            style: Style.hintStyle(),
                          ),
                          const Spacer(),
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
                                      child: const LoginPage(),
                                    )));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BlocProvider(
                                create: (context) => AuthCubit(),
                                child: Dialog(
                                  child: CheckPasswordDialog(
                                    oldPassword:
                                        state.userModel?.password ?? "",
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
                            const Spacer(),
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
                                        child: const LoginPage(),
                                      )));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                        create: (context) => AuthCubit(),
                                        child: const FeedbackPage(),
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
                          const Icon(
                            Icons.insert_drive_file_rounded,
                            color: Style.greyColor,
                          ),
                          15.horizontalSpace,
                          Text(
                            "About",
                            style: Style.hintStyle(),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Style.greyColor,
                            size: 15.r,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const AboutPage()));
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
                            const Icon(
                              Icons.logout,
                              color: Style.greyColor,
                            ),
                            15.horizontalSpace,
                            Text(
                              "Log out",
                              style: Style.hintStyle(),
                            ),
                            const Spacer(),
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
                                    child: const LoginPage(),
                                  )));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: BlocProvider(
                                    create: (context) => AuthCubit(),
                                    child: const LogOutDialog(),
                                  ),
                                );
                              });
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
                            const Icon(
                              Icons.delete,
                              color: Style.greyColor,
                            ),
                            15.horizontalSpace,
                            Text(
                              "Delete account",
                              style: Style.hintStyle(),
                            ),
                            const Spacer(),
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
                                        child: const LoginPage(),
                                      )));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: BlocProvider(
                                    create: (context) => AuthCubit(),
                                    child: const DeleteAccountDialog(),
                                  ),
                                );
                              });
                        }
                      }),
                  20.verticalSpace,
                  const CustomSocialMedia(),
                  100.verticalSpace,
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
