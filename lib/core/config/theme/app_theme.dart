import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static lightTheme(Color primary) {
    return ThemeData(
      brightness: Brightness.light,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primary,
        strokeWidth: 2,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: ColorScheme.light(
        primary: primary,
        background: Colors.white,

        onPrimary: Colors.black,
        onSecondary: Colors.black12,
        brightness: Brightness.light,
        onSecondaryContainer: Colors.white,
        secondaryContainer: Colors.black54,
      ),
      primaryColor: primary,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.lightBackground,
        contentTextStyle: TextStyle(color: Colors.black),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: primary),
      searchBarTheme: SearchBarThemeData(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),

        backgroundColor: WidgetStatePropertyAll(Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightBackground,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary, width: 2),
          // viền khi focus
          borderRadius: BorderRadius.circular(8),
        ),
        hintStyle: const TextStyle(
          color: Color(0xff4E4B66),
          fontWeight: FontWeight.w300,
        ),
        contentPadding: EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(width: 2, color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(width: 2, color: Colors.black),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: primary, width: 1.2),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  static darkTheme(Color primary) {
    return ThemeData(
      brightness: Brightness.dark,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primary,
        strokeWidth: 2,
      ),
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.dark(
        primary: primary,
        background: Colors.black,
        onPrimary: Colors.white,
        onSecondary: Colors.grey,
        brightness: Brightness.dark,
        onSecondaryContainer: Colors.black,
        secondaryContainer: Colors.black38,
        primaryContainer: Colors.white38,
      ),

      primaryColor: primary,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkBackground,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: primary),
      searchBarTheme: SearchBarThemeData(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        backgroundColor: WidgetStatePropertyAll(Color(0xff3A3B3C)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xff3A3B3C),
        hintStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w300,
        ),
        contentPadding: EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: primary, width: 1.2),
          textStyle: TextStyle(fontSize: 16, color: Colors.white),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }
}
