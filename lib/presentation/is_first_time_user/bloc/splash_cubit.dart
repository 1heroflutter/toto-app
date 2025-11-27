
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp/domain/auth/usecase/is_loggin.dart';
import 'package:mytodoapp/presentation/is_first_time_user/bloc/splash_state.dart';
import '../../../domain/auth/repositories/auth_repository.dart';
import '../../../domain/auth/usecase/get_current_user.dart';
import '../../../service_locator.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  Future<void> appStarted() async {
    final isFirstTime = await sl<AuthRepository>().isFirstTime();
    if (isFirstTime) {
      emit(FirstTimeUser());
    } else {
      final user = await sl<GetCurrentUserUseCase>().call();

      if (user != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    }
  }
}
