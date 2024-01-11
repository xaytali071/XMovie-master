class UserModel {
  final String? firstName;
  final String? lastName;
  final String? password;
  final String? avatar;
  final String? email;
  final String? phone;
  final String? docId;
  final String? fcmToken;
  final String? phoneModel;
  UserModel(
      {required this.firstName,
        required this.lastName,
        required this.password,
        this.avatar,
        required this.email,
        required this.phone,
        required this.fcmToken,
        required this.phoneModel,
        this.docId});

  factory UserModel.fromJson({Map? data,required String docId}) {
    return UserModel(
        firstName: data?["firstName"],
        lastName: data?["lastName"],
        password: data?["password"],
        avatar: data?["avatar"],
        email: data?["email"],
        phone: data?["phone"],
        fcmToken: data?["fcmToken"],
        phoneModel: data?["phoneModel"],
        docId: docId
    );
  }

  toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "password": password,
      "avatar": avatar,
      "email": email,
      "phone": phone,
      "fcmToken":fcmToken,
      "phoneModel":phoneModel,
    };
  }
}