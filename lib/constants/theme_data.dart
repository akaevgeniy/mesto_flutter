import 'package:flutter/material.dart';
import 'package:mesto_flutter/constants/theme_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: ThemeColors.white,
      fontFamily: 'Arial',
      primaryColor: ThemeColors.primary,
      canvasColor: Colors.transparent,
      splashColor: ThemeColors.primary.withOpacity(0.1),
      highlightColor: ThemeColors.primary.withOpacity(0.1),
      // primarySwatch: Colors.blue[800],
      hintColor: ThemeColors.primary,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      textTheme: TextTheme(
        displayMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22.0,
            color: ThemeColors.black),
        displaySmall: TextStyle(
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 18.0,
          height: 1.2,
          color: ThemeColors.black,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 14.0,
          height: 1.2,
          color: ThemeColors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: 16.0,
          height: 1.15,
          color: ThemeColors.black60,
        ),
        bodySmall: TextStyle(
          fontSize: 14.0,
          height: 1.14,
          color: ThemeColors.black60,
        ),
        labelLarge: TextStyle(
          fontSize: 12.0,
          height: 1.15,
          color: ThemeColors.black60,
        ),
        labelSmall: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          height: 1.2,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
