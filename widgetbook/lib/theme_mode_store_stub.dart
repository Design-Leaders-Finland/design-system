// Stub implementation for non-web platforms (e.g. VM tests).
library;

/// Loads the persisted theme mode; no persistence on this platform.
String? loadThemeModeImpl() => null;

/// Persists the theme mode; no persistence on this platform.
void saveThemeModeImpl(String value) {}
