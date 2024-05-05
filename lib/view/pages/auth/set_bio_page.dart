import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/auth_controller/auth_state.dart';
import 'package:xmovie/view/components/widgets/back_ground_widget.dart';
import 'package:xmovie/view/components/button/custom_button.dart';
import 'package:xmovie/view/components/form_field/custom_text_form_field.dart';
import 'package:xmovie/view/components/form_field/keyboard_dissimer.dart';
import 'package:xmovie/view/components/images/avatar_botton.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/view/pages/bottom_navigation_bar.dart';

import '../../../controller/app_controller/app_cubit.dart';
import '../../../controller/movie_controller/movie_cubit.dart';

class SetBioPage extends StatefulWidget {
  final String phone;

  const SetBioPage({super.key, required this.phone});

  @override
  State<SetBioPage> createState() => _SetBioPageState();
}

class _SetBioPageState extends State<SetBioPage> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BackGroundWidget(
        child: KeyboardDissimer(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) {
    return Column(
                  children: [
                    20.verticalSpace,
                    const AvatarButton(),
                    50.verticalSpace,
                     CustomTextFormField(
                      hint: "Firstname",
                      controller: firstName,
                      perfix: const Icon(
                        Icons.person,
                        color: Style.greyColor,
                      ),
                    ),
                    30.verticalSpace,
                     CustomTextFormField(
                      hint: "Lastname",
                      controller: lastName,
                      perfix: const Icon(
                        Icons.person,
                        color: Style.greyColor,
                      ),
                    ),
                    30.verticalSpace,
                     CustomTextFormField(
                      hint: "Email",
                      controller: email,
                      perfix: const Icon(
                        Icons.email,
                        color: Style.greyColor,
                      ),
                      keyBoardType: TextInputType.emailAddress,
                    ),
                    30.verticalSpace,
                     CustomTextFormField(
                      hint: "Password",
                      controller: password,
                      obscure: state.hidePassword,
                      perfix: const Icon(
                        Icons.lock,
                        color: Style.greyColor,
                      ),
                       sufix: GestureDetector(
                           onTap: (){
                             context.read<AuthCubit>().hidePassword();
                           },
                           child: state.hidePassword ? const Icon(Icons.visibility_off,color: Style.greyColor,) : const Icon(Icons.remove_red_eye,color: Style.greyColor,)),
                    ),
                    70.verticalSpace,
                    state.isLoading ? const CircularProgressIndicator() :
                    CustomButton(
                        text: "Next",
                        onTap: () async {
                          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                          AndroidDeviceInfo androidInfo = await deviceInfo
                              .androidInfo;
                          String? fcmToken = await FirebaseMessaging.instance
                              .getToken();
                          context.read<AuthCubit>().setUser(
                              firstName: firstName.text,
                              phone: widget.phone,
                              email: email.text,
                              avatar:state.imagePath,
                              password: password.text,
                              lastName: lastName.text,
                              fcmToken: fcmToken ?? '',
                              phoneModel: "${androidInfo.brand} ${androidInfo
                                  .model}",
                              onSuccess: () {
                                context.read<AuthCubit>().createUser(() {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(
                                          builder: (_) => MultiBlocProvider(
                                              providers: [
                                                BlocProvider(create: (_)=>AppCubit()),
                                                BlocProvider(create: (_)=>MovieCubit()),
                                                BlocProvider(create: (_)=>AuthCubit())
                                              ],
                                              child: const BottomBar())), (
                                          route) => false);
                                });
                              }
                          );
                        })
                  ],
                );
  },
),
              ),
            ),
          ),
        ));
  }
}
