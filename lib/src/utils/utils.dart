import '../tokens/spacing/spacing.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

/// Platform tokens to allow for platform-specific adjustments in spacing, sizing, and other design aspects.
enum AppPlatform { android, ios, macOS, windows, linux, web }

class BreakPoints {
  static const double sm = 400;
  static const double md = 900;
}

SpacingDensity getAutoDensity(BuildContext context) {
  final screenWidth = MediaQuery.sizeOf(context).width;
  if (screenWidth < BreakPoints.sm) {
    return SpacingDensity.compact;
  }
  if (screenWidth < BreakPoints.md) {
    return SpacingDensity.comfortable;
  }
  return SpacingDensity.loose;
}

class PlatformHelper {
  static bool get isMobile =>
      currentPlatform == AppPlatform.android ||
      currentPlatform == AppPlatform.ios;
  static bool get isWeb => currentPlatform == AppPlatform.web;
  static bool get isDesktop =>
      currentPlatform == AppPlatform.windows ||
      currentPlatform == AppPlatform.macOS ||
      currentPlatform == AppPlatform.linux;

  static AppPlatform get currentPlatform {
    if (kIsWeb) return AppPlatform.web;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AppPlatform.android;
      case TargetPlatform.iOS:
        return AppPlatform.ios;
      case TargetPlatform.macOS:
        return AppPlatform.macOS;
      case TargetPlatform.windows:
        return AppPlatform.windows;
      case TargetPlatform.linux:
        return AppPlatform.linux;
      default:
        return AppPlatform.web;
    }
  }

  static T select<T>(
    T fallback, {
    T? web,
    T? android,
    T? ios,
    T? macOS,
    T? windows,
    T? linux,
  }) => switch (currentPlatform) {
    AppPlatform.web => web ?? fallback,
    AppPlatform.android => android ?? fallback,
    AppPlatform.ios => ios ?? fallback,
    AppPlatform.macOS => macOS ?? fallback,
    AppPlatform.windows => windows ?? fallback,
    AppPlatform.linux => linux ?? fallback,
  };
}
