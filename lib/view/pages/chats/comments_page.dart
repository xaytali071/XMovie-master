import 'package:xmovie/app_const.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/movie_controller/movie_cubit.dart';
import 'package:xmovie/controller/movie_controller/movie_state.dart';
import 'package:xmovie/model/local_storage.dart';
import 'package:xmovie/model/rating_model.dart';
import 'package:xmovie/view/components/button/custom_social_button.dart';
import 'package:xmovie/view/components/form_field/keyboard_dissimer.dart';
import 'package:xmovie/view/components/widgets/rating_bar.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:xmovie/view/pages/auth/login_page.dart';
import 'package:xmovie/view/pages/auth/sign_up_page.dart';
import 'package:xmovie/view/pages/chats/coment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:xmovie/view/pages/chats/send_rating.dart';

import '../../components/button/custom_shape_button.dart';
import '../../components/form_field/text_form_field_send.dart';

class CommentsPage extends StatefulWidget {
  final RatinByMovieModel? movie;
  final String? docId;

  const CommentsPage({super.key, required this.movie, required this.docId});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MovieCubit>().getComent(docId: widget.docId ?? "");
    });
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDissimer(
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: Style.primaryColor,
        body: BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            return Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.movie?.movieImage ?? ""),
                        fit: BoxFit.cover)),
                child: Stack(
                  children: [
                    Positioned(
                      top: 35.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomShapeButton(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Style.whiteColor,
                                )),
                            230.horizontalSpace,
                            CustomShapeButton(
                                onTap: () {
                                  AppConst().dynamicLink(
                                      name: widget.movie?.movieName ?? "",
                                      image: widget.movie?.movieImage ?? "",
                                      title:
                                          widget.movie?.movieName ?? "");
                                },
                                child: const Icon(
                                  Icons.share,
                                  color: Style.whiteColor,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      child: DraggableScrollableSheet(
                        minChildSize: 0.3,
                        initialChildSize: 0.3,
                        snap: true,
                        builder: (context, controller) {
                          return ListView(
                            controller: controller,
                            shrinkWrap: true,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 100.h,
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                          Style.transperntcolor,
                                          Style.disPrimaryColor,
                                          Style.primaryColor,
                                        ])),
                                    child: Column(
                                      children: [
                                        20.verticalSpace,
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            10.horizontalSpace,
                                            CustomRatingBar(
                                                rating: (
                                                    widget.movie?.rating?.toDouble() ?? 0) /
                                                    (widget.movie?.userIdList
                                                            ?.length ??
                                                        0)),
                                            5.horizontalSpace,
                                            Text(
                                              (((widget.movie?.rating?.toDouble() ?? 0) / (widget.movie?.userIdList?.length ?? 0)).toString()=="NaN" ? "0.0" : "${(widget.movie?.rating?.toDouble() ?? 0) / (widget.movie?.userIdList?.length ?? 0)}")
                                                  .substring(0, 3),
                                              style: Style.inputStyle(
                                                  color: Style.whiteColor,
                                                  size: 20,
                                                  weight: FontWeight.w500),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width: 65.w,
                                              child: CustomSocialButton(
                                                height: 25,
                                                  color: Style.greenColor.withOpacity(0.7),
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                        backgroundColor:
                                                            Style.transperntcolor,
                                                        context: context,
                                                        builder: (_) {
                                                          return BlocProvider(
                                                            create: (context) =>
                                                                MovieCubit(),
                                                            child: SendRating(
                                                              movie:
                                                                  widget.movie!,
                                                              docId:
                                                                  widget.docId!,
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Icon(Icons.star_border,color: Style.whiteColor,size: 20,),
                                                      5.horizontalSpace,
                                                      Text(
                                                        "Rate",
                                                        style: Style.inputStyle(
                                                            color: Style.whiteColor),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                            15.horizontalSpace,
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    height: MediaQuery.sizeOf(context).height,
                                    decoration: const BoxDecoration(
                                        color: Style.primaryColor),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            state.listOfComent?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          return ComentWidget(
                                              image: state.listOfComent?[index]
                                                      .user?.avatar ??
                                                  "",
                                              fristName: state
                                                      .listOfComent?[index]
                                                      .user
                                                      ?.firstName ??
                                                  "Delete account",
                                              lastName: state
                                                      .listOfComent?[index]
                                                      .user
                                                      ?.lastName ??
                                                  "",
                                              title: state.listOfComent?[index]
                                                      .title ??
                                                  "");
                                        }),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: CustomTextFormFieldSend(
              hint: "type",
              controller: textController,
              perfix: const Icon(
                Icons.edit,
                color: Style.greyColor,
              ),
              filledColor: Style.blackColor.withOpacity(0.8),
              sufix: GestureDetector(
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
                    if (textController.text.isNotEmpty) {
                      animationController.forward();
                      context.read<MovieCubit>().sendComent(
                          coment: textController.text, id: widget.docId ?? "");
                      Future.delayed(const Duration(seconds: 3), () async {
                        textController.clear();
                        animationController.reset();
                      });
                    }
                  }
                },
                child: Lottie.asset(
                  "assets/send_animation.json",
                  width: 50.w,
                  height: 50.h,
                  fit: BoxFit.cover,
                  controller: animationController,
                  onLoaded: (composition) {
                    animationController.duration = composition.duration;
                  },
                ),
              ),
            )),
      ),
    );
  }
}
