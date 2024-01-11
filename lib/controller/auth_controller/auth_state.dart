import 'package:xmovie/model/message_model.dart';

import '../../model/user_model.dart';

class AuthState {
  bool isGoogleLoading;
  bool isFacebookLoading;
  bool isLoading;
  UserModel? userModel;
  String verificationId;
  String phone;
  String? errorText;
  final String? image;
  final String? imagePath;
  bool phonee;
  bool name;
  bool pass;
  bool check;
  bool checkPass;
  bool hidePassword;
  int? messageCount;
  List<MessageModel>? listOfMessage;

  AuthState({
    this.isFacebookLoading = false,
    this.isGoogleLoading = false,
    this.isLoading = false,
    this.verificationId = '',
    this.phone = '',
    this.errorText,
    this.userModel,
    this.image,
    this.imagePath,
    this.name=true,
    this.pass=true,
    this.phonee=true,
    this.check=false,
    this.checkPass=false,
    this.hidePassword=true,
    this.listOfMessage,
    this.messageCount,
  });

  AuthState copyWith(
      {bool? isGoogleLoading,
        bool? isFacebookLoading,
        bool? isLoading,
        String? errorText,
        String? phone,
        String? verificationId,
        UserModel? userModel,
        String? image,
        String? imagePath,
        bool? phonee,
        bool? name,
        bool? pass,
        bool? check,
        bool? checkPass,
        bool? hidePassword,
        List<MessageModel>? listOfMessage,
        int? messageCount,
      }) {
    return AuthState(
      isFacebookLoading: isFacebookLoading ?? this.isFacebookLoading,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
      isLoading: isLoading ?? this.isLoading,
      errorText: errorText,
      phone: phone ?? this.phone,
      userModel: userModel ?? this.userModel,
      verificationId: verificationId ?? this.verificationId,
      image: image ?? this.image,
      imagePath: imagePath ?? imagePath,
      pass: pass ?? this.pass,
      name: name ?? this.name,
      phonee: phonee ?? this.phonee,
      check: check ?? this.check,
      checkPass: checkPass ?? this.checkPass,
      hidePassword: hidePassword ?? this.hidePassword,
      listOfMessage: listOfMessage ?? this.listOfMessage,
      messageCount: messageCount ?? this.messageCount,
    );
  }
}