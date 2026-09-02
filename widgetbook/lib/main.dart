import 'package:design_leaders_system/design_leaders_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'catalog/material_catalog.dart';

// Web-only Widgetbook gallery for the Design Leaders Finland design system.
//
// `Widgetbook.material` boots a Material-flavoured Widgetbook: every use case is
// wrapped by `materialAppBuilder`, so it already has a `Navigator` and
// `ScaffoldMessenger` for the overlays used across the catalog (dialogs, bottom
// sheets, snack bars, date/time pickers, …).
//
// Theming is delegated to [MaterialThemeAddon], which wraps each use case in a
// [Theme] driven by the design system's own [ThemeData]. That means every
// Material widget in the catalog is rendered with the design system colors, and
// the light/dark variants can be switched straight from the Widgetbook toolbar.
void main() {
  // Built once and referenced by identity: [ThemeAddon] asserts that
  // `initialTheme` is contained in `themes`, and `AppTheme.lightTheme` returns a
  // fresh [ThemeData] on every call, so sharing the same list elements keeps the
  // assertion true by reference rather than relying on `ThemeData.==`.
  final themes = <WidgetbookTheme<ThemeData>>[
    WidgetbookTheme<ThemeData>(
      name: 'Design System · Light',
      data: AppTheme.lightTheme,
    ),
    WidgetbookTheme<ThemeData>(
      name: 'Design System · Dark',
      data: AppTheme.darkTheme,
    ),
  ];

  runApp(
    Widgetbook.material(
      directories: materialDirectories,
      addons: [
        MaterialThemeAddon(themes: themes, initialTheme: themes.first),
        AlignmentAddon(),
        GridAddon(8),
        TextScaleAddon(),
        ZoomAddon(),
        InspectorAddon(),
      ],
    ),
  );
}
