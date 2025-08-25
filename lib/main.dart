import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodoapp/core/config/theme/app_theme.dart';
import 'package:mytodoapp/core/config/theme/theme_provider.dart';
import 'package:mytodoapp/presentation/splash/bloc/splash_cubit.dart';
import 'package:mytodoapp/presentation/splash/pages/splash.dart';
import 'package:mytodoapp/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode  = ref.read(themeNotifierProvider);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return BlocProvider(
      create: (_)=> SplashCubit()..appStarted(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        home:SplashPage(),
      ),
    );
  }
}

