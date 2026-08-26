import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:design_leaders_system/design_leaders_system.dart';

/// Responsive page header.
///
/// The header is split into small, individually testable widgets:
/// [AppBrand] (main text), the nav items, [ThemeSelector], and [Slogan].
/// The layout adapts without any hard-coded width breakpoints: the brand and
/// the nav items live in a [Wrap] so they flow and wrap automatically, the
/// theme selector is pinned to the right of the row, and the slogan always
/// sits below.
class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.onThemeChanged});

  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(color: colors.surface, boxShadow: AppShadow.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.s6,
          vertical: Spacing.s8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: Spacing.s4,
                    runSpacing: Spacing.s4,
                    children: [
                      const AppBrand(label: 'Design Leaders System'),
                      ...appNavItems(),
                    ],
                  ),
                ),
                const SizedBox(width: Spacing.s4),
                ThemeSelector(isDark: isDark, onChanged: onThemeChanged),
              ],
            ),
            const SizedBox(height: Spacing.s4),
            const Slogan(),
          ],
        ),
      ),
    );
  }
}

/// The main text / brand of the header. Tapping it goes to the home page.
class AppBrand extends StatelessWidget {
  const AppBrand({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      label: '$label - Go to home page',
      button: true,
      child: InkWell(
        onTap: () => context.go('/'),
        child: AppText.display(
          label,
          style: AppTypography.displayLg,
          color: colors.textTertiary,
        ),
      ),
    );
  }
}

/// The individual navigation items shown next to the brand.
///
/// A small helper function is exposed so the set of links can be assembled
/// (and tested) independently of where they are placed.
List<Widget> appNavItems() => const [
  AppNavItem(label: 'Overview', route: '/'),
  AppNavItem(label: 'Widgets', route: '/widgets'),
  AppNavItem(label: 'About', route: '/about'),
];

/// A single navigation link. Highlights itself when its [route] matches the
/// current location.
class AppNavItem extends StatelessWidget {
  const AppNavItem({super.key, required this.label, required this.route});

  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final location = GoRouterState.of(context).uri.toString();
    final current = location.isEmpty ? '/' : location;
    final isActive = current == route;

    return Semantics(
      label: '$label - Go to $label page',
      button: true,
      child: InkWell(
        onTap: () => context.go(route),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.s3,
            vertical: Spacing.s1_5,
          ),
          decoration: BoxDecoration(
            color: isActive ? colors.primary.withAlpha(30) : Colors.transparent,
            borderRadius: BorderRadius.circular(AppBorderRadius.sm),
          ),
          child: AppText.label(
            label,
            color: isActive ? colors.primary : colors.textTertiary,
          ),
        ),
      ),
    );
  }
}

/// The light/dark theme selector, pinned to the right edge of the header.
class ThemeSelector extends StatelessWidget {
  const ThemeSelector({
    super.key,
    required this.isDark,
    required this.onChanged,
  });

  final bool isDark;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Toggle dark mode',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.light_mode, size: 18),
          Switch(
            value: isDark,
            onChanged: onChanged,
            activeThumbColor: AppColors.white,
            activeTrackColor: AppColors.white.withAlpha(80),
            inactiveThumbColor: AppColors.secondary,
            inactiveTrackColor: AppColors.secondary.withAlpha(80),
          ),
          const Icon(Icons.dark_mode, size: 18),
        ],
      ),
    );
  }
}

/// The slogan line that is always rendered below the primary header row.
class Slogan extends StatelessWidget {
  const Slogan({super.key});

  @override
  Widget build(BuildContext context) {
    return AppText.body(
      'A lightweight Flutter web landing page built with shared design tokens, '
      'responsive spacing, and reusable components.',
    );
  }
}
