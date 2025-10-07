import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodoapp/core/config/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorNotifier extends Notifier<Color> {
  @override
  Color build() {
    loadColor();
    return AppColors.primary;
  }

  Future<void> loadColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt("primaryColor");
    if (colorValue != null) {
      state = Color(colorValue);
      AppColors.setPrimary(state);
    }
  }

  Future<void> setColor(Color color) async {
    state = color;
    AppColors.setPrimary(color);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("primaryColor", color.value);
  }
}

final colorNotifierProvider =
NotifierProvider<ColorNotifier, Color>(() => ColorNotifier());
