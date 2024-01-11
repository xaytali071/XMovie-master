import 'package:xmovie/controller/movie_controller/movie_cubit.dart';
import 'package:xmovie/view/components/images/custom_network_image.dart';
import 'package:xmovie/view/pages/chats/comments_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/rating_model.dart';

class CustomGridwView extends StatelessWidget {
  final List<RatinByMovieModel>? listOfMovie;
  final List<RatingByIdModel>? listOfDoc;
  const CustomGridwView({super.key, required this.listOfMovie,required this.listOfDoc});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisExtent: 140.h),
        shrinkWrap: true,
        itemCount: listOfMovie?.length ?? 0,
        itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>BlocProvider(
  create: (context) => MovieCubit(),
  child: CommentsPage(movie: listOfMovie![index], docId: listOfDoc?[index].id ?? "",),
)));
          },
          child: Container(
            margin:EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
            width: 130.w,
            height: 140.h,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            ),
            child: CustomImageNetwork(image: listOfMovie?[index].movieImage,),
          ),
        );
    }
    );
  }
}
