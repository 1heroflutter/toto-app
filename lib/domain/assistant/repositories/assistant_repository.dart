import 'package:mytodoapp/domain/task/entities/task_entity.dart';

abstract class AssistantRepository {
  Future<String> getAiResponse(String userMessage, List<TaskEntity> task);
}
