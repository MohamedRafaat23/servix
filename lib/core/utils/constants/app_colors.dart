import 'package:flutter/material.dart';

class AppColors {
  // Light Mode Colors
  static const Color lightSecondaryColor = Color(0xFF1A1A1A);
  static const Color lightPrimaryColor = Color(0xFF368CE1);
  static const Color darkPrimaryColor = Color(0xFF2A64BA);
  static const Color lightTextColor = Color(0xFF03405B);
  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color lightCardColor = Color(0xFFF5F5F5);
  static const Color lightSurfaceColor = Color(0xFFFFFFFF);
  static const Color borderGrayColor = Color(0xffC7C7C7);

  /// Slightly off-white background used for profile/settings screens.
  static const Color lightScaffoldBackgroundColor = Color(0xFFF9F9F9);


  static const Color darkSecondaryColor = Color(0xFF097DBA);
  static const Color darkAccentColor = Color(0xFF6CC5DF);
  static const Color darkTextColor = Color(0xFFE1E1E1);
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkCardColor = Color(0xFF1E1E1E);
  static const Color darkSurfaceColor = Color(0xFF2C2C2C);

  // Common Colors
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  static const Color warningColor = Color(0xFFF57C00);
  static const Color infoColor = Color(0xFF1976D2);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color greyColor = Color(0xFF979797);
   static const Color lightGreyColor = Color(0xFF82817E);
   static const Color mediumGreyColor = Color(0xFFA8A8A8);
  static const Color darkGreyColor = Color(0xFF848484);
   static const Color transparent = Colors.transparent;
  static const Color pendingColor = Color(0xFFFF8D28);
  static const Color confirmedColor = Color(0xFF1671B8);
  static const Color rejectColor = Color(0xFFFF383C);
   static const Color grey500Color = Color(0xFF82817E);
   static const Color borderMedical = Color(0xFF7AA8A8);
   static const Color darkBlueColor = Color(0xFF185D5C);
   static const Color greyLightColor = Color(0xFF3D4044);




  // Gradient Colors
  static List<Color> lightGradientColors = [
    lightSecondaryColor,
    lightPrimaryColor
  ];

  static List<Color> darkGradientColors = [
    const Color(0xFF6CC5DF),
    const Color(0xFF097DBA),
  ];

  // Legacy support (defaults to light mode colors)
  static const Color primaryColor = lightPrimaryColor;
  static const Color secondaryColor = lightSecondaryColor;
  static const Color accentColor = lightPrimaryColor;
  static const Color textColor = lightTextColor;
  static const Color backgroundColor = lightBackgroundColor;
  static List<Color> gradientColors = lightGradientColors;
}
