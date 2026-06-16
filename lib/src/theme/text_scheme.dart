import 'package:flutter/material.dart'
    show ThemeExtension, TextTheme, TextStyle;
import 'package:flutter/foundation.dart' show immutable;
import "../tokens/typography/typography.dart";

TextTheme appTextTheme = TextTheme(
  displayLarge: AppTypography.displayLg,
  displayMedium: AppTypography.displayMd,
  displaySmall: AppTypography.displaySm,
  headlineLarge: AppTypography.headlineLg,
  headlineMedium: AppTypography.headlineMd,
  headlineSmall: AppTypography.headlineSm,
  titleLarge: AppTypography.titleLg,
  titleMedium: AppTypography.titleMd,
  titleSmall: AppTypography.titleSm,
  bodyLarge: AppTypography.bodyLg,
  bodyMedium: AppTypography.bodyMd,
  bodySmall: AppTypography.bodySm,
  labelLarge: AppTypography.labelLg,
  labelMedium: AppTypography.labelMd,
  labelSmall: AppTypography.labelSm,
);

@immutable
class AppTextScheme extends ThemeExtension<AppTextScheme> {
  final TextStyle display;
  final TextStyle heading;
  final TextStyle subHeading;
  final TextStyle body;
  final TextStyle label;
  final TextStyle button;
  final TextStyle caption;

  const AppTextScheme({
    required this.display,
    required this.heading,
    required this.subHeading,
    required this.body,
    required this.label,
    required this.button,
    required this.caption,
  });

  factory AppTextScheme.light() => const AppTextScheme(
    display: AppTypography.displayMd,
    heading: AppTypography.headlineMd,
    subHeading: AppTypography.titleMd,
    body: AppTypography.bodyMd,
    label: AppTypography.labelMd,
    button: AppTypography.labelMd,
    caption: AppTypography.labelSm,
  );

  factory AppTextScheme.dark() => const AppTextScheme(
    display: AppTypography.displayMd,
    heading: AppTypography.headlineMd,
    subHeading: AppTypography.titleMd,
    body: AppTypography.bodyMd,
    label: AppTypography.labelMd,
    button: AppTypography.labelMd,
    caption: AppTypography.labelSm,
  );

  @override
  ThemeExtension<AppTextScheme> copyWith({
    TextStyle? display,
    TextStyle? heading,
    TextStyle? subHeading,
    TextStyle? body,
    TextStyle? label,
    TextStyle? button,
    TextStyle? caption,
  }) {
    return AppTextScheme(
      display: display ?? this.display,
      heading: heading ?? this.heading,
      subHeading: subHeading ?? this.subHeading,
      body: body ?? this.body,
      label: label ?? this.label,
      button: button ?? this.button,
      caption: caption ?? this.caption,
    );
  }

  @override
  ThemeExtension<AppTextScheme> lerp(
    ThemeExtension<AppTextScheme>? other,
    double t,
  ) {
    if (other is! AppTextScheme) return this;
    return AppTextScheme(
      display: TextStyle.lerp(display, other.display, t)!,
      heading: TextStyle.lerp(heading, other.heading, t)!,
      subHeading: TextStyle.lerp(subHeading, other.subHeading, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      button: TextStyle.lerp(button, other.button, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
    );
  }
}
