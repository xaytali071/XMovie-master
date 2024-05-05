import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/controller/app_controller/app_cubit.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/auth_controller/auth_state.dart';
import 'package:xmovie/controller/movie_controller/movie_cubit.dart';
import 'package:xmovie/view/components/widgets/back_ground_widget.dart';
import 'package:xmovie/view/components/button/custom_button.dart';
import 'package:xmovie/view/components/form_field/custom_text_form_field.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:xmovie/view/pages/auth/sign_up_page.dart';
import 'package:xmovie/view/pages/bottom_navigation_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  String? fcmToken;
  getToken() async {
    fcmToken =
        await FirebaseMessaging.instance.getToken();
  }

  @override
  void initState() {
   getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return BackGroundWidget(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                100.verticalSpace,
                Text("Login",style: Style.normalStyle(),),
                100.verticalSpace,
                CustomTextFormField(
                  hint: "Phone",
                  perfix: const Icon(
                    Icons.phone,
                    color: Style.greyColor,
                  ),
                  controller: phone,
                  keyBoardType: TextInputType.phone,
                ),
                30.verticalSpace,
                CustomTextFormField(
                  hint: "Password",
                  controller: password,
                  perfix: const Icon(
                    Icons.lock,
                    color: Style.greyColor,
                  ),
                ),
                50.verticalSpace,
                Center(
                  child: Text(
                    state.errorText ?? "",
                    style: Style.inputStyle(color: Style.redColor),
                  ),
                ),
                20.verticalSpace,
                state.isLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: "Next",
                        onTap: () async {
                          context.read<AuthCubit>().login(
                              phone: phone.text,
                              password: password.text,
                              onSuccess: () {
                                Future.delayed(const Duration(seconds: 2)).then((value){
                                  context.read<AuthCubit>().updateFcm(fcmToken ?? "", () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => MultiBlocProvider(
                                                providers: [
                                                  BlocProvider(create: (_)=>AuthCubit()),
                                                  BlocProvider(create: (_)=>MovieCubit()),
                                                  BlocProvider(create: (_)=>AppCubit()),
                                                ],
                                                child: MultiBlocProvider(
                                                    providers: [
                                                      BlocProvider(create: (_)=>AuthCubit()),
                                                      BlocProvider(create: (_)=>MovieCubit()),
                                                    ],
                                                    child: const BottomBar()))),
                                            (route) => false);
                                  });
                                });

                              });
                        }),
                50.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 120.w,
                        child: Divider(
                          height: 3,
                          color: Style.whiteColor.withOpacity(0.7),
                        )),
                    Text(
                      "Or",
                      style: Style.hintStyle(color: Style.whiteColor),
                    ),
                    SizedBox(
                        width: 120.w,
                        child: Divider(
                          height: 3,
                          color: Style.whiteColor.withOpacity(0.7),
                        ))
                  ],
                ),
                50.verticalSpace,
                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>BlocProvider(
  create: (context) => AuthCubit(),
  child: const SignUpPage(),
)));
                    },
                    child: Text("Sign up",style: Style.hintStyle(color: Style.pinkColor),))
              ],
            ),
          ),
        );
      },
    );
  }
}
