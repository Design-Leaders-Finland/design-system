import 'package:flutter/painting.dart';
import '../spacing/spacing.dart' show baseUnit;

final class FontFamily {
  static const String inter = "Inter";
}

final class FontSize {
  static const double xs = baseUnit * 3; // 12px
  static const double sm = baseUnit * 3.5; // 14px
  static const double base = baseUnit * 4; // 16px
  static const double md = baseUnit * 4.5; // 18px
  static const double lg = baseUnit * 6; // 24px
  static const double xl = baseUnit * 7; // 28px
  static const double xxl = baseUnit * 8; // 32px
  static const double xl3 = baseUnit * 9; // 36px
  static const double xl4 = baseUnit * 10; // 40px
  static const double xl5 = baseUnit * 11; // 44px

  double operator [](FontSize size) => switch (size) {
    FontSize.xs => xs,
    FontSize.sm => sm,
    FontSize.base => base,
    FontSize.md => md,
    FontSize.lg => lg,
    FontSize.xl => xl,
    FontSize.xxl => xxl,
    FontSize.xl3 => xl3,
    FontSize.xl4 => xl4,
    FontSize.xl5 => xl5,
    _ => throw ArgumentError('Invalid font size: $size'),
  };
}

final class AppLetterSpacing {
  static const double maxtight = -0.5;
  static const double normal = 0.1;
  static const double tight = 0.0;
  static const double tighter = -0.1;
  static const double tightest = -0.2;
  static const double ultratight = -0.3;
  static const double wide = 0.2;
}

final class AppLineHeight {
  static const double none = 1;
  static const double tight = 1.2;
  static const double snug = 1.3;
  static const double normal = 1.4;
  static const double relaxed = 1.5;
  static const double loose = 2.0;
}

final class AppFontWeight {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

final class AppTypography {
  // ── Display ──────────────────────────────────

  static const TextStyle displayLg = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSize.xl5,
    fontWeight: AppFontWeight.regular,
    height: AppLineHeight.tight,
    letterSpacing: AppLetterSpacing.tight,
  );

  static const TextStyle displayMd = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSize.xl4,
    fontWeight: AppFontWeight.regular,
    height: AppLineHeight.tight,
    letterSpacing: AppLetterSpacing.tight,
  );

  static const TextStyle displaySm = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSize.lg,
    fontWeight: AppFontWeight.regular,
    height: AppLineHeight.normal,
    letterSpacing: AppLetterSpacing.normal,
  );

  // ── Headline ─────────────────────────────────

  static const TextStyle headlineLg = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSize.xl,
    fontWeight: AppFontWeight.regular,
    height: AppLineHeight.snug,
    letterSpacing: AppLetterSpacing.normal,
  );

  static const TextStyle headlineMd = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSize.xl4,
    fontWeight: AppFontWeight.regular,
    height: AppLineHeight.snug,
    letterSpacing: AppLetterSpacing.normal,
  );

  static const TextStyle headlineSm = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSize.lg,
    fontWeight: AppFontWeight.regular,
    height: AppLineHeight.snug,
    letterSpacing: AppLetterSpacing.normal,
  );

  // ── Title ─────────────────────────────────────

  static const TextStyle titleLg = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSize.xl,
    fontWeight: AppFontWeight.medium,
    height: AppLineHeight.snug,
    letterSpacing: AppLetterSpacing.normal,
  );

  static const TextStyle titleMd = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSize.base,
    fontWeight: AppFontWeight.medium,
    height: AppLineHeight.normal,
    letterSpacing: AppLetterSpacing.normal,
  );

  static const TextStyle titleSm = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSize.sm,
    fontWeight: AppFontWeight.medium,
    height: AppLineHeight.normal,
    letterSpacing: AppLetterSpacing.normal,
  );

  // ── Body ──────────────────────────────────────

  static const TextStyle bodyLg = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSize.base,
    fontWeight: AppFontWeight.regular,
    height: AppLineHeight.normal,
    letterSpacing: AppLetterSpacing.normal,
  );

  static const TextStyle bodyMd = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSize.sm,
    fontWeight: AppFontWeight.regular,
    height: AppLineHeight.normal,
    letterSpacing: AppLetterSpacing.normal,
  );

  static const TextStyle bodySm = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSize.xs,
    fontWeight: AppFontWeight.regular,
    height: AppLineHeight.normal,
    letterSpacing: AppLetterSpacing.normal,
  );

  // ── Label ─────────────────────────────────────

  static const TextStyle labelLg = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSize.sm,
    fontWeight: AppFontWeight.medium,
    height: AppLineHeight.normal,
    letterSpacing: AppLetterSpacing.normal,
  );

  static const TextStyle labelMd = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSize.xs,
    fontWeight: AppFontWeight.medium,
    height: AppLineHeight.normal,
    letterSpacing: AppLetterSpacing.normal,
  );

  static const TextStyle labelSm = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: FontSize.xs,
    fontWeight: AppFontWeight.medium,
    height: AppLineHeight.normal,
    letterSpacing: AppLetterSpacing.normal,
  );
}
