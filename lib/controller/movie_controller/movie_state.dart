import '../../model/coment_model.dart';
import '../../model/movie_model.dart';
import '../../model/rating_model.dart';

class MovieState {
  bool isLoading;
  final List<MovieModel>? listOfMovie;
  bool isPlayer;
  bool size;
  String speachWords;
  final List<String>? listOfDocId;
  final List<CastModel>? listOfCast;
  final List<MovieModel>? listOfSeries;
  final List<String>? listOfSeriesDocId;
  final List<MovieModel>? listOfCartoon;
  final List<String>? listOfCartoonDocId;
  final List<ComentModel>? listOfComent;
  int currentIndex;
  final List<MovieModel>? listOfResult;
  bool isListen;
  final List<RatinByMovieModel>? listOfRatingByMovie;
  final List<RatingByIdModel>? listOfRatingDocId;


  MovieState(
      {this.isLoading = false,
      this.listOfMovie,
      this.isPlayer = false,
      this.size = false,
      this.speachWords="",
      this.listOfDocId,
      this.listOfCast,
      this.currentIndex = 0,
      this.listOfSeriesDocId,
      this.listOfSeries,
      this.listOfResult,
        this.isListen=false,
        this.listOfCartoon,
        this.listOfCartoonDocId,
        this.listOfRatingByMovie,
        this.listOfRatingDocId,
        this.listOfComent,
      });

  MovieState copyWith(
          {bool? isLoading,
          List<MovieModel>? listOfMovie,
          bool? isPlayer,
          bool? size,
          String? speachWords,
          List<String>? listOfDocId,
          List<CastModel>? listOfCast,
          int? currentIndex,
            List<MovieModel>? listOfSeries,
            List<String>? listOfSeriesDocId,
            List<MovieModel>? listOfResult,
            bool? isListen,
            List<MovieModel>? listOfCartoon,
            List<String>? listOfCartoonDocId,
            List<RatinByMovieModel>? listOfRatingByMovie,
            List<RatingByIdModel>? listOfRatingDocId,
            List<ComentModel>? listOfComent,
          }) =>
      MovieState(
        isLoading: isLoading ?? this.isLoading,
        listOfMovie: listOfMovie ?? this.listOfMovie,
        isPlayer: isPlayer ?? this.isPlayer,
        size: size ?? this.size,
        speachWords: speachWords ?? this.speachWords,
        listOfDocId: listOfDocId ?? this.listOfDocId,
        listOfCast: listOfCast ?? this.listOfCast,
        currentIndex: currentIndex ?? this.currentIndex,
        listOfSeriesDocId: listOfSeriesDocId ?? this.listOfSeriesDocId,
        listOfSeries: listOfSeries ?? this.listOfSeries,
        listOfResult: listOfResult ?? this.listOfResult,
        isListen: isListen ?? this.isListen,
        listOfCartoon: listOfCartoon ?? this.listOfCartoon,
        listOfCartoonDocId: listOfCartoonDocId ?? this.listOfCartoonDocId,
        listOfRatingByMovie: listOfRatingByMovie ?? this.listOfRatingByMovie,
        listOfRatingDocId: listOfRatingDocId ?? this.listOfRatingDocId,
        listOfComent: listOfComent ?? this.listOfComent,
      );
}
