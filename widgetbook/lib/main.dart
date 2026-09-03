import 'package:design_leaders_system/design_leaders_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'catalog/material_catalog.dart';
import 'gallery_header.dart';
import 'home.dart';
import 'theme_mode_store.dart';

// Web-only Widgetbook gallery for the Design Leaders Finland design system.
//
// `Widgetbook.material` boots a Material-flavoured Widgetbook: every use case is
// wrapped by `materialAppBuilder`, so it already has a `Navigator` and
// `ScaffoldMessenger` for the overlays used across the catalog (dialogs, bottom
// sheets, snack bars, date/time pickers, …).
//
// Theming is driven by a `ThemeAddon<ThemeMode>` offering System / Light / Dark.
// Unlike `MaterialThemeAddon` (which stores a fixed `ThemeData` per entry), this
// addon stores a `ThemeMode` and resolves the design system's `ThemeData` at
// build time, so the "System" option tracks the OS live via `MediaQuery`.
//
// The visitor's choice is remembered: `_PersistThemeMode` writes it to
// localStorage on every change, and it is restored on startup as both the
// addon's `initialTheme` and Widgetbook's own `themeMode` (which also themes the
// chrome and the home page). The default, before any explicit choice, is System.
//
// The landing screen is [DesignSystemHome] (`home.dart`): a short intro to
// Design Leaders Finland Oy and the design system's tech. The home widget does
// not inherit the addon theme, so it brands itself with the design system theme.

/// Labels shown in the toolbar "Theme" selector, keyed by [ThemeMode]. The label
/// is also what Widgetbook serializes into the URL for the addon's query group.
const Map<ThemeMode, String> _themeLabels = {
  ThemeMode.system: 'System',
  ThemeMode.light: 'Light',
  ThemeMode.dark: 'Dark',
};

void main() {
  // Restore the last mode the visitor chose; default to following the OS.
  final initialMode = _modeFromStore(loadThemeMode());

  // Built once and referenced by identity: `ThemeAddon` asserts that
  // `initialTheme` is contained in `themes`, so we pick the actual instance.
  final themes = <WidgetbookTheme<ThemeMode>>[
    for (final entry in _themeLabels.entries)
      WidgetbookTheme<ThemeMode>(name: entry.value, data: entry.key),
  ];
  final initialTheme = themes.firstWhere((theme) => theme.data == initialMode);

  runApp(
    Widgetbook.material(
      directories: materialDirectories,
      home: const DesignSystemHome(),
      // Brand "topbar" at the top of the navigation panel (upper-left); tapping
      // it returns to the home page.
      header: const GalleryHeader(),
      headerPadding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      // Themes the Widgetbook chrome (and therefore the home page) with the
      // restored mode; in System mode it keeps tracking the OS live.
      themeMode: initialMode,
      addons: [
        ThemeAddon<ThemeMode>(
          themes: themes,
          initialTheme: initialTheme,
          themeBuilder: (context, mode, child) {
            final data = _resolveThemeData(context, mode);
            return Theme(
              data: data,
              child: ColoredBox(
                color: data.scaffoldBackgroundColor,
                child: DefaultTextStyle(
                  style: data.textTheme.bodyMedium!,
                  child: child,
                ),
              ),
            );
          },
        ),
        AlignmentAddon(),
        GridAddon(8),
        TextScaleAddon(),
        ZoomAddon(),
        InspectorAddon(),
      ],
      integrations: [_PersistThemeMode()],
    ),
  );
}

/// Maps a persisted marker (`'system'`/`'light'`/`'dark'`, or `null`) to a
/// [ThemeMode], defaulting to [ThemeMode.system].
ThemeMode _modeFromStore(String? stored) => switch (stored) {
  'light' => ThemeMode.light,
  'dark' => ThemeMode.dark,
  _ => ThemeMode.system,
};

/// Resolves the design system [ThemeData] for [mode], following the platform
/// brightness when [mode] is [ThemeMode.system].
ThemeData _resolveThemeData(BuildContext context, ThemeMode mode) {
  final brightness = switch (mode) {
    ThemeMode.system =>
      MediaQuery.maybeOf(context)?.platformBrightness ?? Brightness.light,
    ThemeMode.light => Brightness.light,
    ThemeMode.dark => Brightness.dark,
  };
  return brightness == Brightness.dark
      ? AppTheme.darkTheme
      : AppTheme.lightTheme;
}

/// Persists the toolbar "Theme" selection to localStorage whenever it changes,
/// so the visitor's choice survives reloads and new sessions.
///
/// Widgetbook calls [onChange] on every state change; we only write when the
/// Theme addon's value differs from what we last stored, and we never store a
/// default the visitor did not explicitly pick.
class _PersistThemeMode extends WidgetbookIntegration {
  String? _lastSaved;

  @override
  void onChange(WidgetbookState state) {
    // The Theme addon group is `slugify('Theme')` == 'theme'; its single field
    // ('name') holds the selected theme's label.
    final label = FieldCodec.decodeQueryGroup(
      state.queryParams['theme'],
    )['name'];
    if (label == null || label == _lastSaved) return;

    final normalized = label.toLowerCase();
    final isKnownMode = ThemeMode.values.any((mode) => mode.name == normalized);
    if (!isKnownMode) return;

    _lastSaved = label;
    saveThemeMode(normalized);
  }
}
