import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mytodoapp/core/config/env_config.dart';

import '../../../domain/task/entities/task_entity.dart';

abstract class AssistantRemoteDataSource {
  Future<String> sendMessageToAi(String prompt, List<TaskEntity> currentTasks);
}
class AssistantRemoteDataSourceImpl extends AssistantRemoteDataSource {
  final http.Client client;

  AssistantRemoteDataSourceImpl(this.client);

  @override
  Future<String> sendMessageToAi(
    String prompt,
    List<TaskEntity> currentTasks,
  ) async {
    final taskContext = currentTasks
        .map(
          (t) => "- ID: ${t.id} | Title: ${t.title} | Priority: ${t.priority}",
        )
        .join("\n");
    const endpoint = 'https://openrouter.ai/api/v1/chat/completions';
    final apiKey = EnvConfig.openRouterApiKey;

    try {
      final response = await client
          .post(
            Uri.parse(endpoint),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $apiKey',
            },
            body: jsonEncode({
              // Sử dụng free model vì hết tiền :((
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
          
          Bạn là trợ lý quản lý công việc. Dưới đây là danh sách các công việc hiện tại của người dùng:
          ----------------
          $taskContext
          ----------------
          Khi người dùng yêu cầu thêm/sửa/xóa hoặc hoàn thành task,
          hãy trả vè JSON  có dạng(lưu ý không trả về kiểu dữ liệu, code, hoặc suy nghĩ sử lý về phía client :
          {
            "action": "add_task" | "update_task" | "delete_task" | "is_done",
            "parameters":{ ... }
          }
          
          Quy tắc quan trọng:
          1. Nếu người dùng muốn XÓA hoặc SỬA, hãy tìm ID tương ứng trong danh sách trên và trả về trong field "id".
          2. Cấu trúc TaskModel... (giữ nguyên như cũ)
          3. JSON trả về cho update:
             {
               "action": "update_task",
               "parameters": { "id": "...", "title": "...", "content": "..." } // Chỉ điền field cần sửa
             }
          Nếu chỉ là trò chuyện bình thường, trả về text mô tả.
          """,
                },
                {"role": "user", "content": prompt},
              ],
              "max_tokens": 1000,
              "temperature": 0.7,
            }),
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        throw Exception(
          "Failed to get response: ${response.statusCode} - ${response.body}",
        );
      }
    } on TimeoutException {
      throw Exception("Request timed out. Please check your connection.");
    } catch (e) {
      // Ném lại lỗi để BLoC có thể bắt được
      rethrow;
    }
  }
}
