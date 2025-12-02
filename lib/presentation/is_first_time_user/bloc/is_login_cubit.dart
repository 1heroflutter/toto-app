import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp/presentation/is_first_time_user/bloc/is_login_state.dart';
import '../../../domain/auth/repositories/auth_repository.dart';
import '../../../domain/auth/usecase/get_current_user.dart';
import '../../../service_locator.dart';

class IsLoginCubit extends Cubit<IsLoginState> {
  IsLoginCubit() : super(DisplaySplash());

  Future<void> appStarted() async {
    final isFirstTime = await sl<AuthRepository>().isFirstTime();
    if (isFirstTime) {
      print("[Debug] first time user");
      emit(FirstTimeUser());
    } else {
      final user = await sl<GetCurrentUserUseCase>().call();

      if (user != null) {
        print("[Debug] ${user.uid}");
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    }
  }
}
