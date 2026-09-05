import 'package:design_leaders_system/design_leaders_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'dart:math' show pow;

import 'common.dart';

// ── Design system ────────────────────────────────────────────────────────────
// The design system's own widgets and tokens, rendered with the same theme the
// Material catalog uses. Every widget property is exposed as a knob; binary
// props and two-option enums render as switches.

enum _AppTextVariant { display, heading, title, label, body, rich }

enum _ColorGroup { brand, semantic, neutral, dark }

// ── Color accessibility info ─────────────────────────────────────────────────
// WCAG AAA contrast ratios (4.5:1 for normal text, 3:1 for large text)
typedef _ContrastInfo = ({
  String name,
  double ratio,
  bool passNormalText,
  bool passLargeText,
});

/// Calculate relative luminance for WCAG contrast ratio
double _getLuminance(Color color) {
  final rgb =
      [
        (color.r * 255.0).round().clamp(0, 255),
        (color.g * 255.0).round().clamp(0, 255),
        (color.b * 255.0).round().clamp(0, 255),
      ].map((c) {
        final value = c / 255.0;
        return value <= 0.03928
            ? value / 12.92
            : pow((value + 0.055) / 1.055, 2).toDouble();
      }).toList();
  return rgb[0] * 0.2126 + rgb[1] * 0.7152 + rgb[2] * 0.0722;
}

/// Calculate WCAG contrast ratio between two colors
double _getContrastRatio(Color color1, Color color2) {
  final l1 = _getLuminance(color1);
  final l2 = _getLuminance(color2);
  final lighter = [l1, l2].reduce((a, b) => a > b ? a : b);
  final darker = [l1, l2].reduce((a, b) => a < b ? a : b);
  return (lighter + 0.05) / (darker + 0.05);
}

/// Get contrast info for a color against light and dark backgrounds
List<_ContrastInfo> _getContrastInfo(Color foreground) {
  final contrastLight = _getContrastRatio(foreground, AppColors.white);
  final contrastDark = _getContrastRatio(foreground, AppColors.black);
  return [
    (
      name: 'Light Background (White)',
      ratio: contrastLight,
      passNormalText: contrastLight >= 4.5,
      passLargeText: contrastLight >= 3.0,
    ),
    (
      name: 'Dark Background (Black)',
      ratio: contrastDark,
      passNormalText: contrastDark >= 4.5,
      passLargeText: contrastDark >= 3.0,
    ),
  ];
}

/// Font weights offered by the [AppText] demo, keyed by a readable name.
const Map<String, FontWeight> _fontWeights = {
  'thin': FontWeight.w100,
  'light': FontWeight.w300,
  'regular': FontWeight.w400,
  'medium': FontWeight.w500,
  'semiBold': FontWeight.w600,
  'bold': FontWeight.w700,
  'black': FontWeight.w900,
};

/// The design system palette, grouped for the [Colors] demo.
const Map<_ColorGroup, List<(String, Color)>> _colorGroups = {
  _ColorGroup.brand: [
    ('primary', AppColors.primary),
    ('secondary', AppColors.secondary),
    ('complementary', AppColors.complementary),
    ('accent', AppColors.accent),
  ],
  _ColorGroup.semantic: [
    ('attention', AppColors.attention),
    ('warning', AppColors.warning),
    ('danger', AppColors.danger),
    ('success', AppColors.success),
  ],
  _ColorGroup.neutral: [
    ('white', AppColors.white),
    ('black', AppColors.black),
    ('border', AppColors.border),
    ('background', AppColors.background),
    ('textDefault', AppColors.textDefault),
  ],
  _ColorGroup.dark: [
    ('darkBackground', AppColors.darkBackground),
    ('darkPrimary', AppColors.darkPrimary),
    ('darkSurface', AppColors.darkSurface),
    ('darkText', AppColors.darkText),
    ('darkBorder', AppColors.darkBorder),
  ],
};

/// The [BaseButton] properties shared by every design system button. All knobs
/// are registered up front (stable order); the returned values simply feed
/// whichever concrete button the use case builds.
class _ButtonKnobs {
  const _ButtonKnobs({
    required this.label,
    required this.enabled,
    required this.isLoading,
    required this.leftIcon,
    required this.rightIcon,
    required this.style,
  });

  final String label;
  final bool enabled;
  final bool isLoading;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final ButtonStyle? style;
}

