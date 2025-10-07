import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color bgColor = Color(0xFFF9EBD5);
  static Color primary = Color.fromARGB(255, 239, 210, 160);
  static Color scondary = Color(0xFFFFBE9E);
  static List<Color> cardColors = [
    Color(0xFFF8E4C5),
    Color(0xFFF8E4C5),
    Color(0xFFF8E4C5),
    Color(0xFFF8E4C5),
  ];
  static ThemeData lightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.light(
        surface: bgColor,
        primary: primary,
        primaryContainer: scondary,
      ),
      textTheme: _lightTextTheme,
    );
  }

  static final TextTheme _lightTextTheme = TextTheme(
    bodyLarge: GoogleFonts.abel(fontSize: 25, fontWeight: FontWeight.bold),
    bodyMedium: GoogleFonts.abel(fontSize: 18, fontWeight: FontWeight.bold),
    bodySmall: GoogleFonts.abel(fontSize: 14, fontWeight: FontWeight.bold),
    labelMedium: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.w700),
    headlineLarge: GoogleFonts.abel(
      fontSize: 40,
      fontWeight: FontWeight.w900,
      color: scondary,
    ),
  );
}
