import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytodoapp/data/auth/models/user_params.dart';

abstract class AuthRepository {
  Future<Either> signIn(UserParams params);
  Future<Either> signUp(UserParams params);
  Future<Either> signInWithGoogle(AuthCredential credential);
  Future<Either> isLogin();
  Future<String> forgotPassword(String email);
  Future<String> signOut();

}