_ButtonKnobs _dsButtonKnobs(BuildContext context) {
  final k = context.knobs;
  final label = k.string(label: 'Label', initialValue: 'Button');
  final enabled = k.boolean(label: 'Enabled', initialValue: true);
  final isLoading = k.boolean(label: 'Loading', initialValue: false);
  final hasLeftIcon = k.boolean(label: 'Left icon', initialValue: false);
  final leftIconData = iconKnob(
    context,
    label: 'Left icon data',
    initial: Icons.check,
  );
  final hasRightIcon = k.boolean(label: 'Right icon', initialValue: false);
  final rightIconData = iconKnob(
    context,
    label: 'Right icon data',
    initial: Icons.arrow_forward,
  );
  final iconSize = k.double.slider(
    label: 'Icon size',
    initialValue: Sizing.iconSm,
    min: 12,
    max: 32,
    divisions: 20,
  );
  // `style` is null by default so the button's own color scheme drives it; the
  // override only kicks in when explicitly enabled.
  final overrideStyle = k.boolean(label: 'Override style', initialValue: false);
  final background = k.colorOrNull(
    label: 'Style background',
    defaultToNull: true,
  );
  final foreground = k.colorOrNull(
    label: 'Style foreground',
    defaultToNull: true,
  );
  final radius = k.double.slider(
    label: 'Style corner radius',
    initialValue: AppBorderRadius.lg,
    min: 0,
    max: 32,
    divisions: 32,
  );
  return _ButtonKnobs(
    label: label,
    enabled: enabled,
    isLoading: isLoading,
    leftIcon: hasLeftIcon ? Icon(leftIconData, size: iconSize) : null,
    rightIcon: hasRightIcon ? Icon(rightIconData, size: iconSize) : null,
    style: overrideStyle
        ? ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(background),
            foregroundColor: WidgetStatePropertyAll(foreground),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          )
        : null,
  );
}

