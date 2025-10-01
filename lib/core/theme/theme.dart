import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color bgColor = Color(0xFFF9EBD5);
  static Color primary = Color.fromARGB(255, 239, 210, 160);
  static Color scondary = Color.fromARGB(255, 255, 167, 123);
  static List<Color> cardColors = [
    Color(0xFFF8E4C5),
    Color(0xFFF8E4C5),
    Color(0xFFF8E4C5),
    Color(0xFFF8E4C5),
  ];
  static ThemeData lightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.light(
        background: bgColor,
        primary: primary,
        primaryContainer: scondary,
      ),
      textTheme: _lightTextTheme,
    );
  }

  static final TextTheme _lightTextTheme = TextTheme(
    bodyLarge: GoogleFonts.abel(fontSize: 25, fontWeight: FontWeight.bold),
    labelMedium: GoogleFonts.abel(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.black.withOpacity(0.4),
      
      
    ),
    headlineLarge: GoogleFonts.abel(
      fontSize: 40,
      fontWeight: FontWeight.w900,
      color: scondary,
    ),
  );
}
