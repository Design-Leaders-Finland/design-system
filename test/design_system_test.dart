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

    expect(darkColors.primary, equals(AppColors.primaryOnDarkBackground));
    expect(AppTheme.darkTheme.colorScheme.primary, equals(AppColors.primaryOnDarkBackground));
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
}