/// The design system's own widgets and tokens.
WidgetbookCategory get designSystemCategory => category('Design System', [
  component('AppText', (context) {
    final k = context.knobs;
    final variant = optionKnob<_AppTextVariant>(
      context,
      label: 'Variant',
      options: _AppTextVariant.values,
      initial: _AppTextVariant.body,
    );
    final text = k.string(
      label: 'Text',
      initialValue: 'Design Leaders Finland',
    );
    final color = k.colorOrNull(label: 'Color', defaultToNull: true);
    final textAlign = k.objectOrNull.dropdown<TextAlign>(
      label: 'Text align',
      options: TextAlign.values,
      initialOption: TextAlign.start,
      defaultToNull: true,
    );
    final overflow = optionKnob<TextOverflow>(
      context,
      label: 'Overflow',
      options: TextOverflow.values,
      initial: TextOverflow.ellipsis,
    );
    final maxLines = k.intOrNull.input(
      label: 'Max lines (null = none)',
      defaultToNull: true,
    );
    final fontSize = k.doubleOrNull.slider(
      label: 'Font size (null = token)',
      initialValue: 24,
      min: 8,
      max: 64,
      defaultToNull: true,
    );
    final fontWeight = k.objectOrNull.dropdown<FontWeight>(
      label: 'Font weight (null = token)',
      options: _fontWeights.values.toList(),
      initialOption: FontWeight.w400,
      defaultToNull: true,
      labelBuilder: (weight) =>
          _fontWeights.entries.firstWhere((e) => e.value == weight).key,
    );
    final width = k.double.slider(
      label: 'Box width',
      initialValue: 280,
      min: 120,
      max: 400,
      divisions: 56,
    );
    final Widget textWidget = switch (variant) {
      _AppTextVariant.display => AppText.display(
        text,
        maxLines: maxLines,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        textAlign: textAlign,
        overflow: overflow,
      ),
      _AppTextVariant.heading => AppText.heading(
        text,
        maxLines: maxLines,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        textAlign: textAlign,
        overflow: overflow,
      ),
      _AppTextVariant.title => AppText.title(
        text,
        maxLines: maxLines,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? AppColors.primary,
        textAlign: textAlign,
        overflow: overflow,
      ),
      _AppTextVariant.label => AppText.label(
        text,
        maxLines: maxLines,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        textAlign: textAlign,
        overflow: overflow,
      ),
      _AppTextVariant.body => AppText.body(
        text,
        maxLines: maxLines,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        textAlign: textAlign,
        overflow: overflow,
      ),
      _AppTextVariant.rich => AppText.rich(
        text,
        maxLines: maxLines,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? AppColors.hyperlink,
        textAlign: textAlign,
        overflow: overflow,
      ),
    };
    return SizedBox(width: width, child: textWidget);
  }),
  component('SolidButton', (context) {
    final colorScheme = optionKnob<ButtonColorSheme>(
      context,
      label: 'Color scheme',
      options: ButtonColorSheme.values,
      initial: ButtonColorSheme.primary,
    );
    final b = _dsButtonKnobs(context);
    return SolidButton(
      onPressed: b.enabled
          ? () => showDemoSnack(context, 'SolidButton pressed')
          : null,
      isLoading: b.isLoading,
      colorScheme: colorScheme,
      leftIcon: b.leftIcon,
      rightIcon: b.rightIcon,
      style: b.style,
      child: Text(b.label),
    );
  }),
  component('AppOutlinedButton', (context) {
    final b = _dsButtonKnobs(context);
    return AppOutlinedButton(
      onPressed: b.enabled
          ? () => showDemoSnack(context, 'AppOutlinedButton pressed')
          : null,
      isLoading: b.isLoading,
      leftIcon: b.leftIcon,
      rightIcon: b.rightIcon,
      style: b.style,
      child: Text(b.label),
    );
  }),
  component('GhostButton', (context) {
    final b = _dsButtonKnobs(context);
    return GhostButton(
      onPressed: b.enabled
          ? () => showDemoSnack(context, 'GhostButton pressed')
          : null,
      isLoading: b.isLoading,
      leftIcon: b.leftIcon,
      rightIcon: b.rightIcon,
      style: b.style,
      child: Text(b.label),
    );
  }),
  component('Spacing', (context) {
    final k = context.knobs;
    final showValues = k.boolean(
      label: 'Show pixel values',
      initialValue: true,
    );
    const tokens = <(String, double)>[
      ('s2', Spacing.s2),
      ('s4', Spacing.s4),
      ('s6', Spacing.s6),
      ('s8', Spacing.s8),
      ('s12', Spacing.s12),
      ('s16', Spacing.s16),
    ];
    final color = Theme.of(context).colorScheme.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (label, value) in tokens)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Spacing.s1),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 40, child: Text(label)),
                Container(
                  height: Spacing.s3,
                  width: value,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(AppBorderRadius.xs),
                  ),
                ),
                if (showValues) ...[
                  const SizedBox(width: Spacing.s2),
                  Text('${value.toInt()}px'),
                ],
              ],
            ),
          ),
      ],
    );
  }),
  component('Sizing', (context) {
    final k = context.knobs;
    final showLabels = k.boolean(label: 'Show labels', initialValue: true);
    const tokens = <(String, double)>[
      ('iconSm', Sizing.iconSm),
      ('iconMd', Sizing.iconMd),
      ('iconLg', Sizing.iconLg),
      ('iconXl', Sizing.iconXl),
    ];
    final color = Theme.of(context).colorScheme.secondary;
    return Wrap(
      spacing: Spacing.s4,
      runSpacing: Spacing.s4,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        for (final (label, value) in tokens)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: value,
                height: value,
                decoration: BoxDecoration(
                  color: color.withAlpha(60),
                  borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                  border: Border.all(color: color),
                ),
              ),
              if (showLabels) ...[
                const SizedBox(height: Spacing.s1),
                Text(label),
              ],
            ],
          ),
      ],
    );
  }),
  component('Colors', (context) {
    final group = optionKnob<_ColorGroup>(
      context,
      label: 'Palette',
      options: _ColorGroup.values,
      initial: _ColorGroup.brand,
    );
    final swatches = _colorGroups[group]!;

    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryTextColor = isDark
        ? colorScheme.onSurfaceVariant
        : Colors.grey[600]!;
    final mutedTextColor = isDark
        ? colorScheme.onSurfaceVariant
        : Colors.grey[700]!;
    final legendBgColor = isDark
        ? colorScheme.surface
        : Color.fromARGB(255, 245, 245, 245);
    final borderColor = isDark
        ? colorScheme.outline
        : Colors.black.withAlpha(20);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Color swatches with usage and accessibility info
          Wrap(
            spacing: Spacing.s4,
            runSpacing: Spacing.s4,
            children: [
              for (final (name, color) in swatches)
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 280),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Color swatch
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(
                            AppBorderRadius.sm,
                          ),
                          border: Border.all(color: borderColor),
                        ),
                      ),
                      const SizedBox(height: Spacing.s2),

                      // Color name
                      Text(
                        name,
                        style: Theme.of(context).textTheme.labelLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: Spacing.s1),

                      // Color value (hex)
                      Text(
                        '#${color.toARGB32().toRadixString(16).toUpperCase().padLeft(8, '0').substring(2)}',
                        style: Theme.of(context).textTheme.labelSmall
                            ?.copyWith(color: secondaryTextColor),
                      ),
                      const SizedBox(height: Spacing.s2),

                      // Usage info
                      if (group == _ColorGroup.brand)
                        Text(
                          'Use for: ',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: mutedTextColor,
                              ),
                        ),
                      if (group == _ColorGroup.brand && name == 'primary')
                        Text(
                          'Primary actions, main CTAs, active states',
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      else if (group == _ColorGroup.brand &&
                          name == 'secondary')
                        Text(
                          'Secondary actions, alternate CTAs',
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      else if (group == _ColorGroup.brand && name == 'accent')
                        Text(
                          'Highlights, success states, accent elements',
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      else if (group == _ColorGroup.brand &&
                          name == 'complementary')
                        Text(
                          'Complementary accents, borders',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),

                      if (group == _ColorGroup.semantic)
                        Text(
                          'Use for: ',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: mutedTextColor,
                              ),
                        ),
                      if (group == _ColorGroup.semantic && name == 'attention')
                        Text(
                          'Information alerts, notices',
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      else if (group == _ColorGroup.semantic &&
                          name == 'warning')
                        Text(
                          'Warning alerts, caution messages',
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      else if (group == _ColorGroup.semantic &&
                          name == 'danger')
                        Text(
                          'Error states, destructive actions',
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      else if (group == _ColorGroup.semantic &&
                          name == 'success')
                        Text(
                          'Success messages, confirmations',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),

                      const SizedBox(height: Spacing.s2),

                      // WCAG AAA accessibility info
                      Text(
                        'WCAG AAA Contrast',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: mutedTextColor,
                        ),
                      ),
                      const SizedBox(height: Spacing.s1),
                      ..._getContrastInfo(color).map(
                        (info) => Padding(
                          padding: const EdgeInsets.only(bottom: Spacing.s1),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      info.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    Text(
                                      'Ratio: ${info.ratio.toStringAsFixed(2)}:1',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: secondaryTextColor,
                                            fontSize: 10,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Chip(
                                    label: Text(
                                      info.passNormalText
                                          ? '✓ Normal'
                                          : '✗ Normal',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: info.passNormalText
                                        ? Colors.green
                                        : Colors.red,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Spacing.s1,
                                      vertical: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Chip(
                                    label: Text(
                                      info.passLargeText
                                          ? '✓ Large'
                                          : '✗ Large',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: info.passLargeText
                                        ? Colors.green
                                        : Colors.orange,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Spacing.s1,
                                      vertical: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: Spacing.s6),

          // Accessibility legend
          Container(
            padding: const EdgeInsets.all(Spacing.s3),
            decoration: BoxDecoration(
              color: legendBgColor,
              borderRadius: BorderRadius.circular(AppBorderRadius.sm),
              border: Border.all(color: borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WCAG AAA Accessibility Guidelines',
                  style: Theme.of(context).textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: Spacing.s2),
                Text(
                  '• ✓ Normal: Contrast ratio ≥ 4.5:1 (AA for regular text)',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: Spacing.s1),
                Text(
                  '• ✓ Large: Contrast ratio ≥ 3.0:1 (AA for large text, 18pt+)',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: Spacing.s1),
                Text(
                  '• AAA requires 7:1 for normal text & 4.5:1 for large text',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }),
  component('Typography', (context) {
    final k = context.knobs;
    final showSizes = k.boolean(label: 'Show px sizes', initialValue: true);
    final useColors = k.boolean(label: 'Use theme colors', initialValue: true);

    final textColor = useColors
        ? Theme.of(context).colorScheme.onSurface
        : (Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black);

    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final containerBgColor = isDark
        ? colorScheme.surface
        : colorScheme.surfaceContainerLowest;
    final borderColor = isDark ? colorScheme.outline : Colors.grey[300]!;
    final hintColor = isDark ? colorScheme.onSurfaceVariant : Colors.grey[600]!;
    final mutedColor = isDark
        ? colorScheme.onSurfaceVariant
        : Colors.grey[700]!;

    const typographyItems =
        <({String label, String category, TextStyle style, String usage})>[
          // Display styles
          (
            label: 'Display Large',
            category: 'Display',
            style: AppTypography.displayLg,
            usage: 'Hero/splash screen headlines',
          ),
          (
            label: 'Display Medium',
            category: 'Display',
            style: AppTypography.displayMd,
            usage: 'Page main headings',
          ),
          (
            label: 'Display Small',
            category: 'Display',
            style: AppTypography.displaySm,
            usage: 'Section headlines',
          ),

          // Heading styles
          (
            label: 'Heading Large',
            category: 'Heading',
            style: AppTypography.headlineLg,
            usage: 'Subsection titles',
          ),
          (
            label: 'Heading Medium',
            category: 'Heading',
            style: AppTypography.headlineMd,
            usage: 'Card titles, modal headers',
          ),
          (
            label: 'Heading Small',
            category: 'Heading',
            style: AppTypography.headlineSm,
            usage: 'List item headers',
          ),

          // Title styles
          (
            label: 'Title Large',
            category: 'Title',
            style: AppTypography.titleLg,
            usage: 'Dialog titles, form sections',
          ),
          (
            label: 'Title Medium',
            category: 'Title',
            style: AppTypography.titleMd,
            usage: 'Form labels, emphasized text',
          ),
          (
            label: 'Title Small',
            category: 'Title',
            style: AppTypography.titleSm,
            usage: 'Component labels, metadata',
          ),

          // Body styles
          (
            label: 'Body Large',
            category: 'Body',
            style: AppTypography.bodyLg,
            usage: 'Main body text, descriptions',
          ),
          (
            label: 'Body Medium',
            category: 'Body',
            style: AppTypography.bodyMd,
            usage: 'Secondary text, helper text',
          ),
          (
            label: 'Body Small',
            category: 'Body',
            style: AppTypography.bodySm,
            usage: 'Captions, small text',
          ),

          // Label styles
          (
            label: 'Label Large',
            category: 'Label',
            style: AppTypography.labelLg,
            usage: 'Button text, tags',
          ),
          (
            label: 'Label Medium',
            category: 'Label',
            style: AppTypography.labelMd,
            usage: 'Small labels, badges',
          ),
          (
            label: 'Label Small',
            category: 'Label',
            style: AppTypography.labelSm,
            usage: 'Smallest labels, hints',
          ),
        ];

    final groupedByCategory =
        <
          String,
          List<({String label, String category, TextStyle style, String usage})>
        >{};

    for (final item in typographyItems) {
      (groupedByCategory[item.category] ??= []).add(item);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final category in groupedByCategory.keys)
            Padding(
              padding: const EdgeInsets.only(bottom: Spacing.s6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: Spacing.s3),
                  for (final item in groupedByCategory[category]!)
                    Padding(
                      padding: const EdgeInsets.only(bottom: Spacing.s4),
                      child: Container(
                        padding: const EdgeInsets.all(Spacing.s3),
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(
                            AppBorderRadius.sm,
                          ),
                          color: containerBgColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Label and metadata
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.label,
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                if (showSizes)
                                  Text(
                                    '${(item.style.fontSize ?? 16).toStringAsFixed(1)}px',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(color: hintColor),
                                  ),
                              ],
                            ),
                            const SizedBox(height: Spacing.s2),

                            // Usage description
                            Text(
                              'Usage: ${item.usage}',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: mutedColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                            const SizedBox(height: Spacing.s2),

                            // Divider
                            Container(height: 1, color: borderColor),
                            const SizedBox(height: Spacing.s2),

                            // Example text
                            Text(
                              'The quick brown fox jumps over the lazy dog',
                              style: item.style.copyWith(color: textColor),
                            ),
                            const SizedBox(height: Spacing.s2),

                            // Typography details
                            Wrap(
                              spacing: Spacing.s3,
                              runSpacing: Spacing.s1,
                              children: [
                                Text(
                                  'Weight: ${item.style.fontWeight?.toString().split('.').last ?? 'regular'}',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(color: hintColor),
                                ),
                                Text(
                                  'Height: ${item.style.height?.toStringAsFixed(2) ?? '1.0'}',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(color: hintColor),
                                ),
                                if (item.style.letterSpacing != null)
                                  Text(
                                    'Letter spacing: ${item.style.letterSpacing?.toStringAsFixed(2)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(color: hintColor),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }),
]);
