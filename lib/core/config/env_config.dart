import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static Future<void> init() async {
    await dotenv.load(fileName: ".env");
  }

  static String get openRouterApiKey => dotenv.env['OPENROUTER_API_KEY'] ?? "";

  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'https://openrouter.ai/api/v1';
}
