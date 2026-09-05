import 'package:design_leaders_system/design_leaders_system.dart';
import 'package:flutter/material.dart';

// ── Widgetbook home ──────────────────────────────────────────────────────────
//
// The landing page Widgetbook shows before any use case is selected. The home
// widget does *not* inherit the gallery's `appBuilder`/addon theme, so it wraps
// its content in the design system's own [ThemeData] — picking light or dark
// from Widgetbook's current brightness — to stay on-brand and to make
// `context.colors` / [AppText] resolve with the design system tokens.

/// Landing page for the Design Leaders Finland design system gallery.
class DesignSystemHome extends StatelessWidget {
  const DesignSystemHome({super.key});

  @override
  Widget build(BuildContext context) {
    // `Theme.of` here reads Widgetbook's own light/dark theme (the home is not
    // covered by the addon theme), so we mirror its brightness with the design
    // system theme.
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Theme(
      data: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ColoredBox(
      color: colors.background,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.s8,
            vertical: Spacing.s10,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Hero(),
                  SizedBox(height: Spacing.s12),
                  const _SectionHeading(
                    title: 'The design system',
                    subtitle:
                        'This gallery documents design_leaders_system, our Flutter-first '
                        'design system. Every component is rendered with the system’s own '
                        'Material 3 theme — use the toolbar to switch light/dark, alignment, '
                        'zoom and more.',
                  ),
                  SizedBox(height: Spacing.s5),
                  const _TechSpec(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Sections ─────────────────────────────────────────────────────────────────

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: Sizing.iconLg,
              height: Sizing.iconLg,
              decoration: BoxDecoration(
                color: colors.secondary,
                borderRadius: BorderRadius.circular(AppBorderRadius.md),
              ),
              child: const Icon(
                Icons.design_services,
                color: AppColors.white,
                size: Sizing.iconMd,
              ),
            ),
            SizedBox(width: Spacing.s4),
            Flexible(
              child: Text(
                'Design Leaders Finland Oy',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: colors.text,
                  fontWeight: AppFontWeight.semiBold,
                  fontSize: FontSize.md,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Spacing.s6),
        Text(
          'Reduce design debt.\nShip faster.',
          style: TextStyle(
            color: colors.text,
            fontWeight: AppFontWeight.semiBold,
            decoration: TextDecoration.none,
            fontSize: FontSize.xl4,
            height: 1.08,
          ),
        ),
        SizedBox(height: Spacing.s4),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(
            'We help businesses of every size cut design and technical debt — and '
            'ship faster — through design leadership, strategy, design systems and '
            'design engineering.',
            style: TextStyle(
              color: colors.textAlternate,
              fontSize: FontSize.md,
              decoration: TextDecoration.none,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colors.text,
            fontWeight: AppFontWeight.semiBold,
            fontSize: FontSize.lg,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: Spacing.s1),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Text(
            subtitle,
            style: TextStyle(
              color: colors.textTertiary,
              fontSize: FontSize.sm,
              decoration: TextDecoration.none,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _TechSpec extends StatelessWidget {
  const _TechSpec();

  static const _rows = <(String, String)>[
    ('Framework', 'Flutter · Material 3 · Dart'),
    ('Runtime', 'Flutter 3.47 · Dart 3.13'),
    ('Gallery', 'Widgetbook v3 · web only · manual API (no codegen)'),
    (
      'Theming',
      'AppTheme light/dark · ThemeExtension (context.colors, context.textStyles)',
    ),
    (
      'Tokens',
      'Color · Typography · Spacing (4px grid) · Sizing · Radius · Shadow · Density',
    ),
    ('Typefaces', 'Figtree (display/UI) · Asap Condensed (body/label)'),
    (
      'Components',
      'AppText · SolidButton · AppOutlinedButton · GhostButton · Gap',
    ),
    ('Delivery', 'Netlify · oxfmt formatting'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.s5,
        vertical: Spacing.s2,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        children: [
          for (var i = 0; i < _rows.length; i++) ...[
            if (i > 0)
              Divider(height: Spacing.s4, thickness: 1, color: colors.border),
            _TechRow(label: _rows[i].$1, value: _rows[i].$2),
          ],
        ],
      ),
    );
  }
}

class _TechRow extends StatelessWidget {
  const _TechRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.s3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 116,
            child: Text(
              label,
              style: TextStyle(
                color: colors.textTertiary,
                fontWeight: AppFontWeight.semiBold,
                decoration: TextDecoration.none,
                fontSize: FontSize.sm,
              ),
            ),
          ),
          SizedBox(width: Spacing.s4),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: colors.text,
                fontSize: FontSize.sm,
                decoration: TextDecoration.none,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
