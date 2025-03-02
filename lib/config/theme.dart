import 'package:flutter/material.dart';
import 'package:smart_attendance/config/app_pallete.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFF03A9F4);
  static const Color accentColor = Color(0xFF00BCD4);
  static const Color errorColor = Color(0xFFE57373);
  static const Color successColor = Color(0xFF81C784);
  static const Color warningColor = Color(0xFFFFB74D);

  static const double borderRadius = 8.0;
  static const double spacing = 16.0;
  static const double buttonHeight = 48.0;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: Apppallete.primaryColorLight,
        secondary: Apppallete.secondaryColor,
        error: Apppallete.error,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Apppallete.primaryColorLight,
        foregroundColor: Apppallete.textPrimaryLight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: Apppallete.primaryColorLight,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        filled: true,
        fillColor: Apppallete.lightGrey,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacing,
          vertical: spacing / 2,
        ),
      ),
      textTheme: TextTheme(
        // bodyText1: TextStyle(color: Apppallete.textPrimaryLight),
        // bodyText2: TextStyle(color: Apppallete.textSecondaryLight),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: Apppallete.primaryColorDark,
        secondary: Apppallete.secondaryColor,
        error: Apppallete.error,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Apppallete.darkGrey,
        foregroundColor: Apppallete.textPrimaryDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: Apppallete.primaryColorDark,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        filled: true,
        fillColor: Apppallete.darkGrey,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacing,
          vertical: spacing / 2,
        ),
      ),
      textTheme: TextTheme(
        // bodyText1: TextStyle(color: Apppallete.textPrimaryDark),
        // bodyText2: TextStyle(color: Apppallete.textSecondaryDark),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
