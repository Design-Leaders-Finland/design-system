import 'package:flutter/material.dart' show ThemeData, BuildContext, Theme;

import "color_scheme.dart";
import "text_scheme.dart";
import "../utils/utils.dart";
import "../tokens/spacing/spacing.dart";

/// Light and dark [ThemeData] bundled together so apps can adopt the whole
/// design system with a single accessor ([AppTheme.themes]).
final class AppThemeData {
  const AppThemeData({required this.light, required this.dark});

  /// The pre-configured light theme.
  final ThemeData light;

  /// The pre-configured dark theme.
  final ThemeData dark;
}

final class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: appTextTheme,
    extensions: [AppColorScheme.light(), AppTextScheme.light()],
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    textTheme: appTextTheme,
    extensions: [AppColorScheme.dark(), AppTextScheme.dark()],
  );

  /// Both pre-configured themes in one object for the easiest possible setup:
  ///
  /// ```dart
  /// MaterialApp(
  ///   theme: AppTheme.themes.light,
  ///   darkTheme: AppTheme.themes.dark,
  /// );
  /// ```
  static AppThemeData get themes =>
      AppThemeData(light: lightTheme, dark: darkTheme);
}

extension AppContextExtension on BuildContext {
  AppColorScheme get colors =>
      Theme.of(this).extension<AppColorScheme>() ?? AppColorScheme.light();
  AppTextScheme get textStyles =>
      Theme.of(this).extension<AppTextScheme>() ?? AppTextScheme.light();
  SpacingDensity get density => getAutoDensity(this);
}
