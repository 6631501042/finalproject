import 'package:flutter/material.dart';
// icons directions_car
class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    // final colorScheme = ColorScheme.fromSeed(
    //   seedColor: const Color(0xFF0F8B75),
    //   primary: const Color(0xFF0F8B75),
    //   secondary: const Color(0xFFE7A400),
    //   tertiary: const Color(0xFF234E70),
    //   surface: const Color(0xFFF7FAF9),
    // );

    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 139, 15, 15),
      primary: const Color.fromARGB(255, 139, 15, 15),
      secondary: const Color(0xFFE7A400),
      tertiary: const Color(0xFF234E70),
      surface: const Color(0xFFF7FAF9),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFF3F7F5),
      fontFamily: 'Roboto',

      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Color(0xFFF3F7F5),
        foregroundColor: Color(0xFF22312F),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD9E3DF)),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD9E3DF)),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.6),
        ),
      ),
    );
  }
}
