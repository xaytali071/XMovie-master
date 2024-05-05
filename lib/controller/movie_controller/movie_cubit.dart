import 'package:xmovie/controller/movie_controller/movie_state.dart';
import 'package:xmovie/model/movie_model.dart';
import 'package:xmovie/model/rating_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../model/coment_model.dart';
import '../../model/local_storage.dart';
import '../../model/user_model.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieState());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker image = ImagePicker();
  final SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';

  getMovies() async {
    emit(state.copyWith(isLoading: true));
    List<MovieModel> listOfMovies = [];
    List<String> listOfDocId=[];
    var res = await firestore.collection("movies").get();
    listOfMovies.clear();
    listOfDocId.clear();
    for (var element in res.docs) {
      listOfMovies.add(MovieModel.fromJson(element.data()));
      listOfDocId.add(element.id);
    }
    emit(state.copyWith(listOfMovie: listOfMovies,listOfDocId: listOfDocId,isLoading: false));
  }

  getCastMovie({required String docId,required String collectionName,}) async {
    emit(state.copyWith(isLoading: true));
    List<CastModel> list = [];
    var res = await firestore.collection(collectionName).doc(docId).get();
    MovieModel actor=await MovieModel.fromJson(res.data(),);
    list.clear();
    for (int i=0;i<(actor.actorsId?.length ?? 0);i++) {
      list.add(await getActorsWithid(actor.actorsId?[i] ?? ""));
    }
    emit(state.copyWith(listOfCast: list, isLoading: false));
  }

  getActorsWithid(String id) async {
    emit(state.copyWith(isLoading: true));
    var res=await firestore.collection("casts").doc(id).get();
    CastModel cast=CastModel.fromJson(res.data(), res.id);
    return cast;
  }


  playVideo(bool value) {
    emit(state.copyWith(isPlayer: value));
  }

  changeIndex(int index) {
    emit(state.copyWith(currentIndex:index));
  }

  size() {
    emit(state.copyWith(size: true));
    Future.delayed(const Duration(milliseconds: 150), () async {
      emit(state.copyWith(size: false));
    });
  }



  getSeries() async {
    emit(state.copyWith(isLoading: true));
    List<MovieModel> listOfMovies = [];
    List<String> listOfDocId=[];
    var res = await firestore.collection("series").get();
    listOfMovies.clear();
    listOfDocId.clear();
    for (var element in res.docs) {
      listOfMovies.add(MovieModel.fromJson(element.data()));
      listOfDocId.add(element.id);
    }
    emit(state.copyWith(listOfSeries: listOfMovies,listOfSeriesDocId: listOfDocId,isLoading: false));
  }

  getCartoon() async {
    emit(state.copyWith(isLoading: true));
    List<MovieModel> listOfMovies = [];
    List<String> listOfDocId=[];
    var res = await firestore.collection("multifilm").get();
    listOfMovies.clear();
    listOfDocId.clear();
    for (var element in res.docs) {
      listOfMovies.add(MovieModel.fromJson(element.data()));
      listOfDocId.add(element.id);
    }
    emit(state.copyWith(listOfCartoon: listOfMovies,listOfCartoonDocId: listOfDocId,isLoading: false));
  }

  searchMovie(String name) async {
    List<String> l=["movies","series","multifilm"];
    List<MovieModel> list = [];
    if (name.isEmpty) {
      state.listOfResult?.clear();
      emit(state.copyWith(listOfResult: []));
    } else {
      state.listOfResult?.clear();
      for(int i=0;i<l.length;i++){
        var res = await firestore
            .collection(l[i])
            .orderBy("name")
            .startAt([name]).endAt(["$name\uf8ff"]).get();
        for (var element in res.docs) {
          list.add(MovieModel.fromJson(element.data()));
        }
      }

      emit(state.copyWith(listOfResult: list));
    }
  }

  sendRating({
    required RatinByMovieModel movie,
    required String docId,
  }){
emit(state.copyWith(isLoading: true));
    firestore.collection("byRating").doc(docId).update(movie.toJson());
    emit(state.copyWith(isLoading: false));
  }

  getUserWithId(String id) async {
    var res = await firestore.collection("users").doc(id).get();
    UserModel newModel = UserModel.fromJson(docId: res.id, data: res.data());
    return newModel;
  }

  sendComent({required String coment, required String id}) async {
    emit(state.copyWith(isLoading: true));
    firestore
        .collection("byRating")
        .doc(id)
        .collection("coment")
        .add(ComentModel(
      title: coment,
      comentId: "",
      userId: await LocaleStore.getId(),
    ).toJson() as Map<String, dynamic>);
    emit(state.copyWith(isLoading: false));
  }



  getComent({
    required String docId,
  }) async {
    emit(state.copyWith(isLoading: true));
    firestore
        .collection("byRating")
        .doc(docId)
        .collection("coment")
        .snapshots()
        .listen((res) async {
      List<ComentModel> listOfComent = [];

      for (var element in res.docs) {
        listOfComent.add(
          ComentModel.fromJson(
            userId: element.data()['userId'],
            comentId: element.id,
            title: element.data()['title'],
            user: await getUserWithId(element.data()['userId']),
          ),
        );
      }
      emit(state.copyWith(listOfComent: listOfComent,isLoading: false));
    });
  }


  getRatingByMovie() async {
    emit(state.copyWith(isLoading: true));
    List<RatinByMovieModel> listOfMovies = [];
    List<String> listOfDocId=[];
    List<RatingByIdModel> list=[];
    var res = await firestore.collection("byRating").get();
    listOfMovies.clear();
    listOfDocId.clear();
    list.clear();
    for (var element in res.docs) {
      listOfMovies.add(RatinByMovieModel.fromJson(element.data()));
      listOfDocId.add(element.id);
      list.add(RatingByIdModel(rating:element.data()["rating"], id: element.id));
    }
    listOfMovies.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
    list.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));

    emit(state.copyWith(listOfRatingByMovie: listOfMovies,listOfRatingDocId: list,isLoading: false));
  }

}
