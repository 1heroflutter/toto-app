import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/auth/models/user_params.dart';
import '../../../service_locator.dart';
import '../repositories/auth_repository.dart';

class IsLogginUseCase extends UseCase<Either, UserParams> {
  @override
  Future<Either> call({ UserParams? params}) async {
    return await sl<AuthRepository>().isLogin();
  }
}
