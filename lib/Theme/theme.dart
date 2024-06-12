import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    // textTheme: GoogleFonts.robotoTextTheme(),
    colorScheme: ColorScheme.light(
        background: const Color.fromARGB(255, 243, 241, 241),
        primary: Colors.blue.shade600));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    // textTheme: GoogleFonts.robotoTextTheme(),
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary: Colors.blue.shade600,
    ),
    cardColor: Colors.grey.shade800);
