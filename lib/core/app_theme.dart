import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      splashColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.defaultColor,
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.active,
        elevation: 0,
        unselectedItemColor: AppColors.disabled,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        enableFeedback: true,
      ),
    );
  }
}
