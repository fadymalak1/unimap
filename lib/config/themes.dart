import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final primaryColor = Color(0xFF027387);
  static final lightPrimary = Color(0x20027387);

  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    textTheme: GoogleFonts.tajawalTextTheme(), // Arabic support
  );

  static final dark = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    textTheme: GoogleFonts.tajawalTextTheme(), // Arabic support
  );
}
