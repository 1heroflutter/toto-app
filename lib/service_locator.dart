import 'package:get_it/get_it.dart';
import 'package:mytodoapp/data/auth/repositories/auth_repositoriy_impl.dart';
import 'package:mytodoapp/data/auth/sources/auth_service_impl.dart';
import 'package:mytodoapp/data/task/repositories/task_repository_impl.dart';
import 'package:mytodoapp/data/task/sources/task_service_impl.dart';
import 'package:mytodoapp/domain/auth/repositories/auth_repository.dart';
import 'package:mytodoapp/domain/auth/usecase/is_loggin.dart';
import 'package:mytodoapp/domain/auth/usecase/signin.dart';
import 'package:mytodoapp/domain/auth/usecase/signin_with_google.dart';
import 'package:mytodoapp/domain/auth/usecase/signout.dart';
import 'package:mytodoapp/domain/auth/usecase/signup.dart';
import 'package:mytodoapp/domain/task/repositories/task_repository.dart';
import 'package:mytodoapp/domain/task/usecase/add_task.dart';
import 'package:mytodoapp/domain/task/usecase/delete_task.dart';
import 'package:mytodoapp/domain/task/usecase/get_all_task.dart';
import 'package:mytodoapp/domain/task/usecase/get_today_task.dart';
import 'package:mytodoapp/domain/task/usecase/isDone_task.dart';
import 'package:mytodoapp/domain/task/usecase/update_task.dart';

final sl = GetIt.instance;

void setUpServiceLocator() {
  //service
  sl.registerSingleton<AuthService>(AuthServiceImpl());
  sl.registerSingleton<TaskService>(TaskSeviceImpl());
  //repo
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<TaskRepository>(TaskRepositoryImpl());
  //usecase
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase());
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<SignInWithGoogleUseCase>(SignInWithGoogleUseCase());
  sl.registerSingleton<AddTaskUseCase>(AddTaskUseCase());
  sl.registerSingleton<GetAllTaskUseCase>(GetAllTaskUseCase());
  sl.registerSingleton<GetTaskByDateTaskUseCase>(GetTaskByDateTaskUseCase());
  sl.registerSingleton<DeleteTaskUseCase>(DeleteTaskUseCase());
  sl.registerSingleton<UpdateTaskUseCase>(UpdateTaskUseCase());
  sl.registerSingleton<IsLogginUseCase>(IsLogginUseCase());
  sl.registerSingleton<IsDoneTaskUseCase>(IsDoneTaskUseCase());
}
