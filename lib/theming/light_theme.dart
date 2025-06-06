import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trendz_merchant/theming/app_colors.dart';

// font Bodymedium light and dark for normal font
// color Primary is always gold
// hintcolor and cardcolor white and black toggle for light and dark theme
//for light theme cardcolor as background and foreground color as hintcolor

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.gold,
  hintColor: AppColors.black,

  scaffoldBackgroundColor: AppColors.white, // App background
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.gold, // App bar
    foregroundColor: AppColors.black, // App bar text
  ),
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.ubuntu(
      fontSize: 16,
      color: AppColors.black, // Primary text
    ),
    bodyMedium: GoogleFonts.ubuntu(
      fontSize: 14,
      color: AppColors.black, // Secondary text
    ),
    bodySmall: GoogleFonts.ubuntu(
      fontSize: 16,

      color: AppColors.black, // Headline
    ),
    headlineLarge: GoogleFonts.ubuntu(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.black, // Headline
    ),
    titleLarge: GoogleFonts.ubuntu(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.black, // Headline
    ),
    titleMedium: GoogleFonts.ubuntu(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.black, // Headline
    ),
  ),
  cardColor: AppColors.secondaryText, // Card background
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.gold, // Button background
      foregroundColor: AppColors.black, // Button text
    ),
  ),
);
