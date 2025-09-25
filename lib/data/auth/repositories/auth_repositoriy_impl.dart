import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_streaming.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mytodoapp/data/auth/models/user_params.dart';
import 'package:mytodoapp/data/auth/sources/auth_service_impl.dart';
import 'package:mytodoapp/domain/auth/repositories/auth_repository.dart';

import '../../../service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signIn(UserParams params) async {
    final result = await sl<AuthService>().signIn(params);
    return result.fold(
      (e) {
        return Left(e);
      },
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> signUp(UserParams params) async {
    final result = await sl<AuthService>().signUp(params);
    return result.fold(
      (e) {
        return Left(e);
      },
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> signInWithGoogle(AuthCredential credential) {
    return sl<AuthService>().signInWithGoogle(credential);
  }
  @override
  Future<Either> isLogin() {
    return sl<AuthService>().isLogin();
  }
  @override
  Future<String> signOut() {
    return sl<AuthService>().signOut();
  }

  @override
  Future<String> forgotPassword(String email) {
    return sl<AuthService>().forgotPassword(email);
  }

}
