import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xmovie/model/feedback_model.dart';
import 'package:xmovie/model/message_model.dart';
import 'package:xmovie/view/components/style.dart';

import '../../model/local_storage.dart';
import '../../model/user_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker image = ImagePicker();

  Future<bool> checkPhone(String phone) async {
    try {
      var res = await firestore
          .collection("users")
          .where("phone", isEqualTo: phone)
          .get();
      // ignore: unnecessary_null_comparison
      if (res.docs.first != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      return false;
    }
  }

  sendSms({required String phone, required VoidCallback? codeSend}) async {
    emit(state.copyWith(isLoading: true, errorText: null));
    if (await checkPhone(phone)) {
      emit(state.copyWith(
          errorText: "An account has already been opened to this number", isLoading: false));
    } else {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) {
          if (kDebugMode) {
            print(credential.toString());
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (kDebugMode) {
            print("ERRORRRR${e.toString()}");
            emit(state.copyWith(isLoading: false));
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(state.copyWith(phone: phone, isLoading: false));
          codeSend?.call();
          emit(state.copyWith(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  login({required String phone,required String password,VoidCallback? onSuccess}) async {
    emit(state.copyWith(errorText: "",isLoading: true));
    try {
      var res = await firestore
          .collection("users")
          .where("phone", isEqualTo: phone)
          .get();
      if (res.docs.first["password"] == password) {
        LocaleStore.setId(res.docs.first.id);
        onSuccess?.call();
        emit(state.copyWith(isLoading: false));
      } else {
        emit(state.copyWith(errorText:"The password may be incorrect or not registered with such a number" ,isLoading: false));

      }
    } catch (e) {
      emit(state.copyWith(errorText: "The password may be incorrect or not registered with such a number",isLoading: false));
    }
  }

  updateFcm(String fcm,VoidCallback onSuccess) async {
    emit(state.copyWith(isLoading: true));
    firestore.collection("users").doc(await LocaleStore.getId()).update({"fcmToken":fcm});
    emit(state.copyWith(isLoading: false));
onSuccess.call();
  }

  sendOtp({required String email}) async {
    EmailAuth emailAuth = EmailAuth(sessionName: "Test session");
    bool result = await emailAuth.sendOtp(
        recipientMail: "xaytalinajmiddinov071@gmail.com", otpLength: 5);
    if (result) {
    } else if (kDebugMode) {
      print("Error processing OTP requests, check server for logs");
    }
  }

  hidePassword() {
    emit(
        state.copyWith(hidePassword: state.hidePassword = !state.hidePassword));
  }

  getUser() async {
    var res = await firestore
        .collection("users")
        .doc(await LocaleStore.getId())
        .get();
    UserModel newModel = UserModel.fromJson(docId: res.id, data: res.data());
    emit(state.copyWith(userModel: newModel));
  }

  setUser(
      {required String firstName,
      String? lastName,
      required String phone,
      String? email,
      String? avatar,
      String? password,
      required String fcmToken,
      required String phoneModel,
      required VoidCallback? onSuccess}) async {
    emit(state.copyWith(isLoading: true));
    if (avatar != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child("userImage/${DateTime.now().toString()}");
      await storageRef.putFile(File(avatar));
      String url = await storageRef.getDownloadURL();
      emit(state.copyWith(
          userModel: UserModel(
              firstName: firstName,
              lastName: lastName,
              password: password,
              email: email,
              avatar: url,
              fcmToken: fcmToken,
              phoneModel: phoneModel,
              phone: phone)));
    } else {
      emit(state.copyWith(
          userModel: UserModel(
              firstName: firstName,
              lastName: lastName,
              password: password,
              email: email,
              avatar: "",
              fcmToken: fcmToken,
              phoneModel: phoneModel,
              phone: phone)));
      onSuccess?.call();
    }
    emit(state.copyWith(isLoading: false));
  }

  checkCode(String code, VoidCallback onSuccess) async {
    emit(state.copyWith(isLoading: true));
    try {
      PhoneAuthCredential _credential = PhoneAuthProvider.credential(
          verificationId: state.verificationId, smsCode: code);
      if (kDebugMode) {
        print(_credential);
      }
      emit(state.copyWith(isLoading: false));

      onSuccess();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  createUser(VoidCallback onSuccess) async {
    firestore
        .collection("users")
        .add(UserModel(
          firstName: state.userModel?.firstName ?? "",
          lastName: state.userModel?.lastName ?? "",
          password: state.userModel?.password ?? "",
          email: state.userModel?.email ?? "",
          phone: state.userModel?.phone ?? "",
          avatar: state.userModel?.avatar,
          fcmToken: state.userModel?.fcmToken,
          phoneModel: state.userModel?.phoneModel,
        ).toJson())
        .then((value) async {
      await LocaleStore.setId(value.id);

      onSuccess();
    });
  }

  loginGoogle(
      {VoidCallback? onSuccess,
      required String fcmToken,
      required String phoneModel}) async {
    emit(state.copyWith(isGoogleLoading: true));
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser?.authentication != null) {
      GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userObj =
          await FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint("${userObj.additionalUserInfo?.isNewUser}");
      if (userObj.additionalUserInfo?.isNewUser ?? true) {
        // sing in
        firestore
            .collection("users")
            .add(UserModel(
              firstName: userObj.user?.displayName ?? "",
              lastName: "",
              password: userObj.user?.uid ?? "",
              email: userObj.user?.email ?? "",
              phone: userObj.user?.phoneNumber ?? "",
              avatar: userObj.user?.photoURL ?? "",
              fcmToken: fcmToken,
              phoneModel: phoneModel,
            ).toJson())
            .then((value) async {
          await LocaleStore.setId(value.id);
          onSuccess?.call();
          googleSignIn.signOut();
        });
      } else {
        // sing up
        var res = await firestore
            .collection("users")
            .where("email", isEqualTo: userObj.user?.email)
            .get();

        if (res.docs.isNotEmpty) {
          await LocaleStore.setId(res.docs.first.id);
          onSuccess?.call();
        }
      }
    }

    emit(state.copyWith(isGoogleLoading: false));
  }

  loginFacebook(
      {VoidCallback? onSuccess,
      required String fcmToken,
      required String phoneModel}) async {
    emit(state.copyWith(isFacebookLoading: true));
    final fb = FacebookLogin();
    final user = await fb.logIn(permissions: [
      FacebookPermission.email,
      FacebookPermission.publicProfile
    ]);
    if (user.status == FacebookLoginStatus.success) {
      final OAuthCredential credential =
          FacebookAuthProvider.credential(user.accessToken?.token ?? "");

      final userObj =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userObj.additionalUserInfo?.isNewUser ?? true) {
        // sing in
        firestore
            .collection("users")
            .add(UserModel(
              firstName: userObj.user?.displayName ?? "",
              lastName: "",
              password: userObj.user?.uid ?? "",
              email: userObj.user?.email ?? "",
              phone: userObj.user?.phoneNumber ?? "",
              avatar: userObj.user?.photoURL ?? "",
              fcmToken: fcmToken,
              phoneModel: phoneModel,
            ).toJson())
            .then((value) async {
          await LocaleStore.setId(value.id);
          onSuccess?.call();
        });
      } else {
        // sing up
        var res = await firestore
            .collection("users")
            .where("email", isEqualTo: userObj.user?.email)
            .get();

        if (res.docs.isNotEmpty) {
          await LocaleStore.setId(res.docs.first.id);
          onSuccess?.call();
        }
      }
    }

    emit(state.copyWith(isFacebookLoading: false));
  }

  changePassword(
      {required String password,
      required String confirmPassword,
      VoidCallback? onSuccess}) async {
    if (password == confirmPassword) {
      emit(state.copyWith(isLoading: true, pass: true));
      await firestore
          .collection("users")
          .doc(LocaleStore.getId())
          .update({"password": password});
      onSuccess?.call();
      emit(state.copyWith(isLoading: false));
    } else {
      emit(state.copyWith(pass: false));
    }
  }

  deleteAccount(VoidCallback onSuccess) async {
    emit(state.copyWith(isLoading: true));
    await firestore.collection("users").doc(await LocaleStore.getId()).delete();
    await LocaleStore.storeClear();
    emit(state.copyWith(pass: false));

    onSuccess();
  }

  editName(
      {required String firsName,
      String? lastName,
      VoidCallback? onSuccess}) async {
    emit(state.copyWith(isLoading: true));
    if (firsName.isNotEmpty) {
      await firestore
          .collection("users")
          .doc(await LocaleStore.getId())
          .update({
        'firstName': firsName,
        'lastName': lastName,
      });

      UserModel userModel = UserModel(
        firstName: firsName,
        lastName: lastName,
        password: state.userModel?.password,
        email: state.userModel?.email,
        phone: state.userModel?.phone,
        phoneModel: state.userModel?.phoneModel,
        fcmToken: state.userModel?.fcmToken,
      );
      onSuccess?.call();

      emit(state.copyWith(userModel: userModel));
    }
    emit(state.copyWith(isLoading: false));
  }

  getImageGallery(VoidCallback onSuccess) async {
    await image.pickImage(source: ImageSource.gallery,imageQuality: 65).then((value) async {
      if (value != null) {
        CroppedFile? cropperImage =
            await ImageCropper().cropImage(sourcePath: value.path);
        emit(state.copyWith(imagePath: cropperImage?.path));
        onSuccess();
      }
    });
  }

  editImage({required String? image, VoidCallback? onSuccess}) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("userImage/${DateTime.now().toString()}");
    await storageRef.putFile(File(image ?? ""));

    String url = await storageRef.getDownloadURL();
    await firestore
        .collection("users")
        .doc(await LocaleStore.getId())
        .update({'avatar': url});
    onSuccess?.call();
  }

  check({required bool check}) {
    emit(state.copyWith(check: check));
  }

  checkPassword({required bool check, VoidCallback? onSuccess}) {
    emit(state.copyWith(pass: check));
    if (state.pass) {
      onSuccess?.call();
    }
  }

  sendFeedback({required String title}) async {
    emit(state.copyWith(isLoading: true));
    firestore.collection("feedback").add(FeedbackModel(
            userId: await LocaleStore.getId(),
            title: title,
            time: DateTime.now())
        .toJson());
    emit(state.copyWith(isLoading: false));
    Fluttertoast.showToast(msg: "Success",
    backgroundColor: Style.greenColor,
    gravity: ToastGravity.CENTER
    );
  }

  getMessages() async {
    emit(state.copyWith(isLoading: true));
    var res = firestore
        .collection("users")
        .doc(LocaleStore.getId())
        .collection("messages").snapshots().listen((res) {
      int count=0;
      List<MessageModel> list=[];
      for(var element in res.docs){
        list.add(MessageModel.fromJson(element.data(),element.id));
        if(element.data()["isRead"]==false){
          count+=1;
        }}
      emit(state.copyWith(listOfMessage: list,isLoading: false,messageCount: count));
    });
  }

  readMessage({required String messageDocId}) async {
     await firestore
        .collection("users")
        .doc(LocaleStore.getId())
        .collection("messages").doc(messageDocId).update({"isRead":true});
  }

  logOut(VoidCallback onSuccess){
    LocaleStore.storeClear();
    onSuccess.call();
  }
}
