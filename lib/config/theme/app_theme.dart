import 'package:flutter/material.dart';

import '../../core/utils/constants/app_colors.dart';
import '../../core/utils/constants/app_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
    fontFamily: AppFonts.appFont,
    brightness: Brightness.light,
    colorScheme:const ColorScheme.light(
      primary: AppColors.lightPrimaryColor,
      secondary: AppColors.lightSecondaryColor,
      surface: AppColors.lightSurfaceColor,
      error: AppColors.errorColor,
      onPrimary: AppColors.whiteColor,
      onSecondary: AppColors.whiteColor,
      onSurface: AppColors.lightTextColor,
      onError: AppColors.whiteColor,
    ),
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    appBarTheme:const AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      foregroundColor: AppColors.lightTextColor,
      titleTextStyle: TextStyle(
        color: AppColors.lightTextColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: AppFonts.appFont,
      ),
      iconTheme:  IconThemeData(color: AppColors.lightTextColor),
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimaryColor,
        foregroundColor: AppColors.whiteColor,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.lightPrimaryColor),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightTextColor),
      bodyMedium: TextStyle(color: AppColors.lightTextColor),
      bodySmall: TextStyle(color: AppColors.lightTextColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.lightPrimaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.greyColor),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.lightPrimaryColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.lightPrimaryColor),
    cardTheme: CardThemeData(
      color: AppColors.lightCardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    cardColor: AppColors.lightCardColor,
  );

  static ThemeData get darkTheme => ThemeData(
    fontFamily: AppFonts.appFont,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimaryColor,
      secondary: AppColors.darkSecondaryColor,
      surface: AppColors.darkSurfaceColor,
      error: AppColors.errorColor,
      onPrimary: AppColors.blackColor,
      onSecondary: AppColors.blackColor,
      onSurface: AppColors.darkTextColor,
      onError: AppColors.whiteColor,
    ),
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSurfaceColor,
      foregroundColor: AppColors.darkTextColor,
      titleTextStyle: TextStyle(
        color: AppColors.darkTextColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: AppFonts.appFont,
      ),
      iconTheme: IconThemeData(color: AppColors.darkTextColor),
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimaryColor,
        foregroundColor: AppColors.blackColor,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.darkPrimaryColor),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkTextColor),
      bodyMedium: TextStyle(color: AppColors.darkTextColor),
      bodySmall: TextStyle(color: AppColors.darkTextColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.darkPrimaryColor),
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.greyColor),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.darkPrimaryColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      filled: true,
      fillColor: AppColors.darkSurfaceColor,
    ),
    iconTheme: const IconThemeData(color: AppColors.darkPrimaryColor),
    cardTheme: CardThemeData(
      color: AppColors.darkCardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    cardColor: AppColors.darkCardColor,
  );

  static ThemeData get theme => lightTheme;
}
