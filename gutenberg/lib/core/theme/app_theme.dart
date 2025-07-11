import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: AppColors.primary,
        onSurface: AppColors.greyDark,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.secondary,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        displayMedium: GoogleFonts.montserrat(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        titleMedium: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: AppColors.greyDark,
        ),
        bodyLarge: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.greyDark,
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.greyDark,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: AppColors.primary.withAlpha(128),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: AppColors.primary.withAlpha(128),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.primary, width: 1),
        ),
        filled: true,
        fillColor: AppColors.secondary,
      ),
      cardTheme: const CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        elevation: 2,
        shadowColor: Color(0x1A5E56E7),
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ),
    );
  }
}
