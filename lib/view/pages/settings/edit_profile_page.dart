import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/auth_controller/auth_state.dart';
import 'package:xmovie/view/components/back_ground_widget.dart';
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
import '../../components/button/custom_shape_button.dart';

class EditProfilePage extends StatefulWidget {
  final String firsName;
  final String lastName;

  const EditProfilePage({
    super.key,
    required this.firsName,
    required this.lastName,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

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
                      CustomShapeButton(child: Icon(Icons.arrow_back,color: Style.whiteColor,), onTap: (){
                        Navigator.pop(context);
                      }),
                      Text("Edit profile", style: Style.normalStyle(),),
                      40.horizontalSpace,
                    ],
                  ),
                  80.verticalSpace,
                  const AvatarButton(),
                  50.verticalSpace,
                  CustomTextFormField(
                    borderColor:  Style.transperntcolor,
                    hint: "Firstname",
                    controller: firstName,
                    perfix: Icon(
                      Icons.person,
                      color: Style.greyColor,
                    ),
                  ),
                  30.verticalSpace,
                  CustomTextFormField(
                    hint: "Lastname",
                    controller: lastName,
                    perfix: Icon(
                      Icons.person,
                      color: Style.greyColor,
                    ),
                  ),
                  70.verticalSpace,
                  state.isLoading ? CircularProgressIndicator() :
                  CustomButton(
                      text: "Next",
                      onTap: () async {
                         context.read<AuthCubit>().editName(
                             firsName: firstName.text.isEmpty ? widget.firsName : firstName.text ,
                             lastName: lastName.text.isEmpty
                                 ? widget.lastName
                                 : lastName.text,
                             onSuccess: () {
                               if(state.imagePath!=null){
                                 context.read<AuthCubit>().editImage(image: state.imagePath ?? "",
                                     onSuccess: (){
                                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>MultiBlocProvider(
                                           providers: [
                                             BlocProvider(create: (_)=>AppCubit()),
                                             BlocProvider(create: (_)=>MovieCubit()),
                                             BlocProvider(create: (_)=>AuthCubit()),
                                           ],
                                           child: BottomBar())), (route) => false);
                                     }
                                 );
                               }
                               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>MultiBlocProvider(
                                   providers: [
                                     BlocProvider(create: (_)=>AppCubit()),
                                     BlocProvider(create: (_)=>MovieCubit()),
                                     BlocProvider(create: (_)=>AuthCubit()),
                                   ],
                                   child: BottomBar())), (route) => false);
                             });
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
