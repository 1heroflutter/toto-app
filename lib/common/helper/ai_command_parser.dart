import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mytodoapp/domain/assistant/entities/assistant_action.dart';

class AiCommandParser {
  AiAction? parse(String response) {
    try {
      // Nếu AI trả JSON bọc trong ```json ... ``` thì loại bỏ
      final cleaned = response
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      final data = jsonDecode(cleaned);
      if (data is Map && data.containsKey('action')) {
        return AiAction(
          name: data['action'],
          arguments: Map<String, dynamic>.from(data['parameters'] ?? {}),
        );
      }
    } catch (e) {
      debugPrint("⚠️ Parser failed: $e");
    }
    return null;
  }
}
