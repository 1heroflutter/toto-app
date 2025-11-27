import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodoapp/core/config/env_config.dart';
import 'package:mytodoapp/core/config/theme/app_theme.dart';
import 'package:mytodoapp/core/config/theme/theme_provider.dart';
import 'package:mytodoapp/data/notify/sources/local_notification_service.dart';
import 'package:mytodoapp/presentation/home/bloc/task_cubit.dart';
import 'package:mytodoapp/presentation/is_first_time_user/bloc/splash_cubit.dart';
import 'package:mytodoapp/presentation/is_first_time_user/pages/splash.dart';
import 'package:mytodoapp/service_locator.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'core/config/theme/color_notifier.dart';
import 'domain/notify/usecase/schedule_notification.dart';
import 'domain/task/usecase/get_all_task.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUpServiceLocator();
  await LocalNotificationService.init();
  await EnvConfig.init();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    final primaryColor = ref.watch(colorNotifierProvider);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashCubit()..appStarted()),
        BlocProvider(
          create: (_) => TaskCubit(sl<GetAllTaskUseCase>())..getTasks(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(primaryColor),
        darkTheme: AppTheme.darkTheme(primaryColor),
        themeMode: themeMode,
        home: IsFirstTimePage(),
      ),
    );
  }
}
