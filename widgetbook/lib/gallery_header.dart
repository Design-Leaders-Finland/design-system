import 'package:design_leaders_system/design_leaders_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

/// Brand "topbar" shown at the top of Widgetbook's navigation panel
/// (upper-left corner).
///
/// It doubles as a home button: tapping it clears the selected use case so the
/// workbench falls back to the gallery's home page. The header lives in
/// Widgetbook's *chrome* theme (not the design-system addon theme), so it reads
/// text colors from `Theme.of(context)` and uses the brand color for the mark.
class GalleryHeader extends StatelessWidget {
  const GalleryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final radius = BorderRadius.circular(AppBorderRadius.sm);
    return Tooltip(
      message: 'Design Leaders Finland Oy — back to home',
      // Transparent Material so the InkWell ripple works regardless of where the
      // header is mounted (Widgetbook's nav panel provides no Material itself).
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: radius,
          onTap: () => _navigateHome(context),
          child: Padding(
            padding: EdgeInsets.all(Spacing.s1),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Tiny brand mark.
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: radius,
                  ),
                  child: const Icon(
                    Icons.design_services,
                    size: 18,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: Spacing.s3),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Design Leaders',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: onSurface,
                          fontWeight: AppFontWeight.semiBold,
                          fontSize: FontSize.sm,
                          height: 1.15,
                        ),
                      ),
                      Text(
                        'Design System',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: onSurface.withValues(alpha: 0.6),
                          fontSize: FontSize.xs,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Navigates back to the gallery home page.
///
/// Widgetbook exposes no public "go home" API, so this uses the same `updatePath`
/// the navigation tree uses to select a node. A path that matches no use case
/// makes the workbench render the home widget; `updatePath` also clears the
/// previous use case's knobs while leaving the other addons (theme, zoom, …)
/// untouched.
void _navigateHome(BuildContext context) {
  final state = WidgetbookState.of(context);
  // ignore: invalid_use_of_internal_member
  state.updatePath('/');
}
