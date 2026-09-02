import 'package:design_leaders_system/design_leaders_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dark theme uses different palette values than light theme', () {
    final lightColors = AppTheme.lightTheme.extension<AppColorScheme>()!;
    final darkColors = AppTheme.darkTheme.extension<AppColorScheme>()!;

    expect(lightColors.background, isNot(equals(darkColors.background)));
    expect(lightColors.surface, isNot(equals(darkColors.surface)));
    expect(lightColors.text, isNot(equals(darkColors.text)));
  });

  test('dark theme uses the dark-specific primary tone', () {
    final darkColors = AppTheme.darkTheme.extension<AppColorScheme>()!;

    expect(darkColors.primary, equals(AppColors.darkPrimary));
    expect(
      AppTheme.darkTheme.colorScheme.primary,
      equals(AppColors.darkPrimary),
    );
  });

  testWidgets('AppText follows the active theme text color in dark mode', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: Scaffold(body: AppText.heading('Hello dark theme')),
      ),
    );

    final textWidget = tester.widget<Text>(find.byType(Text));
    expect(textWidget.style?.color, equals(AppColors.darkText));
  });

  test('headline styles use Figtree and body/label use Asap Condensed', () {
    expect(AppTypography.headlineMd.fontFamily, equals(FontFamily.figTree));
    expect(AppTypography.bodyMd.fontFamily, equals(FontFamily.asapCondensed));
    expect(AppTypography.labelMd.fontFamily, equals(FontFamily.asapCondensed));
  });

  test(
    'AppTheme.themes exposes light and dark themes with design extensions',
    () {
      final themes = AppTheme.themes;

      expect(themes.light.brightness, Brightness.light);
      expect(themes.dark.brightness, Brightness.dark);
      expect(themes.light.useMaterial3, isTrue);
      expect(themes.dark.useMaterial3, isTrue);

      // Both carry the custom color & text schemes so consumers get everything
      // from a single accessor.
      expect(themes.light.extension<AppColorScheme>(), isNotNull);
      expect(themes.light.extension<AppTextScheme>(), isNotNull);
      expect(themes.dark.extension<AppColorScheme>(), isNotNull);
      expect(themes.dark.extension<AppTextScheme>(), isNotNull);

      // The two bundled themes still use the distinct light/dark palettes.
      final light = themes.light.extension<AppColorScheme>()!;
      final dark = themes.dark.extension<AppColorScheme>()!;
      expect(light.background, isNot(equals(dark.background)));
      expect(light.surface, isNot(equals(dark.surface)));
      expect(light.text, isNot(equals(dark.text)));
    },
  );

  test('AppTheme.themes matches the individual theme accessors', () {
    final themes = AppTheme.themes;

    expect(
      themes.light.extension<AppColorScheme>()!.primary,
      equals(AppColors.primary),
    );
    expect(
      themes.dark.extension<AppColorScheme>()!.primary,
      equals(AppColors.darkPrimary),
    );
    expect(themes.dark.colorScheme.primary, equals(AppColors.darkPrimary));
  });

  test('sizing tokens follow the 4px base unit scale', () {
    expect(Sizing.controlXs, equals(24));
    expect(Sizing.controlMd, equals(40));
    expect(Sizing.controlLg, equals(48));
    expect(Sizing.iconSm, equals(16));
    expect(Sizing.iconMd, equals(24));
    expect(Sizing.touchTarget, equals(44));
    expect(Sizing.sizeMd, equals(64));
    expect(Sizing.sizeXl, equals(128));
  });
}
