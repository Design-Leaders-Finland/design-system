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

  static const text = MaterialColor(0xFF1A1A2E, {500: Color(0xFF1A1A2E)});

  static const border = MaterialColor(0xFFD9E1F1, {500: Color(0xFFD9E1F1)});

  static const textOnBackground = MaterialColor(0xFF1A1A2E, {
    500: Color(0xFF1A1A2E),
  });

  static const primaryOnBackground = MaterialColor(0xFF1B2A4A, {
    500: Color(0xFF1B2A4A),
  });

  static const textOnDarkBackground = MaterialColor(0xFF1A1A2E, {
    50: Color(0xFF1A1A2E),
  });

  static const primaryOnDarkBackground = MaterialColor(0xFF1B2A4A, {
    500: Color(0xFF1B2A4A),
  });

  static const accent = MaterialColor(0xFF2F927B, {500: Color(0xFF2F927B)});
  static const background = MaterialColor(0xFFFAFBFC, {500: Color(0xFFFAFBFC)});

  /// Semantic colors
  static const danger = Color(0xFFB00020);
}