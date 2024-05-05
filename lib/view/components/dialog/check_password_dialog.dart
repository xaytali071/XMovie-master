import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/auth_controller/auth_state.dart';
import 'package:xmovie/view/components/button/custom_button.dart';
import 'package:xmovie/view/components/form_field/custom_text_form_field.dart';
import 'package:xmovie/view/components/form_field/keyboard_dissimer.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:xmovie/view/pages/settings/edit_password_page.dart';

class CheckPasswordDialog extends StatefulWidget {
  final String oldPassword;

  const CheckPasswordDialog({super.key, required this.oldPassword});

  @override
  State<CheckPasswordDialog> createState() => _CheckPasswordDialogState();
}

class _CheckPasswordDialogState extends State<CheckPasswordDialog> {
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardDissimer(
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            width: MediaQuery.sizeOf(context).width,
            height: 250.h,
            decoration: BoxDecoration(
                color: Style.primaryColor,
                borderRadius: BorderRadius.circular(10.r),
                image: const DecorationImage(
                    image: AssetImage("assets/Background.png"),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                20.verticalSpace,
                Text(
                  "Old password",
                  style: Style.hintStyle(),
                ),
                30.verticalSpace,
                CustomTextFormField(
                  hint: "Password",
                  perfix: const Icon(
                    Icons.lock,
                    color: Style.greyColor,
                  ),
                  controller: password,
                ),
                10.verticalSpace,
                state.pass
                    ? const SizedBox() :Text(
                        "Password incorrect",
                        style: Style.miniStyle(color: Style.redColor),
                      ),
                60.verticalSpace,
                CustomButton(text: "Next", onTap: () {
                  context.read<AuthCubit>().checkPassword(check:password.text == widget.oldPassword,onSuccess: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>BlocProvider(
  create: (context) => AuthCubit(),
  child: const EditPasswordPage(),
)));

                  });
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
