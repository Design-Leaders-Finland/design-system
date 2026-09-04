// Web implementation backed by `package:web` localStorage.
library;

import 'package:web/web.dart' as web;

const _kThemeModeKey = 'widgetbook_theme_mode';

/// Loads the persisted theme mode from localStorage.
String? loadThemeModeImpl() => web.window.localStorage.getItem(_kThemeModeKey);

/// Persists the theme mode marker to localStorage.
void saveThemeModeImpl(String value) {
  web.window.localStorage.setItem(_kThemeModeKey, value);
}
