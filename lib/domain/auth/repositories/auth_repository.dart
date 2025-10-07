import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytodoapp/data/auth/models/user.dart';
import 'package:mytodoapp/domain/auth/entities/user.dart';

abstract class AuthRepository {
  Future<Either> signIn(UserEntity params);
  Future<Either> signUp(UserEntity params);
  Future<Either> signInWithGoogle(AuthCredential credential);
  Future<Either> isLogin();
  Future<String> forgotPassword(String email);
  Future<UserEntity?> loadUser();
  Future<Either> signOut();

}