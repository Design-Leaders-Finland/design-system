import 'package:flutter/material.dart';
import 'package:design_leaders_system/design_leaders_system.dart';

void main() {
  runApp(const OnePageWebApp());
}

class OnePageWebApp extends StatefulWidget {
  const OnePageWebApp({super.key});

  @override
  State<OnePageWebApp> createState() => _OnePageWebAppState();
}

class _OnePageWebAppState extends State<OnePageWebApp> {
  ThemeMode themeMode = ThemeMode.light;

  void _handleThemeChanged(bool isDark) {
    setState(() {
      themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design System Overview',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: OnePageHome(
        themeMode: themeMode,
        onThemeChanged: _handleThemeChanged,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OnePageHome extends StatelessWidget {
  const OnePageHome({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  final ThemeMode themeMode;
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
                child: SizedBox(height: 140 + (isNarrow ? Spacing.s10 : Spacing.s16) * 2),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: Spacing.s12),
                          _ColorPaletteSection(colors: colors),
                          const SizedBox(height: Spacing.s16),
                          _TypographySection(colors: colors),
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
                child: _HeaderSection(
                  isNarrow: isNarrow,
                  colors: colors,
                  themeMode: themeMode,
                  onThemeChanged: onThemeChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({
    required this.isNarrow,
    required this.colors,
    required this.themeMode,
    required this.onThemeChanged,
    super.key,
  });

  final bool isNarrow;
  final AppColorScheme colors;
  final ThemeMode themeMode;
  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.s6,
        vertical: isNarrow ? Spacing.s8 : Spacing.s10,
      ),
      decoration: BoxDecoration(color: colors.surface, boxShadow: AppShadow.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: AppText.display('Design System Overview', style: AppTypography.displayLg, color: colors.textTertiary)),
              _ThemeSwitcher(
                isDark: themeMode == ThemeMode.dark,
                onChanged: onThemeChanged,
              ),
            ],
          ),
          const SizedBox(height: Spacing.s4),
          AppText.body(
            'A lightweight Flutter web landing page built with shared design tokens, responsive spacing, and reusable components.',
            maxLines: 3,
          ),
        /*const SizedBox(height: Spacing.s8),
          Wrap(
            spacing: Spacing.s3,
            runSpacing: Spacing.s3,
            children: const [
              Chip(label: Text('Flutter Web')),
              Chip(label: Text('Design Tokens')),
              Chip(label: Text('Responsive Layout')),
            ],
          ),*/
        ],
      ),
    );
  }
}

class _ColorPaletteSection extends StatelessWidget {
  const _ColorPaletteSection({required this.colors, super.key});

  final AppColorScheme colors;

  List<List<Object>> get paletteItems => [
    // Cardinal tones
    ['Primary', colors.primary],
    ['Secondary', AppColors.secondary],
    ['Accent', AppColors.accent],
    ['Complementary', AppColors.complementary],
    // Semantic tones
    ['Attention', AppColors.attention],
    ['Warning', AppColors.warning],
    ['Danger', AppColors.danger],
    ['Success', AppColors.success],
    // Inscriptive tones
    ['Text default', colors.text],
    ['Text alternate', colors.textAlternate],
    ['Text tertiary', colors.textTertiary],
    ['Text hyperlink', AppColors.hyperlink],
    // Layout tones
    ['Background', colors.background],
    ['Surface', colors.surface],
    ['Border', colors.border],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Spacing.s6),
      padding: const EdgeInsets.all(Spacing.s1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.display('Key Color Tones', color: colors.textTertiary),
          const SizedBox(height: Spacing.s6),
          AppText.body(
              'Cardinal tones ...',
          ),
          const SizedBox(height: Spacing.s4),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: Spacing.s3,
                mainAxisSpacing: Spacing.s3,
                childAspectRatio: 1.1,
                children: paletteItems.take(4).map((item) {
                  return _ColorSwatch(
                    label: item[0] as String,
                    color: item[1] as Color,
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: Spacing.s6),
          AppText.body(
              'Semantic tones ...',
          ),
          const SizedBox(height: Spacing.s6),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: Spacing.s3,
                mainAxisSpacing: Spacing.s3,
                childAspectRatio: 1.1,
                children: paletteItems.skip(4).take(4).map((item) {
                  return _ColorSwatch(
                    label: item[0] as String,
                    color: item[1] as Color,
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: Spacing.s6),
          AppText.body(
              'Inscriptive tones ...',
          ),
          const SizedBox(height: Spacing.s6),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: Spacing.s3,
                mainAxisSpacing: Spacing.s3,
                childAspectRatio: 1.1,
                children: paletteItems.skip(8).take(4).map((item) {
                  return _ColorSwatch(
                    label: item[0] as String,
                    color: item[1] as Color,
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: Spacing.s6),
          AppText.body(
              'Layout tones ...',
          ),
          const SizedBox(height: Spacing.s6),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: Spacing.s3,
                mainAxisSpacing: Spacing.s3,
                childAspectRatio: 1.1,
                children: paletteItems.skip(12).take(4).map((item) {
                  return _ColorSwatch(
                    label: item[0] as String,
                    color: item[1] as Color,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({required this.label, required this.color, super.key});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final brightness = ThemeData.estimateBrightnessForColor(color);
    final textColor = brightness == Brightness.light
        ? AppColors.black
        : AppColors.white;
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppBorderRadius.md),
        border: Border.all(color: Colors.black.withAlpha(20)),
      ),
      padding: const EdgeInsets.all(Spacing.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: textColor),
          ),
          const SizedBox(height: Spacing.s1),
          Text(
            '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: textColor.withAlpha(204)),
          ),
        ],
      ),
    );
  }
}

class _ThemeSwitcher extends StatelessWidget {
  const _ThemeSwitcher({
    required this.isDark,
    required this.onChanged,
    super.key,
  });

  final bool isDark;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.light_mode, size: 18),
        Switch(
          value: isDark,
          onChanged: onChanged,
          activeThumbColor: AppColors.white,
          activeTrackColor: AppColors.white.withAlpha(80),
          inactiveThumbColor: AppColors.secondary,
          inactiveTrackColor: AppColors.secondary.withAlpha(80),
        ),
        const Icon(Icons.dark_mode, size: 18),
      ],
    );
  }
}

