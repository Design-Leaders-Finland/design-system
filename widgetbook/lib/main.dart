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
// addon's `initialTheme` and `_WidgetbookAppState._themeMode` (which also
// themes the chrome and the home page). The default, before any explicit
// choice, is System. `_PersistThemeMode` also feeds every live addon change
// back into `_WidgetbookAppState` so the top-level `themeMode` — and with it
// the home page's `Theme.of(context).brightness` — stays in sync with the
// toolbar instead of only reflecting the mode from app startup.
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
  runApp(_WidgetbookApp(initialMode: initialMode));
}

/// Hosts the mutable top-level `themeMode` so it can follow the addon's
/// live selection instead of being fixed at the mode read on startup.
class _WidgetbookApp extends StatefulWidget {
  const _WidgetbookApp({required this.initialMode});

  final ThemeMode initialMode;

  @override
  State<_WidgetbookApp> createState() => _WidgetbookAppState();
}

class _WidgetbookAppState extends State<_WidgetbookApp> {
  late ThemeMode _themeMode = widget.initialMode;

  @override
  Widget build(BuildContext context) {
    // Built once and referenced by identity: `ThemeAddon` asserts that
    // `initialTheme` is contained in `themes`, so we pick the actual instance.
    final themes = <WidgetbookTheme<ThemeMode>>[
      for (final entry in _themeLabels.entries)
        WidgetbookTheme<ThemeMode>(name: entry.value, data: entry.key),
    ];
    final initialTheme = themes.firstWhere(
      (theme) => theme.data == widget.initialMode,
    );

    return Widgetbook.material(
      directories: materialDirectories,
      home: const DesignSystemHome(),
      // Brand "topbar" at the top of the navigation panel (upper-left); tapping
      // it returns to the home page.
      header: const GalleryHeader(),
      headerPadding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      // Themes the Widgetbook chrome (and therefore the home page); kept in
      // sync with the addon's live selection by `_PersistThemeMode` below.
      themeMode: _themeMode,
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
        GridAddon(8),
        TextScaleAddon(),
        ZoomAddon(),
        InspectorAddon(),
        // Must be innermost: addons wrap outside-in, and GridAddon's
        // background fills all available space, so Alignment needs to sit
        // right next to the use case to actually have room to move it.
        AlignmentAddon(),
      ],
      integrations: [
        _PersistThemeMode(
          onModeChanged: (mode) {
            if (mode != _themeMode) setState(() => _themeMode = mode);
          },
        ),
      ],
    );
  }
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
/// so the visitor's choice survives reloads and new sessions, and reports
/// every live selection back via [onModeChanged] so the top-level `themeMode`
/// (and the home page it themes) stays in sync with the toolbar.
///
/// Widgetbook calls [onChange] on every state change; we only persist when the
/// Theme addon's value differs from what we last stored, and we never store a
/// default the visitor did not explicitly pick.
class _PersistThemeMode extends WidgetbookIntegration {
  _PersistThemeMode({required this.onModeChanged});

  final ValueChanged<ThemeMode> onModeChanged;
  String? _lastSaved;

  @override
  void onChange(WidgetbookState state) {
    // The Theme addon group is `slugify('Theme')` == 'theme'; its single field
    // ('name') holds the selected theme's label.
    final label = FieldCodec.decodeQueryGroup(
      state.queryParams['theme'],
    )['name'];
    if (label == null) return;

    final normalized = label.toLowerCase();
    ThemeMode? mode;
    for (final candidate in ThemeMode.values) {
      if (candidate.name == normalized) {
        mode = candidate;
        break;
      }
    }
    if (mode == null) return;

    onModeChanged(mode);

    if (label == _lastSaved) return;
    _lastSaved = label;
    saveThemeMode(normalized);
  }
}
