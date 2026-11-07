import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryYellow = Color(0xFFFFCC00);
  static const Color accentGold = Color(0xFFD4A017);
  static const Color background = Color(0xFF111613);
  static const Color surfaceCard = Color(0xFF1C231F);
  static const Color surfaceElevated = Color(0xFF26302B);
  static const Color eraTriassic = Color(0xFFC86D3B);
  static const Color eraJurassic = Color(0xFF2D7F5E);
  static const Color eraCretaceous = Color(0xFFC0392B);
  static const Color textLight = Color(0xFFF0EFEB);
  static const Color textMuted = Color(0xFF9FA8A3);
  static const Color borderSubtle = Color(0xFF2E3832);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryYellow,
        secondary: AppColors.accentGold,
        surface: AppColors.surfaceCard,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.textLight,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
        iconTheme: IconThemeData(color: AppColors.primaryYellow),
      ),
      cardTheme: CardThemeData(
            color: AppColors.surfaceCard,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.borderSubtle, width: 1),
            ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceElevated,
        contentTextStyle: const TextStyle(color: AppColors.textLight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}