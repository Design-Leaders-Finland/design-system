import 'package:flutter/material.dart';

/// {@template app_colors}
/// Colors class for themes which provides direct access with static fields.
/// {@endtemplate}
final class AppColors {
  AppColors._();

  /// Neutral colors
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  /// The color transparent
  static const transparent = Color(0x00000000);

  static const primary = MaterialColor(0xFF1B2A4A, {500: Color(0xFF1B2A4A)});

  static const secondary = MaterialColor(0xFF614E96, {500: Color(0xFF614E96)});

  static const complementary = MaterialColor(0xFF7D91A5, {
    500: Color(0xFF7D91A5),
  });

  static const textDefault = MaterialColor(0xFF1A1A2E, {
    500: Color(0xFF1A1A2E),
  });

  static const textAlternate = MaterialColor(0xFF1A1A2E, {
    500: Color(0xFF1A1A2E),
  });

  static const border = MaterialColor(0xFFD9E1F1, {500: Color(0xFFD9E1F1)});

  static const hyperlink = Color.fromARGB(255, 24, 24, 254);

  static const textDefaultOnBackground = MaterialColor(0xFF1A1A2E, {
    500: Color(0xFF1A1A2E),
  });

  static const primaryOnBackground = MaterialColor(0xFF1B2A4A, {
    500: Color(0xFF1B2A4A),
  });

  static const accent = MaterialColor(0xFF2F927B, {500: Color(0xFF2F927B)});
  static const background = MaterialColor(0xFFFAFBFC, {500: Color(0xFFFAFBFC)});
  static const darkBackground = Color(0xFF0F172A);
  static const darkPrimary = Color(0xFFE4D5B5);
  static const darkSurface = Color(0xFF1E293B);
  static const darkText = Color(0xFFFFFFFF);
  static const darkTextAlternate = Color(0xFFC6C6C6);
  static const darkBorder = Color(0xFF334155);

  /// Semantic colors
  static const attention = Color.fromARGB(255, 0, 123, 255);
  static const warning = Color(0xFFFFA500);
  static const danger = Color(0xFFB00020);
  static const success = Color(0xFF4CAF50);
}
