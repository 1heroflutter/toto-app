import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_params.dart';

abstract class AuthService {
  Future<Either> signIn(UserParams params);

  Future<Either> signUp(UserParams params);
  Future<Either> signInWithGoogle(AuthCredential credential);
  Future<Either> isLogin();
  Future<String> forgotPassword(String email);
  Future<String> signOut();
}

class AuthServiceImpl extends AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Either> signIn(UserParams params) async {
    final email = params.email;
    final password = params.password;

    if (email == null ||
        password == null ||
        email.isEmpty ||
        password.isEmpty) {
      return Left("Email hoặc mật khẩu không được để trống!");
    }

    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("[Credential]:${credential.user?.uid}");
      return Right(credential.user);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? e.code);
    } catch (e) {
      return Left("Lỗi không xác định: $e");
    }
  }

  @override
  Future<Either> signUp(UserParams params) async {
    final email = params.email;
    final password = params.password;

    if (email == null ||
        password == null ||
        email.isEmpty ||
        password.isEmpty) {
      return Left("Email hoặc mật khẩu không được để trống!");
    }
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(credential.user);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? e.code);
    } catch (e) {
      return Left("Lỗi không xác định: $e");
    }
  }

  @override
  Future<Either> signInWithGoogle(AuthCredential credential) async {
    try{
      UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
      return Right(userCredential.user);
    }on FirebaseException catch(e){
      return Left(e);
    }
  }
  @override
  Future<Either> isLogin() async {
    try{
      var isLogin = firebaseAuth.currentUser;
      if(isLogin!=null){
        return Right(true);
      }else{
        return Left(false);
      }
    }on FirebaseAuthException catch(e){
      return Left("Error: $e");
    }
  }
  @override
  Future<String>  signOut() async {
    try{
      await firebaseAuth.signOut();
      return ("Đăng xuất thành công");
    }catch (e){
      return "Lỗi : $e";
    }
  }

  @override
  Future<String> forgotPassword(String email) async {
    try{
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "Email đã được xác nhận, kiểm tra tin nhắn được gửi đến $email";
    }on FirebaseException catch (e){
      return "Lỗi :${e.message}";
    }
  }


}
