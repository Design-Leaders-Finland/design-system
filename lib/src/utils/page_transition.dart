import 'package:flutter/material.dart';

/// Shared page transition configuration for the design system.
///
/// All page transitions across the app should be configured from this single
/// place so that navigation feels consistent and can be changed in one spot.
final class AppPageTransition {
  AppPageTransition._();

  /// Duration used for page transitions.
  static const Duration duration = Duration(milliseconds: 300);

  /// Curve used for page transitions.
  static const Curve curve = Curves.easeInOut;

  /// Builds a [Page] that fades in and slides up slightly.
  ///
  /// Use this as the `pageBuilder` for routes so every page shares the same
  /// transition. The [child] is the page content to display. Provide a [key]
  /// (e.g. based on the route path) so go_router can manage the page stack.
  static Page<void> buildPage({required Widget child, LocalKey? key}) {
    return _AppTransitionPage(key: key, child: child);
  }
}

class _AppTransitionPage extends Page<void> {
  const _AppTransitionPage({super.key, required this.child});

  final Widget child;

  @override
  Route<void> createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      transitionDuration: AppPageTransition.duration,
      reverseTransitionDuration: AppPageTransition.duration,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: AppPageTransition.curve,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.02),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
