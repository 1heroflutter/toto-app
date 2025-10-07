import 'package:dartz/dartz.dart';
import 'package:mytodoapp/domain/auth/entities/user.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/auth/models/user.dart';
import '../../../service_locator.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase extends UseCase<Either, UserEntity> {
  @override
  Future<Either> call({ UserEntity? params}) async {
    return await sl<AuthRepository>().signUp(params!);
  }
}
