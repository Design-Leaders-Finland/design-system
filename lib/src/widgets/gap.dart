import 'package:flutter/material.dart';
import '../tokens/spacing/spacing.dart';

class Gap extends StatelessWidget {
  const Gap.horizontal(this.width, {super.key, this.height});
  const Gap.vertical(this.height, {super.key, this.width});

  const Gap.xs({super.key}) : width = Spacing.s4, height = Spacing.s4;
  const Gap.sm({super.key}) : width = Spacing.s8, height = Spacing.s8;
  const Gap.md({super.key}) : width = Spacing.s16, height = Spacing.s16;
  const Gap.lg({super.key}) : width = Spacing.s32, height = Spacing.s32;
  const Gap.xl({super.key}) : width = Spacing.s64, height = Spacing.s64;

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }
}
