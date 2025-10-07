import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/auth/models/user.dart';
import '../../../service_locator.dart';
import '../repositories/auth_repository.dart';

class IsLogginUseCase extends UseCase<Either, UserModel> {
  @override
  Future<Either> call({ UserModel? params}) async {
    return await sl<AuthRepository>().isLogin();
  }
}
