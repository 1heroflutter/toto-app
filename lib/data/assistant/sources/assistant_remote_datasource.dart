import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mytodoapp/core/config/env_config.dart';

abstract class AssistantRemoteDataSource {
  Future<String> sendMessageToAi(String prompt);
}

class AssistantRemoteDataSourceImpl extends AssistantRemoteDataSource {
  final http.Client client;

  AssistantRemoteDataSourceImpl(this.client);

  @override
  Future<String> sendMessageToAi(String prompt) async {
    const endpoint = 'https://openrouter.ai/api/v1/chat/completions';
    final apiKey = EnvConfig.openRouterApiKey;

    final response = await client.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        // Sử dụng model free vì hết tiền :((
        "model": "openai/gpt-oss-20b:free",
        "messages": [
          {
            "role": "system",
            "content": """ Bạn là trợ lý quản lý công việc 
          Cấu trúc Task mà hệ thống sử dụng:
          TaskModel{
            final String? id;
            final String? uid;
            final bool? isDone;
            final String? title;
            final String content;
            final DateTime? date;
            final CategoryModel? category;
            final int? priority;
          }
          
          Khi người dùng yêu cầu thêm/sửa/xóa hoặc hoàn thành task,
          hãy trả vè JSON có dạng :
          {
            "action": "add_task" | "update_task" | "delete_task" | "is_done",
            "parameters":{ ... }
          }
          Nếu chỉ là trò chuyện bình thường, trả về text mô tả.
          """,
          },
          {"role": "user", "content": prompt},
        ],
        "max_tokens": 1000,
        "temperature": 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception(
        "Failed to get response: ${response.statusCode} - ${response.body}",
      );
    }
  }
}
