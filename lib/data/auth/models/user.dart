class UserModel {
  String uid;
  String email;
  String? password;
  bool? isRemember;

  UserModel({
    required this.uid,
    required this.email,
     this.password,
    this.isRemember,
  });
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "password": password,
      "isRemember": isRemember,
    };
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      isRemember: json["isRemember"] ?? false,
    );
  }
}