class _TypographySection extends StatelessWidget {
  const _TypographySection({required this.colors, super.key});

  final AppColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Spacing.s6),
      padding: const EdgeInsets.all(Spacing.s6),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        boxShadow: AppShadow.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.display('Typography', color: colors.textTertiary),
          const SizedBox(height: Spacing.s6),
          AppText.body(
              'The design system provides a set of shared text styles and typography tokens for consistent text styling across the app.',
          ),
          const SizedBox(height: Spacing.s4),
          AppText.heading(
            '<h1> Figtree Light 300 / 32px - Default', style: AppTypography.headlineLg,
            maxLines: 1,
          ),
          const SizedBox(height: Spacing.s4),
          AppText.heading(
            '<h2> Figtree Light 300 / 28px - Alternate', style: AppTypography.headlineMd, color:context.colors.textAlternate,
            maxLines: 1,
          ),
          const SizedBox(height: Spacing.s4),
          AppText.heading(
            '<h3> Figtree SemiBold 600 / 24px - Tertiary', style: AppTypography.headlineSm, color:context.colors.textTertiary,
            maxLines: 1,
          ),
          const SizedBox(height: Spacing.s4),
          AppText.body(
            '<p> Asap Condensed Regular 400 / 16px - Default', style: AppTypography.bodyLg,
            maxLines: 1,
          ),
          const SizedBox(height: Spacing.s4),
          AppText.rich(
            '<a> Asap Condensed SemiBold 600 / 16px - Hyperlink', style: AppTypography.bodyStrong,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

class _TypographyPreviewCard extends StatelessWidget {
  const _TypographyPreviewCard({
    required this.label,
    required this.sample,
    required this.colors,
    super.key,
  });

  final String label;
  final Widget sample;
  final AppColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.s4),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppBorderRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: colors.text,
            ),
          ),
          const SizedBox(height: Spacing.s2),
          sample,
        ],
      ),
    );
  }
}

/*

class _FeatureSection extends StatelessWidget {
  const _FeatureSection({
    required this.isNarrow,
    required this.colors,
    super.key,
  });

  final bool isNarrow;
  final AppColorScheme colors;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _FeatureCard(
        title: 'Shared Theme',
        description:
            'Use AppTheme and ThemeExtension values across onepage and the package.',
        color: colors.primary,
      ),
      _FeatureCard(
        title: 'Typography',
        description:
            'Centralized text styles with AppTypography and AppText helpers.',
        color: colors.secondary,
      ),
      _FeatureCard(
        title: 'Spacing Scale',
        description:
            'Consistent spacing using spacing tokens such as Spacing.s8 and AppBorderRadius.',
        color: colors.accent,
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.s6),
      child: isNarrow
          ? Column(children: cards)
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cards
                  .map(
                    (card) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.s3,
                        ),
                        child: card,
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class _CallToActionSection extends StatelessWidget {
  const _CallToActionSection({required this.colors, super.key});

  final AppColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Spacing.s6),
      padding: const EdgeInsets.all(Spacing.s8),
      decoration: BoxDecoration(
        color: colors.primary.withAlpha(20),
        borderRadius: BorderRadius.circular(AppBorderRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.heading('Ready to launch your next web app?'),
          const SizedBox(height: Spacing.s4),
          AppText.body(
            'Onepage is styled with shared design tokens and reusable widgets from the design system package.',
            maxLines: 2,
          ),
          const SizedBox(height: Spacing.s6),
          SolidButton(
            onPressed: () {},
            child: AppText.label('Get started'),
          ),
        ],
      ),
    );
  }
}

*/

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.title,
    required this.description,
    required this.color,
    super.key,
  });

  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Spacing.s6),
      padding: const EdgeInsets.all(Spacing.s6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        boxShadow: AppShadow.sm,
        border: Border.all(color: color.withAlpha(41)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: color),
          ),
          const SizedBox(height: Spacing.s3),
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
