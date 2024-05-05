import 'package:vibration/vibration.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/auth_controller/auth_state.dart';
import 'package:xmovie/controller/movie_controller/movie_cubit.dart';
import 'package:xmovie/controller/movie_controller/movie_state.dart';
import 'package:xmovie/model/local_storage.dart';
import 'package:xmovie/view/components/widgets/custom_horizontal_list.dart';
import 'package:xmovie/view/components/images/avatar_image.dart';
import 'package:xmovie/view/components/widgets/notification_widget.dart';
import 'package:xmovie/view/pages/auth/login_page.dart';
import 'package:xmovie/view/pages/home/messages_page.dart';
import 'package:xmovie/view/pages/search_result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../components/widgets/back_ground_widget.dart';
import '../../components/form_field/custom_text_form_field.dart';
import '../../components/form_field/keyboard_dissimer.dart';
import '../../components/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MovieCubit>().getMovies();
      context.read<MovieCubit>().getSeries();
      context.read<MovieCubit>().getCartoon();
      context.read<AuthCubit>().getUser();
      context.read<AuthCubit>().getMessages();
    });

    _initSpeech();
    super.initState();
  }

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    _speechEnabled = true;
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    _speechEnabled = false;
    await _speechToText.stop();
    setState(() {});
  }

  TextEditingController searchController = TextEditingController();

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      searchController = TextEditingController(text: _lastWords);
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDissimer(
      child: BackGroundWidget(child: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<MovieCubit, MovieState>(
            builder: (context, state) {
              return Column(children: [
                10.verticalSpace,
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return LocaleStore.getId() == null
                        ? TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider(
                                            create: (context) => AuthCubit(),
                                            child: const LoginPage(),
                                          )));
                            },
                            child: Text(
                              "Sign in",
                              style: Style.hintStyle(color: Style.pinkColor),
                            ))
                        : Row(
                            children: [
                              20.horizontalSpace,
                              AvatarImage(image: state.userModel?.avatar ?? ""),
                              10.horizontalSpace,
                              Text(
                                state.userModel?.firstName ?? "",
                                style: Style.hintStyle(color: Style.whiteColor),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              5.horizontalSpace,
                              SizedBox(
                                  width: 150.w,
                                  child: Text(
                                    state.userModel?.lastName ?? "",
                                    style: Style.hintStyle(
                                        color: Style.whiteColor),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )),
                              const Spacer(),
                              NotificationWidget(count: state.messageCount ?? 0, onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>BlocProvider(
  create: (context) => AuthCubit(),
  child: MessagesPage(listOfMessage: state.listOfMessage ?? [],),
)));
                              },),
                              15.horizontalSpace,
                            ],
                          );
                  },
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomTextFormField(
                    hint: 'Search',
                    controller: searchController,
                    onChanged: (s) {
                      if (s.isNotEmpty) {
                        context.read<MovieCubit>().searchMovie(
                            s.replaceFirst(s[0], s[0].toUpperCase()));
                      } else {
                        context.read<MovieCubit>().searchMovie(s);
                      }
                    },
                    perfix: const Icon(
                      Icons.search,
                      color: Style.greyColor,
                    ),
                    sufix: GestureDetector(
                        onLongPressStart: (s) {
                          Vibration.vibrate(duration: 30,);
                          _startListening();
                        },
                        onLongPressEnd: (d) {
                          if (_lastWords.isNotEmpty) {
                            context.read<MovieCubit>().searchMovie(
                                _lastWords.replaceFirst(_lastWords[0],
                                    _lastWords[0].toUpperCase()));
                          }
                          _stopListening();

                        },
                        child: const Icon(
                          Icons.mic,
                          color: Style.greyColor,
                        )),
                  ),
                ),
                (state.listOfResult?.isNotEmpty ?? false)
                    ? Column(
                        children: [
                          10.verticalSpace,
                          Text(
                            "Search result",
                            style: Style.hintStyle(color: Style.whiteColor),
                          ),
                          10.verticalSpace,
                          SearchResultPage(
                            collectionName: "movies",
                            list: state.listOfResult,
                          ),
                          30.verticalSpace,
                        ],
                      )
                    : 20.verticalSpace,
                Column(
                  children: [
                    Row(
                      children: [
                        20.horizontalSpace,
                        Text(
                          "Movies",
                          style: Style.hintStyle(color: Style.whiteColor),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    CustomHorizontalList(
                      list: state.listOfMovie,
                      docId: state.listOfDocId,
                      collectionName: "movies",
                    ),
                    20.verticalSpace,
                    Row(
                      children: [
                        20.horizontalSpace,
                        Text(
                          "Series",
                          style: Style.hintStyle(color: Style.whiteColor),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    CustomHorizontalList(
                      list: state.listOfSeries,
                      docId: state.listOfSeriesDocId,
                      collectionName: "series",
                    ),
                    20.verticalSpace,
                    Row(
                      children: [
                        20.horizontalSpace,
                        Text(
                          "Cartoon",
                          style: Style.hintStyle(color: Style.whiteColor),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    CustomHorizontalList(
                        list: state.listOfCartoon,
                        docId: state.listOfCartoonDocId,
                        collectionName: "multifilm"),
                    70.verticalSpace,
                  ],
                ),
              ]);
            },
          ),
        ),
      )),
    );
  }
}
