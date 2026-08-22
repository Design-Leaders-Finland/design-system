import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:onepage/main.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const OnePageWebApp());
    await tester.pumpAndSettle();
  }

  // The header nav links are inside a horizontally scrolling row that clips
  // the trailing links, so scroll it into view before tapping a nav link.
  Future<void> tapNavLink(WidgetTester tester, String label) async {
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(-500, 0),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text(label));
    // The widgets page contains an indeterminate CircularProgressIndicator
    // that animates forever, so use fixed pumps instead of pumpAndSettle.
    // The shared page transition is 300ms, so pump in steps to let it complete.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));
  }

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
}
