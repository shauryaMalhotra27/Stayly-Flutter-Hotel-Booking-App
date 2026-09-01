import 'package:flutter/material.dart';

/// Centralized typography tokens based on Figma design.
class AppTypography {
  AppTypography._();

  static const String fontFamily = 'Inter'; // Defaulting to Inter as primary from Figma

  // Weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // TextTheme
  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(fontFamily: fontFamily, fontSize: 35.0, fontWeight: bold),
    displayMedium: TextStyle(fontFamily: fontFamily, fontSize: 22.0, fontWeight: bold),
    displaySmall: TextStyle(fontFamily: fontFamily, fontSize: 20.0, fontWeight: semiBold),
    
    headlineLarge: TextStyle(fontFamily: fontFamily, fontSize: 18.0, fontWeight: semiBold),
    headlineMedium: TextStyle(fontFamily: fontFamily, fontSize: 17.0, fontWeight: semiBold),
    headlineSmall: TextStyle(fontFamily: fontFamily, fontSize: 16.0, fontWeight: medium),
    
    titleLarge: TextStyle(fontFamily: fontFamily, fontSize: 16.0, fontWeight: semiBold),
    titleMedium: TextStyle(fontFamily: fontFamily, fontSize: 15.0, fontWeight: medium),
    titleSmall: TextStyle(fontFamily: fontFamily, fontSize: 14.0, fontWeight: medium),
    
    bodyLarge: TextStyle(fontFamily: fontFamily, fontSize: 16.0, fontWeight: regular),
    bodyMedium: TextStyle(fontFamily: fontFamily, fontSize: 14.0, fontWeight: regular),
    bodySmall: TextStyle(fontFamily: fontFamily, fontSize: 13.0, fontWeight: regular),
    
    labelLarge: TextStyle(fontFamily: fontFamily, fontSize: 14.0, fontWeight: medium),
    labelMedium: TextStyle(fontFamily: fontFamily, fontSize: 12.0, fontWeight: medium),
    labelSmall: TextStyle(fontFamily: fontFamily, fontSize: 10.0, fontWeight: regular),
  );
}

