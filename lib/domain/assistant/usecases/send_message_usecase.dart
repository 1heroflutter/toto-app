import 'package:mytodoapp/core/usecase/usecase.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';
import 'package:mytodoapp/service_locator.dart';

import '../repositories/assistant_repository.dart';
class SendMessageUseCase extends UseCase<String, String>{
  @override
  Future<String> call({String? params, List<TaskEntity>? tasks}) async {
    return await sl<AssistantRepository>().getAiResponse(params!, tasks!);
  }
}
