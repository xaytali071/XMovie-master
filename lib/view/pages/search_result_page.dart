import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/movie_model.dart';
import '../components/button/button_effect.dart';
import '../components/images/custom_network_image.dart';
import '../components/type_widget.dart';
import 'home/in_movie.dart';

class SearchResultPage extends StatelessWidget {
  final List<MovieModel>? list;
  final List<String>? docId;
  final String collectionName;

  const SearchResultPage(
      {super.key, this.list, this.docId, required this.collectionName});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: list?.length ?? 0,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: 140.h),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => InMoviePage(
                            movie: list![index],
                            docId: docId?[index] ?? "",
                            collectionName: collectionName,
                          )));
            },
            child: AnimationButtonEffect(
              child: Container(
                margin:
                    EdgeInsets.only(left: index == 0 ? 15.w : 5.w, right: 5.w),
                width: 100.w,
                height: 140.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Stack(
                  children: [
                    CustomImageNetwork(
                      image: list?[index].image ?? "",
                      height: 140.h,
                    ),
                    Positioned(
                        child: TypeWidget(
                      type: list?[index].type ?? "",
                    ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
