
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/view/components/style.dart';

class CustomRatingBar extends StatelessWidget {
  final double rating;
  const CustomRatingBar({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: RatingBar.builder(
            initialRating: rating,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            tapOnlyMode: true,
            updateOnDrag: true,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (r) {
            },
          ),
        ),
        Positioned(
          child: Container(
            width: 210.w,
            height: 40.h,
            color: Style.transperntcolor,
          ),
        )
      ],
    );
  }
}
