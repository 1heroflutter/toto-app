import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mytodoapp/common/helper/ai_command_parser.dart';
import 'package:mytodoapp/data/assistant/repositories/assistant_repository_impl.dart';
import 'package:mytodoapp/data/assistant/sources/assistant_remote_datasource.dart';
import 'package:mytodoapp/data/auth/repositories/auth_repositoriy_impl.dart';
import 'package:mytodoapp/data/auth/sources/auth_local_data.dart';
import 'package:mytodoapp/data/auth/sources/auth_remote_data.dart';
import 'package:mytodoapp/data/task/repositories/task_repository_impl.dart';
import 'package:mytodoapp/data/task/sources/task_service_impl.dart';
import 'package:mytodoapp/domain/assistant/repositories/assistant_repository.dart';
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
import 'package:mytodoapp/presentation/assistant/bloc/assistant_bloc.dart';

import 'domain/assistant/usecases/send_message_usecase.dart';
import 'domain/auth/usecase/get_current_user.dart';

final sl = GetIt.instance;

void setUpServiceLocator() {
  //service
  sl.registerSingleton<AuthRemoteData>(AuthRemoteDataImpl());
  sl.registerSingleton<AuthLocalData>(AuthLocalDataImpl());
  sl.registerSingleton<TaskService>(TaskServiceImpl());
  sl.registerSingleton<AssistantRemoteDataSource>(AssistantRemoteDataSourceImpl(http.Client()));
  //repo
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<TaskRepository>(TaskRepositoryImpl());
  sl.registerSingleton<AssistantRepository>(AssistantRepositoryImpl());
  //usecase
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase());
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<GetCurrentUserUseCase>(GetCurrentUserUseCase());
  sl.registerSingleton<SignInWithGoogleUseCase>(SignInWithGoogleUseCase());
  sl.registerSingleton<AddTaskUseCase>(AddTaskUseCase());
  sl.registerSingleton<GetAllTaskUseCase>(GetAllTaskUseCase());
  sl.registerSingleton<GetTaskByDateTaskUseCase>(GetTaskByDateTaskUseCase());
  sl.registerSingleton<DeleteTaskUseCase>(DeleteTaskUseCase());
  sl.registerSingleton<UpdateTaskUseCase>(UpdateTaskUseCase());
  sl.registerSingleton<IsLoginUseCase>(IsLoginUseCase());
  sl.registerSingleton<IsDoneTaskUseCase>(IsDoneTaskUseCase());

  sl.registerSingleton<SendMessageUseCase>(SendMessageUseCase());
  sl.registerFactory<AssistantBloc>(() => AssistantBloc(sendMessageUseCase: sl(), parser: AiCommandParser()));
}
