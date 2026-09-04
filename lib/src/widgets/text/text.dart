import 'package:flutter/material.dart';

import '../../tokens/typography/typography.dart';
import '../../tokens/colors/colors.dart';

class AppText extends StatelessWidget {
  const AppText.display(
    this.text, {
    super.key,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.style = AppTypography.displayMd,
    this.color,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  });

  const AppText.heading(
    this.text, {
    super.key,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.style = AppTypography.headlineMd,
    this.color,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  });

  const AppText.title(
    this.text, {
    super.key,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.style = AppTypography.titleMd,
    this.color = AppColors.primary,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  });

  const AppText.label(
    this.text, {
    super.key,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.style = AppTypography.labelMd,
    this.color,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  });

  const AppText.body(
    this.text, {
    super.key,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.style = AppTypography.bodyMd,
    this.color,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  });

  const AppText.rich(
    this.text, {
    super.key,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.style = AppTypography.bodyMd,
    this.color = AppColors.hyperlink,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  });

  final String text;
  final TextStyle style;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final themeColor = color ?? Theme.of(context).colorScheme.onSurface;

    return Text(
      text,
      style: style.copyWith(
        color: themeColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
