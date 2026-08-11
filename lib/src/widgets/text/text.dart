import 'package:flutter/material.dart';
import '../../tokens/typography/typography.dart';
import '../../tokens/colors/colors.dart';

class AppText extends StatelessWidget {
  AppText.display(
    this.text, {
    super.key,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.style = AppTypography.displayMd,
    Color? color,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  }) : color = color;

  AppText.heading(
    this.text, {
    super.key,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.style = AppTypography.headlineMd,
    Color? color,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  }) : color = color;

  AppText.title(
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

  AppText.label(
    this.text, {
    super.key,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.style = AppTypography.labelMd,
    Color? color,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  }) : color = color;

  AppText.body(
    this.text, {
    super.key,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.style = AppTypography.bodyMd,
    Color? color,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  }) : color = color;

  AppText.rich(
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
