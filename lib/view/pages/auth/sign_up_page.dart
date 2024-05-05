import 'package:device_info_plus/device_info_plus.dart';
import 'package:xmovie/controller/app_controller/app_cubit.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/auth_controller/auth_state.dart';
import 'package:xmovie/view/components/widgets/back_ground_widget.dart';
import 'package:xmovie/view/components/button/custom_button.dart';
import 'package:xmovie/view/components/button/custom_social_button.dart';
import 'package:xmovie/view/components/form_field/custom_text_form_field.dart';
import 'package:xmovie/view/components/form_field/keyboard_dissimer.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:xmovie/view/pages/auth/verification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController phoneController = TextEditingController();


  Future<void> getMessage() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  void initState() {

    super.initState();
  }

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
                    90.verticalSpace,
                     Text("Register for more features",style: Style.normalStyle(),),
                     90.verticalSpace,
                     CustomTextFormField(
                      hint: "Phone",
                      controller: phoneController,
                      perfix: const Icon(
                        Icons.phone,
                        color: Style.greyColor,
                      ),
                      keyBoardType: TextInputType.phone,
                    ),
                    50.verticalSpace,
                    state.isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            text: "OK",
                            onTap: () {
                              context.read<AuthCubit>().sendSms(
                                  phone: phoneController.text,
                                  codeSend: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => MultiBlocProvider(
                                              providers: [
                                                BlocProvider(create: (_)=>AuthCubit()),
                                              BlocProvider(create: (_)=>AppCubit(),),
                                              ],
                                              child: VerificationPage(
                                                phone: phoneController.text,
                                              ),
                                            )));
                                  });
                            },
                          ),
                    100.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 90.w,
                            child: Divider(
                              height: 3,
                              color: Style.whiteColor.withOpacity(0.7),
                            )),
                        Text(
                          "or continue with",
                          style: Style.hintStyle(color: Style.whiteColor),
                        ),
                        SizedBox(
                            width: 90.w,
                            child: Divider(
                              height: 3,
                              color: Style.whiteColor.withOpacity(0.7),
                            ))
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomSocialButton(
                          width: 100,
                          height: 40,
                          onTap: () async {
                            DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                            AndroidDeviceInfo androidInfo =
                                await deviceInfo.androidInfo;
                            String? fcmToken =
                                await FirebaseMessaging.instance.getToken();
                            context.read<AuthCubit>().loginGoogle(
                                fcmToken: fcmToken ?? "",
                                phoneModel:
                                    "${androidInfo.brand} ${androidInfo.model}");
                          },
                          child: SizedBox(
                              height: 27.r,
                              child: Image.asset(
                                "assets/Google.png",
                                fit: BoxFit.cover,
                              )),
                        ),
                        50.horizontalSpace,
                        CustomSocialButton(
                          width: 100,
                          height: 40,
                          onTap: () async {
                            DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                            AndroidDeviceInfo androidInfo =
                                await deviceInfo.androidInfo;
                            String? fcmToken =
                                await FirebaseMessaging.instance.getToken();
                            context.read<AuthCubit>().loginFacebook(
                                fcmToken: fcmToken ?? "",
                                phoneModel:
                                    "${androidInfo.brand} ${androidInfo.model}");
                          },
                          child: SizedBox(
                              height: 30.r,
                              child: Image.asset(
                                "assets/Facebook.png",
                                fit: BoxFit.cover,
                              )),
                        )
                      ],
                    ),
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
