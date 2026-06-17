import 'package:flutter/material.dart' show ThemeData, BuildContext, Theme;
import "color_scheme.dart";
import "text_scheme.dart";
import "../utils/utils.dart";
import "../tokens/spacing/spacing.dart";

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
}

extension AppContextExtension on BuildContext {
  AppColorScheme get colors =>
      Theme.of(this).extension<AppColorScheme>() ?? AppColorScheme.light();
  AppTextScheme get textStyles =>
      Theme.of(this).extension<AppTextScheme>() ?? AppTextScheme.light();
  SpacingDensity get density => getAutoDensity(this);
}
