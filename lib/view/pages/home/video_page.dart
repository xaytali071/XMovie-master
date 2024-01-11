import 'package:flutter/material.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:xmovie/view/components/video/custom_you_tube_vedio.dart';

class VideoPage extends StatelessWidget {
  final String videoUrl;
  const VideoPage({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.blackColor,
      body: Center(
        child: CustomYoutubeVideoPlayer(videoUrl:videoUrl ,),
      ),
    );
  }
}
