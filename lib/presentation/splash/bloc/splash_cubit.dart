
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp/domain/auth/usecase/is_loggin.dart';
import 'package:mytodoapp/presentation/splash/bloc/splash_state.dart';
import '../../../service_locator.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  Future<void> appStarted() async {
    await Future.delayed(Duration(seconds: 2));
    try {
      final isLoggedIn = await sl<IsLogginUseCase>().call();
      isLoggedIn.fold((e) {
        emit(Unauthenticated());
      }, (r) {
        emit(Authenticated());
      });
    } catch (e) {
      print("SplashCubit error: $e");
      emit(Unauthenticated());
    }
    emit(Authenticated());
  }
}
