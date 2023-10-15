import 'package:flutter/material.dart';
import 'k_colors.dart';

class KThemes {
  KThemes._();

  static final lightModeTheme = ThemeData(
    cardColor: const Color(0xffEEEEEE),
    primaryColor: KColors.mainColorLightMode,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: KColors.mainColorLightMode,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:  AppBarTheme(
      backgroundColor:Colors.grey.withOpacity(0.5),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: KColors.mainColorLightMode,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: KColors.mainColorLightMode,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),

      displaySmall: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 8,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
  static final darkModeTheme = ThemeData(
    cardColor: KColors.darknessColor,
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
    appBarTheme:   AppBarTheme(
      backgroundColor:const Color(0xFFB8B3B8).withOpacity(0.3),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: KColors.mainColorDarkMode,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: KColors.mainColorDarkMode,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        foregroundColor: KColors.mainColorLightMode,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: KColors.mainColorLightMode,
        ),
        backgroundColor: KColors.mainColorDarkMode,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 8,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
