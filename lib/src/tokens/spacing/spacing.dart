import 'package:flutter/widgets.dart';
import '../../utils/utils.dart' show PlatformHelper;

/// Base unit for spacing and sizing, following a 4px scale.
const double baseUnit = 4.0;

/// Spacing density tokens to adjust the overall spacing scale of the app.
const compactDensityScale = 0.875;
const comfortableDensityScale = 1.0;
const looseDensityScale = 1.125;

/// Spacing density tokens to adjust the overall spacing scale of the app.
enum SpacingDensity { compact, comfortable, loose }

extension DensityScale on SpacingDensity {
  double get scale => switch (this) {
    SpacingDensity.compact => compactDensityScale,
    SpacingDensity.comfortable => comfortableDensityScale,
    SpacingDensity.loose => looseDensityScale,
  };
}

/// Border-radius tokens — based of a 4px unit system.
@immutable
final class AppBorderRadius {
  static const double none = 0;
  static const double xs = baseUnit * 0.25;
  static const double sm = baseUnit * 0.5;
  static const double base = baseUnit * 1.0;
  static const double md = baseUnit * 1.5;
  static const double lg = baseUnit * 2.0;
  static const double xl = baseUnit * 2.5;
  static const double xxl = baseUnit * 3.0;
  static const double full = 9999.0;
}

/// Shadow tokens — based on Material Design's shadow system, using a semi-transparent black color for all shadows.
@immutable
class AppShadow {
  static final List<BoxShadow> none = PlatformHelper.select<List<BoxShadow>>(
    const [],
  );
  static final List<BoxShadow> xs = PlatformHelper.select<List<BoxShadow>>(
    const [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 0.5,
        offset: Offset(0, 0.5),
      ),
    ],
    android: const [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 0.5,
        offset: Offset(0, 0.5),
      ),
    ],
    ios: const [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 0.5,
        offset: Offset(0, 0.5),
      ),
    ],
  );

  static final List<BoxShadow> sm = PlatformHelper.select<List<BoxShadow>>(
    const [
      BoxShadow(color: Color(0x1A000000), blurRadius: 1, offset: Offset(0, 1)),
    ],
    android: const [
      BoxShadow(color: Color(0x1A000000), blurRadius: 1, offset: Offset(0, 1)),
    ],
    ios: const [
      BoxShadow(color: Color(0x1A000000), blurRadius: 1, offset: Offset(0, 1)),
    ],
  );

  static final List<BoxShadow> base = PlatformHelper.select<List<BoxShadow>>(
    const [
      BoxShadow(color: Color(0x1A000000), blurRadius: 2, offset: Offset(0, 2)),
    ],
    android: const [
      BoxShadow(color: Color(0x1A000000), blurRadius: 2, offset: Offset(0, 2)),
    ],
    ios: const [
      BoxShadow(color: Color(0x1A000000), blurRadius: 2, offset: Offset(0, 2)),
    ],
  );

  static final List<BoxShadow> md = PlatformHelper.select<List<BoxShadow>>(
    const [
      BoxShadow(color: Color(0x1A000000), blurRadius: 3, offset: Offset(0, 3)),
    ],
    android: const [
      BoxShadow(color: Color(0x1A000000), blurRadius: 3, offset: Offset(0, 3)),
    ],
    ios: const [
      BoxShadow(color: Color(0x1A000000), blurRadius: 3, offset: Offset(0, 3)),
    ],
  );

  static final List<BoxShadow> lg = PlatformHelper.select<List<BoxShadow>>(
    const [
      BoxShadow(color: Color(0x1A000000), blurRadius: 6, offset: Offset(0, 6)),
    ],
    android: const [
      BoxShadow(color: Color(0x1A000000), blurRadius: 6, offset: Offset(0, 6)),
    ],
    ios: const [
      BoxShadow(color: Color(0x1A000000), blurRadius: 6, offset: Offset(0, 6)),
    ],
  );

  static final List<BoxShadow> xl = PlatformHelper.select<List<BoxShadow>>(
    const [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 12,
        offset: Offset(0, 12),
      ),
    ],
    android: const [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 12,
        offset: Offset(0, 12),
      ),
    ],
    ios: const [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 12,
        offset: Offset(0, 12),
      ),
    ],
  );

  static final List<BoxShadow> xxl = PlatformHelper.select<List<BoxShadow>>(
    const [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 24,
        offset: Offset(0, 24),
      ),
    ],
    android: const [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 24,
        offset: Offset(0, 24),
      ),
    ],
    ios: const [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 24,
        offset: Offset(0, 24),
      ),
    ],
  );
}

/// {@template app_spacing}
/// Spacing class for themes which provides direct access with static fields.
/// {@endtemplate}
/// Spacing tokens for application components, allowing for different spacing values for different components based on the selected density.
@immutable
class Spacing {
  static const double baseUnit = 4;

  static double scale(double multiplier) => baseUnit * multiplier;

  static const double s0 = 0; // 0px
  static const double s0_5 = baseUnit * 0.5; // 2px
  static const double s1 = baseUnit * 1; // 4px
  static const double s1_5 = baseUnit * 1.5; // 6px
  static const double s2 = baseUnit * 2; // 8px
  static const double s2_5 = baseUnit * 2.5; // 10px
  static const double s3 = baseUnit * 3; // 12px
  static const double s3_5 = baseUnit * 3.5; // 14px
  static const double s4 = baseUnit * 4; // 16px
  static const double s4_5 = baseUnit * 4.5; // 18px
  static const double s5 = baseUnit * 5; // 20px
  static const double s6 = baseUnit * 6; // 24px
  static const double s7 = baseUnit * 7; // 28px
  static const double s8 = baseUnit * 8; // 32px
  static const double s8_5 = baseUnit * 8.5; // 34px
  static const double s9 = baseUnit * 9; // 36px
  static const double s10 = baseUnit * 10; // 40px
  static const double s11 = baseUnit * 11; // 44px
  static const double s12 = baseUnit * 12; // 48px
  static const double s14 = baseUnit * 14; // 56px
  static const double s15 = baseUnit * 15; // 60px
  static const double s16 = baseUnit * 16; // 64px
  static const double s18 = baseUnit * 18; // 72px
  static const double s20 = baseUnit * 20; // 80px
  static const double s24 = baseUnit * 24; // 96px
  static const double s25 = baseUnit * 25; // 100px
  static const double s26 = baseUnit * 26; // 104px
  static const double s28 = baseUnit * 28; // 112px
  static const double s32 = baseUnit * 32; // 128px
  static const double s36 = baseUnit * 36; // 144px
  static const double s40 = baseUnit * 40; // 160px
  static const double s44 = baseUnit * 44; // 176px
  static const double s48 = baseUnit * 48; // 192px
  static const double s52 = baseUnit * 52; // 208px
  static const double s56 = baseUnit * 56; // 224px
  static const double s60 = baseUnit * 60; // 240px
  static const double s64 = baseUnit * 64; // 256px
  static const double s72 = baseUnit * 72; // 288px
  static const double s80 = baseUnit * 80; // 320px
  static const double s96 = baseUnit * 96; // 384px
}