import 'package:xmovie/controller/app_controller/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit() :super(AppState());

  changeIndex(int index) {
    emit(state.copyWith(currentIndex:index));
  }

  hidePassword(){
    emit(state.copyWith(isHide: state.isHide=!state.isHide));
  }
}