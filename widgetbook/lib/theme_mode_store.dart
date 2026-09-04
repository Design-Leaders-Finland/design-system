/// Persistence for the gallery's theme-mode selection.
///
/// The web implementation uses `package:web` (localStorage), which is only
/// available on web platforms. The stub implementation is used everywhere else
/// (for example, in widget tests on the VM).
library;

import 'theme_mode_store_stub.dart'
    if (dart.library.js_interop) 'theme_mode_store_web.dart';

/// Loads the persisted theme mode (`'system'`, `'light'` or `'dark'`), or
/// returns `null` when the visitor has never changed it.
String? loadThemeMode() => loadThemeModeImpl();

/// Persists the chosen theme mode marker (`'system'`, `'light'` or `'dark'`).
void saveThemeMode(String value) => saveThemeModeImpl(value);
