import 'package:flutter/material.dart';
import '../../tokens/spacing/spacing.dart';

enum ButtonColorSheme { primary, secondary }

abstract class BaseButton extends StatelessWidget {
  final Widget? rightIcon;
  final Widget? leftIcon;
  final VoidCallback? onPressed;
  final AppBorderRadius? borderRadius;
  final ButtonStyle? style;
  final Widget child;
  final bool isLoading;
  final ButtonColorSheme colorScheme;

  const BaseButton({
    super.key,
    this.onPressed,
    this.leftIcon,
    this.rightIcon,
    required this.child,
    this.borderRadius,
    this.style,
    this.isLoading = false,
    this.colorScheme = ButtonColorSheme.primary,
  });

  Map<String, Color> _resolveBtnStyle(ThemeData theme) {
    final cs = theme.colorScheme;

    final Map<String, Color> btnStyles = switch (colorScheme) {
      ButtonColorSheme.primary => {
        "backgroundColor": cs.primary,
        "foregroundColor": cs.onPrimary,
      },
      ButtonColorSheme.secondary => {
        "backgroundColor": cs.secondary,
        "foregroundColor": cs.onSecondary,
      },
    };

    return btnStyles;
  }

  Widget buildButton({
    required BuildContext context,
    ButtonStyle? style,
    required Widget content,
    required ThemeData theme,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final hasLeftAddOn = leftIcon != null || isLoading;

    const loadingIndicator = SizedBox(
      width: Spacing.s3,
      height: Spacing.s3,
      child: CircularProgressIndicator(strokeWidth: Spacing.s1_5),
    );

    final Widget? leftAddOn = isLoading ? loadingIndicator : leftIcon;

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasLeftAddOn) ...[leftAddOn!, const SizedBox(width: Spacing.s3_5)],
        child,
        if (rightIcon != null) ...[
          const SizedBox(width: Spacing.s3_5),
          rightIcon!,
        ],
      ],
    );

    return buildButton(
      context: context,
      style: style,
      content: content,
      theme: theme,
    );
  }
}

class SolidButton extends BaseButton {
  const SolidButton({
    super.key,
    super.onPressed,
    super.leftIcon,
    super.rightIcon,
    required super.child,
    super.borderRadius,
    super.style,
    super.isLoading = false,
    super.colorScheme,
  });

  ButtonStyle resolveStyle(ThemeData theme, ButtonStyle? btnStyle) {
    final styles = super._resolveBtnStyle(theme);
    return ElevatedButton.styleFrom(
      backgroundColor: styles['backgroundColor'],
      foregroundColor: styles['foregroundColor'],
    ).merge(style);
  }

  @override
  Widget buildButton({
    required BuildContext context,
    ButtonStyle? style,
    required Widget content,
    required ThemeData theme,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: resolveStyle(theme, style),
      child: content,
    );
  }
}

class AppOutlinedButton extends BaseButton {
  const AppOutlinedButton({
    super.key,
    super.onPressed,
    super.leftIcon,
    super.rightIcon,
    required super.child,
    super.borderRadius,
    super.style,
    super.isLoading = false,
  });

  ButtonStyle resolveStyle(ThemeData theme, ButtonStyle? btnStyle) {
    final styles = super._resolveBtnStyle(theme);

    return OutlinedButton.styleFrom(
      foregroundColor: styles['foregroundColor'],
    ).merge(style);
  }

  @override
  Widget buildButton({
    required BuildContext context,
    ButtonStyle? style,
    required Widget content,
    required ThemeData theme,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: resolveStyle(theme, style),
      child: content,
    );
  }
}

class GhostButton extends BaseButton {
  const GhostButton({
    super.key,
    super.onPressed,
    super.leftIcon,
    super.rightIcon,
    required super.child,
    super.borderRadius,
    super.style,
    super.isLoading = false,
  });

  ButtonStyle resolveStyle(ThemeData theme, ButtonStyle? btnStyle) {
    final styles = super._resolveBtnStyle(theme);

    return TextButton.styleFrom(
      foregroundColor: styles['foregroundColor'],
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ).merge(style);
  }

  @override
  Widget buildButton({
    required BuildContext context,
    ButtonStyle? style,
    required Widget content,
    required ThemeData theme,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: resolveStyle(theme, style),
      child: content,
    );
  }
}
