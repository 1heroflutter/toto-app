class UserParams{
  String email;
  String password;
  bool? isRemember;
  UserParams({required this.email, required this.password, required this.isRemember});
  Map<String,dynamic> toJson(){
    return{
      "email":email,
      "password":password,
    };
  }
}