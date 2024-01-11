import 'package:xmovie/controller/movie_controller/movie_cubit.dart';
import 'package:xmovie/view/components/button/button_effect.dart';
import 'package:xmovie/view/components/images/custom_network_image.dart';
import 'package:xmovie/view/components/type_widget.dart';
import 'package:xmovie/view/pages/home/in_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/movie_model.dart';

class CustomHorizontalList extends StatelessWidget {
  final List<MovieModel>? list;
  final List<String>? docId;
  final String collectionName;
  const CustomHorizontalList({super.key, required this.list,required this.docId, required this.collectionName,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 130.h,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: list?.length ?? 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider(create: (_)=>MovieCubit())
                            ],
                            child: InMoviePage(movie: list![index],docId:docId?[index] ?? "",collectionName: collectionName,))));
              },
              child: AnimationButtonEffect(
                child: Container(
                  margin:
                      EdgeInsets.only(left: index == 0 ? 15.w : 5.w, right: 5.w),
                  width: 100.w,
                  height: 130.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Stack(
                    children: [
                      CustomImageNetwork(
                        image: list?[index].image ?? "",
                      ),
                      Positioned(child: TypeWidget(type:list?[index].type ?? "",))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
