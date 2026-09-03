import 'package:design_leaders_system/design_leaders_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'common.dart';

// ── Design system ────────────────────────────────────────────────────────────
// The design system's own widgets and tokens, rendered with the same theme the
// Material catalog uses. Every widget property is exposed as a knob; binary
// props and two-option enums render as switches.

enum _AppTextVariant { display, heading, title, label, body, rich }

enum _ColorGroup { brand, semantic, neutral, dark }

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
    return Wrap(
      spacing: Spacing.s3,
      runSpacing: Spacing.s3,
      children: [
        for (final (name, color) in swatches)
          SizedBox(
            width: 104,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                    border: Border.all(color: Colors.black.withAlpha(20)),
                  ),
                ),
                const SizedBox(height: Spacing.s1),
                Text(name, style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ),
      ],
    );
  }),
]);
