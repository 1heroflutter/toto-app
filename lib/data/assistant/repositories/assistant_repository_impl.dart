
import 'package:mytodoapp/service_locator.dart';

import '../../../domain/assistant/repositories/assistant_repository.dart';
import '../../../domain/task/entities/task_entity.dart';
import '../sources/assistant_remote_datasource.dart';

class AssistantRepositoryImpl extends AssistantRepository {
  @override
  Future<String> getAiResponse(String userMessage, List<TaskEntity>? tasks) {
    return sl<AssistantRemoteDataSource>().sendMessageToAi(userMessage,tasks!);
  }
}
