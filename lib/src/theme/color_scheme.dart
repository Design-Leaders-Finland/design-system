import 'package:flutter/material.dart'
    show ColorScheme, Brightness, ThemeExtension, Color;
import 'package:flutter/foundation.dart' show immutable;
import "../tokens/colors/colors.dart";

const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.primary,
  secondary: AppColors.secondary,
  error: AppColors.danger,
  onError: AppColors.danger,
  onPrimary: AppColors.text,
  onSecondary: AppColors.text,
  surface: AppColors.background,
  onSurface: AppColors.text,
);

const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary,
  secondary: AppColors.secondary,
  error: AppColors.danger,
  onError: AppColors.danger,
  onPrimary: AppColors.text,
  onSecondary: AppColors.text,
  surface: AppColors.background,
  onSurface: AppColors.text,
);

@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color text;
  final Color danger;
  final Color surface;
  final Color primaryOnDarkBackground;
  final Color textOnDarkBackground;
  final Color textOnBackground;
  final Color primaryOnBackground;
  final Color border;
  final Color accent;

  const AppColorScheme({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.text,
    required this.danger,
    required this.surface,
    required this.primaryOnDarkBackground,
    required this.textOnDarkBackground,
    required this.textOnBackground,
    required this.primaryOnBackground,
    required this.border,
    required this.accent,
  });

  factory AppColorScheme.light() => const AppColorScheme(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    background: AppColors.background,
    text: AppColors.text,
    danger: AppColors.danger,
    surface: AppColors.background,
    primaryOnDarkBackground: AppColors.primaryOnDarkBackground,
    textOnDarkBackground: AppColors.textOnDarkBackground,
    textOnBackground: AppColors.textOnBackground,
    primaryOnBackground: AppColors.primaryOnBackground,
    border: AppColors.border,
    accent: AppColors.accent,
  );

  factory AppColorScheme.dark() => const AppColorScheme(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    background: AppColors.background,
    text: AppColors.text,
    danger: AppColors.danger,
    surface: AppColors.background,
    primaryOnDarkBackground: AppColors.primaryOnDarkBackground,
    textOnDarkBackground: AppColors.textOnDarkBackground,
    textOnBackground: AppColors.textOnBackground,
    primaryOnBackground: AppColors.primaryOnBackground,
    border: AppColors.border,
    accent: AppColors.accent,
  );

  @override
  ThemeExtension<AppColorScheme> copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? text,
    Color? danger,
    Color? surface,
    Color? primaryOnDarkBackground,
    Color? textOnDarkBackground,
    Color? textOnBackground,
    Color? primaryOnBackground,
    Color? border,
    Color? accent,
  }) {
    return AppColorScheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      text: text ?? this.text,
      danger: danger ?? this.danger,
      surface: surface ?? this.surface,
      primaryOnDarkBackground:
          primaryOnDarkBackground ?? this.primaryOnDarkBackground,
      textOnDarkBackground: textOnDarkBackground ?? this.textOnDarkBackground,
      textOnBackground: textOnBackground ?? this.textOnBackground,
      primaryOnBackground: primaryOnBackground ?? this.primaryOnBackground,
      border: border ?? this.border,
      accent: accent ?? this.accent,
    );
  }

  @override
  ThemeExtension<AppColorScheme> lerp(
    ThemeExtension<AppColorScheme>? other,
    double t,
  ) {
    if (other is! AppColorScheme) return this;
    return AppColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      text: Color.lerp(text, other.text, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      primaryOnDarkBackground: Color.lerp(
        primaryOnDarkBackground,
        other.primaryOnDarkBackground,
        t,
      )!,
      textOnDarkBackground: Color.lerp(
        textOnDarkBackground,
        other.textOnDarkBackground,
        t,
      )!,
      textOnBackground: Color.lerp(
        textOnBackground,
        other.textOnBackground,
        t,
      )!,
      primaryOnBackground: Color.lerp(
        primaryOnBackground,
        other.primaryOnBackground,
        t,
      )!,
      border: Color.lerp(border, other.border, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
    );
  }
}
