import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/auth_controller/auth_state.dart';
import 'package:xmovie/view/components/widgets/back_ground_widget.dart';
import 'package:xmovie/view/components/button/custom_button.dart';
import 'package:xmovie/view/components/form_field/custom_text_form_field.dart';
import 'package:xmovie/view/components/form_field/keyboard_dissimer.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:xmovie/view/pages/bottom_navigation_bar.dart';

import '../../../controller/app_controller/app_cubit.dart';
import '../../../controller/movie_controller/movie_cubit.dart';
import '../../components/button/custom_shape_button.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({super.key});

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  TextEditingController password = TextEditingController();
  TextEditingController coniformPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardDissimer(
      child: BackGroundWidget(
          child: SafeArea(
            child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomShapeButton(child: const Icon(Icons.arrow_back,color: Style.whiteColor,), onTap: (){
                        Navigator.pop(context);
                      }),
                      Text("Change password", style: Style.normalStyle(),),
                      40.horizontalSpace,
                    ],
                  ),
                  100.verticalSpace,
                  CustomTextFormField(
                    hint: "Password",
                    perfix: const Icon(
                      Icons.lock,
                      color: Style.greyColor,
                    ),
                    controller: password,
                  ),
                  50.verticalSpace,
                  CustomTextFormField(
                    hint: "Coniform password",
                    perfix: const Icon(
                      Icons.lock_reset_rounded,
                      color: Style.greyColor,
                    ),
                    controller: coniformPassword,
                  ),
                  10.verticalSpace,
                  state.pass ? const SizedBox() : Text("Password incorrect",style: Style.inputStyle(color: Style.redColor),),
                  70.verticalSpace,
                  state.isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          text: "Ok",
                          onTap: () {
                            context.read<AuthCubit>().changePassword(
                                password: password.text,
                                confirmPassword: coniformPassword.text,
                            onSuccess: (){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>MultiBlocProvider(
                                      providers: [
                                        BlocProvider(create: (_)=>AppCubit()),
                                        BlocProvider(create: (_)=>MovieCubit()),
                                        BlocProvider(create: (_)=>AuthCubit()),
                                      ],
                                      child: const BottomBar())), (route) => false);
                            }
                            );
                          })
                ],
              );
            },
                    ),
                  ),
          )),
    );
  }
}
