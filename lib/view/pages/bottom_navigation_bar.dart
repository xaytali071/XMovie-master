import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import 'package:xmovie/controller/app_controller/app_cubit.dart';
import 'package:xmovie/controller/app_controller/app_state.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/movie_controller/movie_cubit.dart';
import 'package:xmovie/view/components/button/custom_shape_button.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:xmovie/view/pages/auth/sign_up_page.dart';
import 'package:xmovie/view/pages/chats/chats_page.dart';
import 'package:xmovie/view/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/view/pages/settings/settings_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  List<Widget> listOfPage=[const HomePage(),const ChatsPage(),const SettingsPage()];

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notification received while app is in foreground: $message");
    });

    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Style.primaryColor,
          body: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_)=>AuthCubit()),
              BlocProvider(create: (_)=>AppCubit()),
              BlocProvider(create: (_)=>MovieCubit()),
            ],
            child: Stack(
              children: [
                ProsteIndexedStack(
                  index: state.currentIndex,
                  children: [
                    IndexedStackChild(child: const HomePage()),
                    IndexedStackChild(child: const ChatsPage()),
                    IndexedStackChild(child: const SettingsPage()),
                  ],
                ),
                Positioned(
                  top: MediaQuery.sizeOf(context).height-85.h,
                  bottom: 0,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 85.h,
                        width: MediaQuery.sizeOf(context).width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              30.verticalSpace,
                              Container(
                                height: 55.h,
                                decoration: BoxDecoration(
                                    color: Style.primaryColor,

                                    image: const DecorationImage(
                                        image: AssetImage("assets/Background.png"),
                                        scale: 0.2,
                                        fit: BoxFit.cover
                                    ),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r),topRight: Radius.circular(20.r))
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      state.currentIndex==0 ? Positioned(
                          top: 10.h,
                          left: 50.w,
                          child: Column(
                            children: [
                              CustomShapeButton(onTap: (){
                                context.read<AppCubit>().changeIndex(0);
                              },size: 60,child: const Icon(Icons.home,color: Style.whiteColor,),),
                              Text("Home",style: Style.inputStyle(color: Style.whiteColor),)
                            ],
                          )) : Positioned(
                          bottom: 10.h,
                          left: 30.w,
                          child: IconButton(onPressed: (){
                            context.read<AppCubit>().changeIndex(0);
                          },icon: const Icon(Icons.home,color: Style.whiteColor,))),

                      state.currentIndex==1 ? Positioned(
                          top: 10.h,
                          left: 150.w,
                          right: 150.w,
                          child: Column(
                            children: [
                              CustomShapeButton(onTap: (){
                                context.read<AppCubit>().changeIndex(1);
                              },size: 60,child: const Icon(Icons.chat_bubble,color: Style.whiteColor,),),
                              Text("Chats",style: Style.inputStyle(color: Style.whiteColor),)
                            ],
                          )) : Positioned(
                          bottom: 10.h,
                          left: 150.w,
                          right: 150.w,
                          child: IconButton(onPressed: (){
                            context.read<AppCubit>().changeIndex(1);
                          },icon: const Icon(Icons.chat_bubble,color: Style.whiteColor,))),

                      state.currentIndex==2 ? Positioned(
                          top: 10.h,
                          right: 50.w,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomShapeButton(onTap: (){
                                context.read<AppCubit>().changeIndex(2);
                              },size: 60,child: const Icon(Icons.person,color: Style.whiteColor,),),
                              Text("Account",style: Style.inputStyle(color: Style.whiteColor),)
                            ],
                          )) : Positioned(
                          bottom: 10.h,
                          right: 50.w,
                          child: IconButton(onPressed: (){
                            context.read<AppCubit>().changeIndex(2);
                          },icon: const Icon(Icons.person,color: Style.whiteColor,)))

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
