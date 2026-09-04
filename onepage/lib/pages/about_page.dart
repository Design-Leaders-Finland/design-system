import 'package:flutter/material.dart';
import 'package:design_leaders_system/design_leaders_system.dart';

import '../widgets/app_header.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({
    super.key,
    required this.data,
    required this.onThemeChanged,
  });

  final AboutData data;
  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = width < 900;

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 140 + (isNarrow ? Spacing.s10 : Spacing.s16) * 2,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.s6),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: Spacing.s12),
                          _AboutHeader(colors: colors),
                          const SizedBox(height: Spacing.s12),
                          _AboutContent(data: data, colors: colors),
                          const SizedBox(height: Spacing.s16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: AppHeader(onThemeChanged: onThemeChanged),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutHeader extends StatelessWidget {
  const _AboutHeader({required this.colors});

  final AppColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.display('About', color: colors.textTertiary),
        const SizedBox(height: Spacing.s4),
        AppText.body(
          'Information about Design Leaders Finland and the libraries used in this design system.',
        ),
      ],
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent({required this.data, required this.colors});

  final AboutData data;
  final AppColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(Spacing.s6),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppBorderRadius.lg),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.heading('Company', color: colors.text),
              const SizedBox(height: Spacing.s4),
              AppText.body(data.companyInfo),
            ],
          ),
        ),
        const SizedBox(height: Spacing.s8),
        Container(
          padding: const EdgeInsets.all(Spacing.s6),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppBorderRadius.lg),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.heading('Library Licenses', color: colors.text),
              const SizedBox(height: Spacing.s4),
              ...data.libraryLicenses.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: Spacing.s2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppText.body(entry.key, color: colors.text),
                      ),
                      AppText.body(
                        entry.value,
                        color: colors.textTertiary,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: Spacing.s8),
        Semantics(
          label: 'Visit Design Leaders Finland website',
          button: true,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(Spacing.s6),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                border: Border.all(color: colors.border),
              ),
              child: Row(
                children: [
                  Icon(Icons.language, color: colors.primary, size: 24),
                  const SizedBox(width: Spacing.s4),
                  Expanded(
                    child: AppText.body(
                      data.designLeadersLink,
                      color: AppColors.hyperlink,
                    ),
                  ),
                  Icon(Icons.open_in_new, color: colors.textTertiary, size: 18),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
