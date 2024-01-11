import 'package:xmovie/app_const.dart';
import 'package:xmovie/controller/movie_controller/movie_cubit.dart';
import 'package:xmovie/controller/movie_controller/movie_state.dart';
import 'package:xmovie/model/movie_model.dart';
import 'package:xmovie/view/components/button/custom_shape_button.dart';
import 'package:xmovie/view/components/cast_widget.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/view/pages/home/video_page.dart';
import 'package:http/http.dart' as http;

class InMoviePage extends StatefulWidget {
  final MovieModel movie;
  final String docId;
  final String collectionName;

  const InMoviePage(
      {super.key,
      required this.movie,
      required this.docId,
      required this.collectionName});

  @override
  State<InMoviePage> createState() => _InMoviePageState();
}

class _InMoviePageState extends State<InMoviePage> {
  @override
  void initState() {
    context.read<MovieCubit>().size();
    context.read<MovieCubit>().playVideo(false);
    context
        .read<MovieCubit>()
        .getCast(docId: widget.docId, collectionName: widget.collectionName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.primaryColor.withOpacity(0.5),
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.movie.image ?? ""),
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
                            onTap: () async {
                              AppConst().dynamicLink(
                                  name: widget.movie.name ?? "",
                                  image: widget.movie.image ?? "",
                                  title:
                                      "${widget.movie.production} ${widget.movie.director}");
                            },
                            child: const Icon(
                              Icons.share,
                              color: Style.whiteColor,
                            )),
                      ],
                    ),
                  ),
                ),
                AnimatedPositioned(
                  bottom: state.size ? -500.h : 0,
                  left: 0,
                  right: 0,
                  duration: const Duration(milliseconds: 1500),
                  child: Container(
                    height:
                        (widget.movie.name?.length ?? 0) > 27 ? 330.h : 300.h,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Center(
                              child: Text(
                            widget.movie.name ?? "",
                            style: Style.normalStyle(),
                          )),
                        ),
                        10.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 370.w,
                                  child: Text(
                                    "Director: ${widget.movie.director}",
                                    style: Style.hintStyle(
                                        color: Style.whiteColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              SizedBox(
                                  width: 370.w,
                                  child: Text(
                                    "Production: ${widget.movie.production}",
                                    style: Style.hintStyle(
                                        color: Style.whiteColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              SizedBox(
                                  width: 370.w,
                                  child: Text(
                                    "Year: ${widget.movie.year}",
                                    style: Style.hintStyle(
                                        color: Style.whiteColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              SizedBox(
                                  width: 370.w,
                                  child: Text(
                                    "Country: ${widget.movie.country}",
                                    style: Style.hintStyle(
                                        color: Style.whiteColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              SizedBox(
                                  width: 370.w,
                                  child: Text(
                                    "IMDB: ${widget.movie.rating}",
                                    style: Style.hintStyle(
                                        color: Style.whiteColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ],
                          ),
                        ),
                        Center(
                            child: Text(
                          "Casts",
                          style: Style.hintStyle(color: Style.whiteColor),
                        )),
                        CastActorWidget(
                          listOfCast: state.listOfCast,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 200.h,
                  left: 100.w,
                  right: 100.w,
                  child: AnimatedSize(
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 1500),
                      child: CustomShapeButton(
                        size: state.size ? 0 : 80,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => VideoPage(
                                        videoUrl: widget.movie.videoUrl ?? "",
                                      )));
                        },
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Style.whiteColor,
                          size: state.size ? 0 : 80,
                        ),
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
