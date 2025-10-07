
import 'package:mytodoapp/service_locator.dart';

import '../../../domain/assistant/repositories/assistant_repository.dart';
import '../sources/assistant_remote_datasource.dart';

class AssistantRepositoryImpl extends AssistantRepository {
  @override
  Future<String> getAiResponse(String userMessage) {
    return sl<AssistantRemoteDataSource>().sendMessageToAi(userMessage);
  }
}
