import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/auth/models/user_params.dart';
import '../../../service_locator.dart';
import '../repositories/auth_repository.dart';

class SignOutUseCase extends UseCase<String, UserParams> {
  @override
  Future<String> call({ UserParams? params}) async {
    return await sl<AuthRepository>().signOut();
  }
}
