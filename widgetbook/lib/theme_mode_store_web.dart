// Web implementation backed by `package:web` localStorage.
library;

import 'package:web/web.dart' as web;

// Distinct from the `onepage` app's key so the two galleries never interfere
// (the onepage store only knows 'light'/'dark', not 'system').
const _kThemeModeKey = 'widgetbook_theme_mode';

/// Loads the persisted theme mode from localStorage.
String? loadThemeModeImpl() => web.window.localStorage.getItem(_kThemeModeKey);

/// Persists the theme mode marker to localStorage.
void saveThemeModeImpl(String value) {
  web.window.localStorage.setItem(_kThemeModeKey, value);
}
