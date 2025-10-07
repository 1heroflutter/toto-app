import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_streaming.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mytodoapp/data/auth/models/user.dart';
import 'package:mytodoapp/data/auth/sources/auth_local_data.dart';
import 'package:mytodoapp/data/auth/sources/auth_remote_data.dart';
import 'package:mytodoapp/domain/auth/entities/user.dart';
import 'package:mytodoapp/domain/auth/repositories/auth_repository.dart';

import '../../../service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signIn(UserEntity params) async {
    final userModel = UserModel(
      uid: params.uid ?? "",
      email: params.email ?? "",
      password: params.password ?? "",
    );
    final result = await sl<AuthRemoteData>().signIn(userModel);
    return result.fold(
      (e) {
        return Left(e);
      },
      (user) async {
        await sl<AuthLocalData>().saveUser(user);
        return Right("SignIn Success");
      },
    );
  }

  @override
  Future<Either> signUp(UserEntity params) async {
    final userModel = UserModel(
      uid: params.uid ?? "",
      email: params.email ?? "",
      password: params.password ?? "",
    );
    final result = await sl<AuthRemoteData>().signUp(userModel);
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
  Future<Either> signInWithGoogle(AuthCredential credential) async {
    var result = await sl<AuthRemoteData>().signInWithGoogle(credential);
    return result.fold((e) {
      return Left(e);
    }, (user) async {
      await sl<AuthLocalData>().saveUser(user);
      return Right("SignIn success");
    });
  }

  @override
  Future<Either> isLogin() {
    return sl<AuthRemoteData>().isLogin();
  }

  @override
  Future<Either> signOut() async {
    final response = await sl<AuthRemoteData>().signOut();
    return response.fold(
      (e) {
        return Left(e);
      },
      (r) async {
        await sl<AuthLocalData>().clear();
        return Right(r);
      },
    );
  }

  @override
  Future<String> forgotPassword(String email) {
    return sl<AuthRemoteData>().forgotPassword(email);
  }

  @override
  Future<UserEntity?> loadUser() {
    return sl<AuthLocalData>().loadUser();
  }
}
