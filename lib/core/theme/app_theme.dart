import 'package:flutter/material.dart';

class AppColors {
  // --- Primary Blue Palette (main tone) ---
  static const Color blue50 = Color(0xFFEAF4FF);
  static const Color blue100 = Color(0xFFD2E6FF);
  static const Color blue200 = Color(0xFFAED3FF);
  static const Color blue300 = Color(0xFF82B9FF);
  static const Color blue400 = Color(0xFF5CA3FF);
  static const Color blue500 = Color(0xFF2E8BFF); // Primary tone
  static const Color blue600 = Color(0xFF1976E9);
  static const Color blue700 = Color(0xFF155FC0);
  static const Color blue800 = Color(0xFF104B99);
  static const Color blue900 = Color(0xFF0B3573);

  // --- Accent Colors ---
  static const Color skyBlue = Color(0xFF00B8D4); // bright accent
  static const Color limeAccent = Color(0xFFCDFF72); // fun secondary accent
  static const Color orangeAccent = Color(0xFFFFB74D);

  // --- Status Colors ---
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF29B6F6);

  // --- Neutral Backgrounds & Text ---
  // static const Color background = Color(0xFFF9FBFD);
  static const Color background = Color(0xFFeef3f6);
  static const Color cardBackground = Color(0xFFE9F2FF);
  static const Color divider = Color(0xFFD6E2F3);
  static const Color textPrimary = Color(0xFF0E1E40);
  static const Color textPrimaryLight = Color(0xFF375A9E);
  static const Color textSecondary = Color(0xFF6883C2);

  static const Color absenceDayMarker = Color(0xFFFF6B6B);
  static const Color highlight = Color(0xFF00C896);
  static const Color highlight2 = Color(0xFFFFC107);
  static const Color highlight3 = Color(0xFFFF9EC7);
}

class AppTheme {
  static ThemeData blueTheme = ThemeData(
    primaryColor: AppColors.blue500,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme(
      primary: AppColors.blue500,
      primaryContainer: AppColors.blue100,
      secondary: AppColors.skyBlue,
      secondaryContainer: AppColors.limeAccent,
      surface: AppColors.cardBackground,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimary,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        fontFamily: 'Comfortaa',
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blue500,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shadowColor: AppColors.blue200.withValues(alpha: 0.6),
        elevation: 3,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.blue500,
        side: const BorderSide(color: AppColors.blue500, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.blue50,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.blue200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.blue200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.blue500, width: 2),
      ),
      hintStyle: const TextStyle(color: AppColors.textSecondary),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.divider, thickness: 1),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.blue100,
      selectedColor: AppColors.blue500,
      secondarySelectedColor: AppColors.blue300,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      labelStyle: const TextStyle(color: AppColors.textPrimary),
      secondaryLabelStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
