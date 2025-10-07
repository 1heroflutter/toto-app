import 'package:mytodoapp/core/usecase/usecase.dart';
import 'package:mytodoapp/domain/auth/entities/user.dart';
import 'package:mytodoapp/domain/auth/repositories/auth_repository.dart';

import '../../../service_locator.dart';

class GetCurrentUserUseCase extends UseCase<UserEntity?,dynamic>{
  @override
  Future<UserEntity?> call({params}) async {
    return await sl<AuthRepository>().loadUser();
  }
}