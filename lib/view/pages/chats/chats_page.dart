import 'package:xmovie/controller/movie_controller/movie_cubit.dart';
import 'package:xmovie/controller/movie_controller/movie_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/view/components/widgets/shimmer_loading.dart';
import 'package:xmovie/view/components/style.dart';

import '../../components/widgets/back_ground_widget.dart';
import '../../components/widgets/custom_grid_view.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() {
    context.read<MovieCubit>().getRatingByMovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  BackGroundWidget(
      child: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<MovieCubit, MovieState>(
            builder: (context, state) {
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                    children: [
                      Text("Movie by rating",style: Style.normalStyle(),),
                      10.verticalSpace,
                      state.isLoading ? const CustomShimmerLoading() :
                      CustomGridwView(listOfMovie:state.listOfRatingByMovie ?? [],listOfDoc: state.listOfRatingDocId,),
                      80.verticalSpace,
                    ]
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
