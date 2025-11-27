import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

abstract class AuthRemoteData {
  Future<Either> signIn(UserModel params);

  Future<Either> signUp(UserModel params);

  Future<Either> signInWithGoogle(AuthCredential credential);

  Future<Either> isLogin();

  Future<String> forgotPassword(String email);

  Future<Either> signOut();
}

class AuthRemoteDataImpl extends AuthRemoteData {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Either> signIn(UserModel params) async {
    if (params.email.isEmpty || params.password==null) {
      return Left("Email or password cannot be blank!");
    }
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password!,
      );
      final userModel = UserModel(
        uid: credential.user?.uid ?? "",
        email: params.email,
        password: params.password,
      );
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? e.code);
    } catch (e) {
      return Left("Unknown error: $e");
    }
  }

  @override
  Future<Either> signUp(UserModel params) async {
    if (params.email.isEmpty || params.password == null) {
      return Left("Email or password cannot be blank!");
    }
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password!,
      );
      final userModel = UserModel(
        uid: credential.user?.uid ?? "",
        email: params.email,
        password: params.password,
      );
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? e.code);
    } catch (e) {
      return Left("Unknown error: $e");
    }
  }

  @override
  Future<Either> signInWithGoogle(AuthCredential credential) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );
      final userModel = UserModel(
        uid: userCredential.user?.uid ?? "",
        email: userCredential.user!.email!,
      );
      return Right(userModel);
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> isLogin() async {
    try {
      var isLogin = firebaseAuth.currentUser;
      if (isLogin != null) {
        return Right(true);
      } else {
        return Left(false);
      }
    } on FirebaseAuthException catch (e) {
      return Left("Error: $e");
    }
  }

  @override
  Future<Either> signOut() async {
    try {
      await firebaseAuth.signOut();

      return Right("Log out successfully");
    } catch (e) {
      return Left("Lỗi : $e");
    }
  }

  @override
  Future<String> forgotPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "Email has been confirmed, check the message sent to you $email";
    } on FirebaseException catch (e) {
      return "Lỗi :${e.message}";
    }
  }
}
