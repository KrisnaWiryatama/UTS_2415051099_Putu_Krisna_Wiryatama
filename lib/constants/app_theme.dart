import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Brand Colors khas Nat Geo
  static const Color natGeoGreen = Color(0xFF0F8A5F);
  static const Color natGeoGreenDark = Color(0xFF0A5C3F);
  static const Color primaryYellow = Color(0xFFFFD200);

  // Background & Surface
  static const Color background = Color(0xFFF7F9F8);
  static const Color surface = Colors.white;
  static const Color surfaceElevated = Color(0xFFEDF2E8);
  static const Color surfaceCard = Colors.white;

  // Text Colors
  static const Color textDark = Color(0xFF1B2320);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color textLight = Colors.white;

  // Border & Divider
  static const Color borderSubtle = Color(0xFFE5E7EB);

  // Era Geologis Tags
  static const Color eraTriassic = Color(0xFFE65100);
  static const Color eraJurassic = Color(0xFF1565C0);
  static const Color eraCretaceous = Color(0xFF2E7D32);
}

class AppTheme {
  static ThemeData get lightTheme {
    final String headlineFamily = GoogleFonts.montserrat().fontFamily!;
    final String bodyFamily = GoogleFonts.plusJakartaSans().fontFamily!;

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: bodyFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.natGeoGreen,
        primary: AppColors.natGeoGreen,
        secondary: AppColors.primaryYellow,
        surface: AppColors.surface,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.natGeoGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: headlineFamily,
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.4,
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        // Judul Utama, Banner, & Nama Spesimen
        displayLarge: TextStyle(
          fontFamily: headlineFamily,
          fontSize: 26,
          fontWeight: FontWeight.w900,
          color: AppColors.textDark,
          letterSpacing: -0.2,
        ),
        titleLarge: TextStyle(
          fontFamily: headlineFamily,
          fontSize: 19,
          fontWeight: FontWeight.w900,
          color: AppColors.textDark,
          letterSpacing: 0.2,
        ),
        titleMedium: TextStyle(
          fontFamily: headlineFamily,
          fontSize: 15.5,
          fontWeight: FontWeight.w800,
          color: AppColors.textDark,
        ),
        // Deskripsi, Catatan Morfologi, & Fakta Fosil
        bodyLarge: TextStyle(
          fontFamily: bodyFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark,
          height: 1.45,
        ),
        bodyMedium: TextStyle(
          fontFamily: bodyFamily,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark,
          height: 1.4,
        ),
        bodySmall: TextStyle(
          fontFamily: bodyFamily,
          fontSize: 11.5,
          fontWeight: FontWeight.w400,
          color: AppColors.textMuted,
        ),
        // Badge Diet, Kategori, & Tombol
        labelLarge: TextStyle(
          fontFamily: headlineFamily,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}