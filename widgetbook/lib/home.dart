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
                    title: 'What we do',
                    subtitle: 'A strategic design & product studio — four disciplines, one team.',
                  ),
                  SizedBox(height: Spacing.s5),
                  const _Services(),
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
                  SizedBox(height: Spacing.s12),
                  const _SectionHeading(
                    title: 'Tokens & components',
                    subtitle: 'A taste of the palette, type scale and buttons that ship with the system.',
                  ),
                  SizedBox(height: Spacing.s5),
                  const _ColorStrip(),
                  SizedBox(height: Spacing.s8),
                  const _TypeScale(),
                  SizedBox(height: Spacing.s8),
                  const _ButtonRow(),
                  SizedBox(height: Spacing.s12),
                  const _Footer(),
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
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _Services extends StatelessWidget {
  const _Services();

  static const _items = <(IconData, String, String)>[
    (
      Icons.explore,
      'Strategy',
      'Product strategy, research and roadmap planning for ambitious products.',
    ),
    (
      Icons.brush,
      'Design',
      'UI/UX, design systems, interaction design and visual identity.',
    ),
    (
      Icons.code,
      'Engineering',
      'Frontend architecture and design system implementation.',
    ),
    (
      Icons.groups,
      'Leadership',
      'Design team building, process design and design ops consulting.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Spacing.s4,
      runSpacing: Spacing.s4,
      children: [
        for (final (icon, title, body) in _items)
          _InfoCard(icon: icon, title: title, body: body),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      width: 240,
      child: Container(
        padding: EdgeInsets.all(Spacing.s5),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
          border: Border.all(color: colors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colors.secondary, size: Sizing.iconMd),
            SizedBox(height: Spacing.s3),
            Text(
              title,
              style: TextStyle(
                color: colors.text,
                fontWeight: AppFontWeight.semiBold,
                fontSize: FontSize.base,
              ),
            ),
            SizedBox(height: Spacing.s1),
            Text(
              body,
              style: TextStyle(
                color: colors.textAlternate,
                fontSize: FontSize.sm,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
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
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorStrip extends StatelessWidget {
  const _ColorStrip();

  static const _swatches = <(String, Color)>[
    ('primary', AppColors.primary),
    ('secondary', AppColors.secondary),
    ('accent', AppColors.accent),
    ('complementary', AppColors.complementary),
    ('attention', AppColors.attention),
    ('warning', AppColors.warning),
    ('danger', AppColors.danger),
    ('success', AppColors.success),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Spacing.s3,
      runSpacing: Spacing.s3,
      children: [
        for (final (name, color) in _swatches)
          _Swatch(label: name, color: color),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      width: 96,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppBorderRadius.sm),
              border: Border.all(color: colors.border),
            ),
          ),
          SizedBox(height: Spacing.s1),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colors.textAlternate,
              fontSize: FontSize.xs,
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeScale extends StatelessWidget {
  const _TypeScale();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Spacing.s6),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        border: Border.all(color: colors.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.display('Display'),
          AppText.heading('Heading'),
          AppText.title('Title'),
          AppText.body('Body — the quick brown fox jumps over the lazy dog.'),
          AppText.label('Label'),
        ],
      ),
    );
  }
}

class _ButtonRow extends StatelessWidget {
  const _ButtonRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Spacing.s3,
      runSpacing: Spacing.s3,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SolidButton(onPressed: () {}, child: const Text('Solid')),
        AppOutlinedButton(onPressed: () {}, child: const Text('Outlined')),
        GhostButton(onPressed: () {}, child: const Text('Ghost')),
        SolidButton(
          colorScheme: ButtonColorSheme.secondary,
          onPressed: () {},
          child: const Text('Secondary'),
        ),
        SolidButton(
          isLoading: true,
          onPressed: null,
          child: const Text('Loading'),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: Spacing.s8, thickness: 1, color: colors.border),
        Text(
          'Let’s build something meaningful.',
          style: TextStyle(
            color: colors.text,
            fontWeight: AppFontWeight.semiBold,
            fontSize: FontSize.lg,
          ),
        ),
        SizedBox(height: Spacing.s2),
        SelectableText(
          'designleaders.fi',
          style: TextStyle(
            color: colors.primary,
            fontWeight: AppFontWeight.semiBold,
            fontSize: FontSize.md,
            decoration: TextDecoration.underline,
            decorationColor: colors.primary,
          ),
        ),
        SizedBox(height: Spacing.s1),
        Text(
          'Design Leaders Finland Oy · Strategic Design & Product Studio',
          style: TextStyle(color: colors.textTertiary, fontSize: FontSize.xs),
        ),
      ],
    );
  }
}
