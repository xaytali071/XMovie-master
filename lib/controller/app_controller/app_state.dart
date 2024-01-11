class AppState {
  int currentIndex;
  bool isHide;

  AppState({this.currentIndex = 0, this.isHide = false});

  AppState copyWith({
    int? currentIndex,
    bool? isHide,
  }) {
    return AppState(
      currentIndex: currentIndex ?? this.currentIndex,
      isHide: isHide ?? this.isHide,
    );
  }
}
