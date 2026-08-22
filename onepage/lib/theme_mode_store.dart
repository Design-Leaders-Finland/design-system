/// Persistence for the theme mode selection.
///
/// The web implementation uses `package:web` (localStorage), which is only
/// available on web platforms. The stub implementation is used everywhere
/// else (for example, in widget tests on the VM).
///
/// The implementation is selected at compile time via conditional imports.
library;

import 'theme_mode_store_stub.dart'
    if (dart.library.js_interop) 'theme_mode_store_web.dart';

/// Loads the persisted theme mode, or returns `null` if none is stored.
String? loadThemeMode() => loadThemeModeImpl();

/// Persists the given theme mode marker (`'dark'` or `'light'`).
void saveThemeMode(String value) => saveThemeModeImpl(value);
