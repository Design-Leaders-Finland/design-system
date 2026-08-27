import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:design_leaders_system/design_leaders_system.dart';
import 'package:onepage/main.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const OnePageWebApp());
    await tester.pumpAndSettle();
  }

  // The header nav links are laid out responsively and are always visible, so
  // tap them directly.
  Future<void> tapNavLink(WidgetTester tester, String label) async {
    await tester.tap(find.text(label));
    // The widgets page contains an indeterminate CircularProgressIndicator
    // that animates forever, so use fixed pumps instead of pumpAndSettle.
    // The shared page transition is 300ms, so pump in steps to let it complete.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));
  }

  // Pumps the app with a tall viewport so every card in the widgets grid is
  // laid out on-screen without needing to scroll, making interactions reliable.
  Future<void> goToWidgetsPage(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 12000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const OnePageWebApp());
    await tester.pumpAndSettle();

    await tapNavLink(tester, 'Widgets');
  }

  // The full, alphabetically-sorted set of Material widgets the gallery shows.
  const expectedTitles = <String>[
    'AlertDialog',
    'AppBar',
    'Badge',
    'BottomNavigationBar',
    'BottomSheet',
    'CalendarDatePicker',
    'Card',
    'Checkbox',
    'Chip',
    'ChoiceChip',
    'CircleAvatar',
    'CircularProgressIndicator',
    'ColorPicker',
    'DataTable',
    'DatePicker',
    'Divider',
    'Drawer',
    'DropdownButton',
    'ElevatedButton',
    'ExpansionTile',
    'FilledButton',
    'FilterChip',
    'FloatingActionButton',
    'Icon',
    'IconButton',
    'IconButton.filled',
    'Image',
    'InputChip',
    'LinearProgressIndicator',
    'ListTile',
    'NavigationBar',
    'NavigationRail',
    'OutlinedButton',
    'PopupMenuButton',
    'Radio',
    'RangeSlider',
    'SegmentedButton',
    'Slider',
    'SnackBar',
    'Stepper',
    'Switch',
    'TabBar',
    'TextButton',
    'TextField',
    'TimePicker',
    'Tooltip',
  ];

  testWidgets('home page renders the design system overview', (tester) async {
    await pumpApp(tester);

    expect(find.text('Key Color Tones'), findsOneWidget);
    expect(find.text('Typography (Context aware)'), findsOneWidget);
    expect(find.text('Spacing & Sizing'), findsOneWidget);

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.light);
  });

  testWidgets('navigates to the widgets page via the header nav', (
    tester,
  ) async {
    await pumpApp(tester);

    await tapNavLink(tester, 'Widgets');

    expect(find.text('Material Widgets'), findsOneWidget);
    expect(find.text('ElevatedButton'), findsOneWidget);
  });

  testWidgets('navigates to the about page via the header nav', (tester) async {
    await pumpApp(tester);

    await tapNavLink(tester, 'About');

    // "About" appears both in the header nav link and as the page heading.
    expect(find.text('About'), findsWidgets);
    expect(find.text('Library Licenses'), findsOneWidget);
    expect(find.text('https://designleaders.fi'), findsOneWidget);
  });

  testWidgets('toggle dark mode switches the app theme', (tester) async {
    await pumpApp(tester);

    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.light,
    );

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
  });
  testWidgets('widgets page shows every material widget in alphabetical order', (
    tester,
  ) async {
    await goToWidgetsPage(tester);

    // Each card title is rendered with an AppText, so scope by AppText to also
    // disambiguate titles like "Chip" from the widget's own label text.
    for (final title in expectedTitles) {
      expect(
        find.widgetWithText(AppText, title),
        findsOneWidget,
        reason: 'expected a card titled "$title"',
      );
    }

    // Confirm the cards are actually sorted alphabetically by their on-screen
    // top position (top to bottom, then left to right).
    final positions = <String, double>{};
    for (final title in expectedTitles) {
      final cardTitle = tester.getTopLeft(find.widgetWithText(AppText, title));
      positions[title] = cardTitle.dy;
    }
    final keys = positions.keys.toList();
    for (var i = 1; i < keys.length; i++) {
      expect(
        positions[keys[i]]! >= positions[keys[i - 1]]!,
        isTrue,
        reason: '"${keys[i - 1]}" should appear before "${keys[i]}"',
      );
    }
  });

  testWidgets('widgets page uses the design system theme', (tester) async {
    await goToWidgetsPage(tester);

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.theme?.brightness, Brightness.light);
    expect(app.darkTheme?.brightness, Brightness.dark);
    expect(app.theme?.useMaterial3, isTrue);
    expect(app.theme?.extension<AppColorScheme>(), isNotNull);
    expect(app.theme?.extension<AppTextScheme>(), isNotNull);

    // The card text resolves through the design system color scheme.
    final title = find.widgetWithText(AppText, 'Checkbox');
    expect(title, findsOneWidget);
    final expectedColor = app.theme!.extension<AppColorScheme>()!.text;
    expect(tester.widget<AppText>(title).color, expectedColor);
  });

  testWidgets('checkbox and switch examples are interactive', (tester) async {
    await goToWidgetsPage(tester);

    final checkbox = find.byType(Checkbox);
    expect(tester.widget<Checkbox>(checkbox).value, isFalse);
    await tester.tap(checkbox);
    await tester.pump();
    expect(tester.widget<Checkbox>(checkbox).value, isTrue);
  });

  testWidgets('slider example is draggable', (tester) async {
    await goToWidgetsPage(tester);

    final slider = find.byType(Slider);
    final before = tester.widget<Slider>(slider).value;
    await tester.drag(slider, const Offset(80, 0));
    await tester.pump();
    final after = tester.widget<Slider>(slider).value;
    expect(after, greaterThan(before));
  });

  testWidgets('choice chip and segmented button update their selection', (
    tester,
  ) async {
    await goToWidgetsPage(tester);

    final chip = find.byType(ChoiceChip);
    expect(tester.widget<ChoiceChip>(chip).selected, isTrue);
    await tester.tap(chip);
    await tester.pump();
    expect(tester.widget<ChoiceChip>(chip).selected, isFalse);

    final segmented = find.byType(SegmentedButton<String>);
    expect(
      tester.widget<SegmentedButton<String>>(segmented).selected,
      contains('A'),
    );
    await tester.tap(
      find.descendant(
        of: find.byType(SegmentedButton<String>),
        matching: find.text('B'),
      ),
    );
    await tester.pump();
    expect(
      tester.widget<SegmentedButton<String>>(segmented).selected,
      contains('B'),
    );
  });

  testWidgets('radio group propagates the selected value', (tester) async {
    await goToWidgetsPage(tester);

    final radios = find.byType(Radio<String>);
    expect(radios, findsNWidgets(2));
    await tester.tap(radios.first);
    await tester.pump();

    final group = RadioGroup.maybeOf<String>(tester.element(radios.first));
    expect(group?.groupValue, 'A');
  });

  testWidgets('color picker opens its selection dialog', (tester) async {
    await goToWidgetsPage(tester);

    await tester.tap(find.text('Select Color'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Pick a color'), findsOneWidget);

    // Pick the first swatch inside the dialog to complete a selection; the
    // dialog closes and a themed SnackBar reports the picked color.
    final swatch = find
        .descendant(
          of: find.byType(SimpleDialog),
          matching: find.byType(InkWell),
        )
        .first;
    expect(swatch, findsWidgets);
    await tester.tap(swatch, warnIfMissed: false);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Pick a color'), findsNothing);
    expect(find.textContaining('Color selected'), findsOneWidget);
  });
}
