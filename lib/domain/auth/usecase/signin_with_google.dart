
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytodoapp/core/usecase/usecase.dart';
import 'package:mytodoapp/domain/auth/repositories/auth_repository.dart';

import '../../../service_locator.dart' show sl;

class SignInWithGoogleUseCase extends UseCase<dynamic, AuthCredential>{
  @override
  Future call({AuthCredential? params}) async {
    return await sl<AuthRepository>().signInWithGoogle(params!);
  }
}