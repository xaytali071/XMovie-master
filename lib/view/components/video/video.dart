import 'package:xmovie/controller/movie_controller/movie_cubit.dart';
import 'package:xmovie/controller/movie_controller/movie_state.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Vedio extends StatefulWidget {
  final String videoId;
  const Vedio({super.key, required this.videoId});

  @override
  State<Vedio> createState() => _VedioState();
}

class _VedioState extends State<Vedio> {

   var controller=YoutubePlayerController();

  @override
  void initState() {
     controller = YoutubePlayerController.fromVideoId(
      videoId:widget.videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: false,enableCaption: false),

    );

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        return SizedBox(
          height:  200.h,
          width: MediaQuery
              .sizeOf(context)
              .width,
          child: YoutubePlayerScaffold(
              autoFullScreen: false,
              backgroundColor: Style.transperntcolor,
              builder: (context, player) {
                return player;
              }, controller: controller),
        );
      },
    );
  }
}
