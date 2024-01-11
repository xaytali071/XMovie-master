import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/auth_controller/auth_state.dart';
import 'package:xmovie/view/components/back_ground_widget.dart';
import 'package:xmovie/view/components/button/custom_button.dart';
import 'package:xmovie/view/components/button/custom_shape_button.dart';
import 'package:xmovie/view/components/form_field/custom_text_form_field.dart';
import 'package:xmovie/view/components/form_field/keyboard_dissimer.dart';
import 'package:xmovie/view/components/style.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController title=TextEditingController();
  @override
  void initState() {
    context.read<AuthCubit>().check(check: title.text.isEmpty);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return KeyboardDissimer(
      child: BackGroundWidget(child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SafeArea(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return Column(
                children: [
                  10.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomShapeButton(child: Icon(Icons.arrow_back,color: Style.whiteColor,), onTap: (){
                        Navigator.pop(context);
                      }),
                      Column(
                        children: [
                          Text("Feedback", style: Style.normalStyle(),),
                         // Text("Complaints and suggestions", style: Style.inputStyle(),),
                        ],
                      ),
                      40.horizontalSpace,
                    ],
                  ),
          100.verticalSpace,
                  CustomTextFormField(
                    onChanged: (s){
                      context.read<AuthCubit>().check(check: title.text.isEmpty);
                    },
                    capitalization: TextCapitalization.words,
                    hint: "Type here",controller: title,heigth: 200, maxLine: 30,),
                  50.verticalSpace,
          
                  state.isLoading ? CircularProgressIndicator() : state.check ? SizedBox.shrink() :
                  CustomButton(text: "Send", onTap: () {
                    context.read<AuthCubit>().sendFeedback(title:title.text);
                    title.clear();
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
