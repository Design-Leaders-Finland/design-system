import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:design_leaders_system/design_leaders_system.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.isNarrow,
    required this.onThemeChanged,
  });

  final bool isNarrow;
  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final location = GoRouterState.of(context).uri.toString();
    final isHome = location == '/' || location.isEmpty;
    final isWidgets = location == '/widgets';
    final isAbout = location == '/about';

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.s6,
        vertical: isNarrow ? Spacing.s8 : Spacing.s10,
      ),
      decoration: BoxDecoration(color: colors.surface, boxShadow: AppShadow.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Semantics(
                        label: 'Design System Overview - Go to home page',
                        button: true,
                        child: InkWell(
                          onTap: () => context.go('/'),
                          child: AppText.display(
                            'Design System Overview',
                            style: AppTypography.displayLg,
                            color: colors.textTertiary,
                          ),
                        ),
                      ),
                      const SizedBox(width: Spacing.s8),
                      _NavLink(
                        label: 'Overview',
                        isActive: isHome,
                        onTap: () => context.go('/'),
                      ),
                      const SizedBox(width: Spacing.s4),
                      _NavLink(
                        label: 'Widgets',
                        isActive: isWidgets,
                        onTap: () => context.go('/widgets'),
                      ),
                      const SizedBox(width: Spacing.s4),
                      _NavLink(
                        label: 'About',
                        isActive: isAbout,
                        onTap: () => context.go('/about'),
                      ),
                    ],
                  ),
                ),
              ),
              _ThemeSwitcher(isDark: isDark, onChanged: onThemeChanged),
            ],
          ),
          if (!isNarrow) ...[
            const SizedBox(height: Spacing.s4),
            AppText.body(
              'A lightweight Flutter web landing page built with shared design tokens, responsive spacing, and reusable components.',
            ),
          ],
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      label: '$label - Go to $label page',
      button: true,
      child: InkWell(
        onTap: onTap,
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

class _ThemeSwitcher extends StatelessWidget {
  const _ThemeSwitcher({required this.isDark, required this.onChanged});

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
