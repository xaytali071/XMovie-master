import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/movie_controller/movie_cubit.dart';
import 'package:xmovie/controller/movie_controller/movie_state.dart';
import 'package:xmovie/model/local_storage.dart';
import 'package:xmovie/model/rating_model.dart';
import 'package:xmovie/view/components/button/custom_button.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:xmovie/view/pages/auth/login_page.dart';

class SendRating extends StatelessWidget {
  final RatinByMovieModel movie;
  final String docId;
  const SendRating({super.key, required this.movie, required this.docId});

  @override
  Widget build(BuildContext context) {
    int rating=0;
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 200.h,
      decoration: BoxDecoration(
        color: Style.primaryColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(10.r),topLeft: Radius.circular(10.r)),
        image: const DecorationImage(
          image: AssetImage("assets/Background.png"),
          fit: BoxFit.cover
        )
      ),
      child: BlocBuilder<MovieCubit, MovieState>(
  builder: (context, state) {
    return Column(
        children: [
          50.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            RatingBar.builder(
            initialRating: 0,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (r) {
              rating=r.toInt();

            },
          ),
            ],
          ),
          30.verticalSpace,
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomButton(text: "Send", onTap: () async {
              if(LocaleStore.getId()==null){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>BlocProvider(
  create: (context) => AuthCubit(),
  child: const LoginPage(),
)));
              } else if((movie.userIdList ?? [] ).contains(LocaleStore.getId())){
                Navigator.pop(context);
              }
              else {
                List<String> l = movie.userIdList ?? [];
                l.add(await LocaleStore.getId());
                int r = (movie.rating?.toInt() ?? 0) + rating;
                context.read<MovieCubit>().sendRating(
                    movie: RatinByMovieModel(movieName: movie.movieName,
                        movieImage: movie.movieImage,
                        rating: r,
                        userIdList: l), docId: docId);
                Navigator.pop(context);
              }
            }),
          )
        ],
      );
  },
),
    );
  }
}
