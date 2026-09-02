// Catalog smoke test.
//
// This is a pure-Dart structural test: it walks the Widgetbook node tree that
// `main.dart` hands to `Widgetbook.material` and asserts the catalog is
// well-formed and comprehensive. Nothing is rendered, so the use-case builders
// (including the network `Image`) are never invoked.

import 'package:design_widgetbook/catalog/material_catalog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  // Collect every component in the catalog by walking the node tree.
  final components = <WidgetbookComponent>[];
  void walk(WidgetbookNode node) {
    if (node is WidgetbookComponent) components.add(node);
    for (final child in node.children ?? const <WidgetbookNode>[]) {
      walk(child);
    }
  }

  for (final root in materialDirectories) {
    walk(root);
  }
  final componentNames = components.map((c) => c.name).toSet();

  group('Material catalog', () {
    test('exposes one category per Material widget group', () {
      expect(materialDirectories, hasLength(7));
      expect(materialDirectories.map((c) => c.name).toList(), [
        'Actions',
        'Selection & Input',
        'Display & Data',
        'Layout & Navigation',
        'Feedback & Overlays',
        'Progress',
        'Design System',
      ]);
    });

    test('lists a broad set of Material + design system widgets', () {
      // The catalog should be comprehensive: comfortably more than the ~40
      // widgets in the onepage gallery.
      expect(components.length, greaterThanOrEqualTo(40));

      // A representative widget from each group must be present.
      for (final name in const [
        'ElevatedButton', 'IconButton', 'SegmentedButton', 'Chip', // Actions
        'Checkbox', // Selection & Input
        'Card', 'ListTile', // Display & Data
        'SnackBar', 'AlertDialog', // Feedback & Overlays
        'CircularProgressIndicator', // Progress
        'AppText', 'SolidButton', // Design System
      ]) {
        expect(componentNames, contains(name), reason: 'missing $name');
      }
    });

    test('every component has at least one buildable use case', () {
      for (final component in components) {
        expect(
          component.useCases,
          isNotEmpty,
          reason: '${component.name} has no use cases',
        );
        for (final useCase in component.useCases) {
          expect(useCase.name, isNotEmpty);
          expect(useCase.builder, isNotNull);
        }
      }
    });

    test('every category has children', () {
      for (final category in materialDirectories) {
        expect(category.children, isNotEmpty, reason: '${category.name} empty');
      }
    });
  });
}
