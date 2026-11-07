import 'package:flutter/material.dart';

class AppColors {
  // 1. Signature Nat Geo Jungle Green
  static const Color natGeoGreen = Color(0xFF00A629);
  static const Color darkGreen = Color(0xFF007A1E);

  // 2. Nat Geo Iconic Yellow (Borders, Accents, Highlights)
  static const Color primaryYellow = Color(0xFFFFCC00);

  // 3. Clean Light Expedition Canvas
  static const Color background = Color(0xFFF7F9F6);
  static const Color surfaceCard = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFEBF1EC);

  // 4. Geological Era Badges
  static const Color eraTriassic = Color(0xFFE67E22);
  static const Color eraJurassic = Color(0xFF27AE60);
  static const Color eraCretaceous = Color(0xFFC0392B);

  // 5. Typography & Borders
  static const Color textDark = Color(0xFF141A16);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFF5A665E);
  static const Color borderSubtle = Color(0xFFE0E5E1);
}

class AppTheme {
  static ThemeData get natGeoTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.natGeoGreen,
        secondary: AppColors.primaryYellow,
        surface: AppColors.surfaceCard,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.natGeoGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceCard,
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.borderSubtle, width: 1),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.primaryYellow,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            );
          }
          return const TextStyle(color: AppColors.textMuted, fontSize: 12);
        }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryYellow,
          foregroundColor: AppColors.textDark,
          textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textDark,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}