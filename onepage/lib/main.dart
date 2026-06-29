import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

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
      title: 'Design System OnePage',
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
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _HeaderSection(
                  isNarrow: isNarrow,
                  colors: colors,
                  themeMode: themeMode,
                  onThemeChanged: onThemeChanged,
                ),
                const SizedBox(height: Spacing.s12),
                _ColorPaletteSection(colors: colors),
                const SizedBox(height: Spacing.s16),
                _FeatureSection(isNarrow: isNarrow, colors: colors),
                const SizedBox(height: Spacing.s20),
                _CallToActionSection(colors: colors),
                const SizedBox(height: Spacing.s24),
              ],
            ),
          ),
        ),
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
        vertical: isNarrow ? Spacing.s10 : Spacing.s16,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: AppShadow.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: const AppText.heading(
                  'Design System for Web',
                ),
              ),
              _ThemeSwitcher(
                isDark: themeMode == ThemeMode.dark,
                onChanged: onThemeChanged,
              ),
            ],
          ),
          const SizedBox(height: Spacing.s4),
          const AppText.body(
            'A lightweight Flutter web landing page built with shared design tokens, responsive spacing, and reusable components.',
            maxLines: 3,
          ),
          const SizedBox(height: Spacing.s8),
          Wrap(
            spacing: Spacing.s3,
            runSpacing: Spacing.s3,
            children: const [
              Chip(label: Text('Flutter Web')),
              Chip(label: Text('Design Tokens')),
              Chip(label: Text('Responsive Layout')),
            ],
          ),
        ],
      ),
    );
  }
}

class _ColorPaletteSection extends StatelessWidget {
  const _ColorPaletteSection({
    required this.colors,
    super.key,
  });

  final AppColorScheme colors;

  static const List<List<Object>> paletteItems = [
    ['Primary', AppColors.primary],
    ['Secondary', AppColors.secondary],
    ['Accent', AppColors.accent],
    ['Background', AppColors.background],
    ['Surface', AppColors.background],
    ['Text', AppColors.text],
    ['Border', AppColors.border],
    ['Danger', AppColors.danger],
    ['White', AppColors.white],
    ['Black', AppColors.black],
  ];

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
          const AppText.heading('Color palette'),
          const SizedBox(height: Spacing.s4),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 800 ? 5 : 2;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: Spacing.s3,
                mainAxisSpacing: Spacing.s3,
                childAspectRatio: 1.1,
                children: paletteItems.map((item) {
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
  const _ColorSwatch({
    required this.label,
    required this.color,
    super.key,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final brightness = ThemeData.estimateBrightnessForColor(color);
    final textColor = brightness == Brightness.light ? AppColors.black : AppColors.white;
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppBorderRadius.md),
        border: Border.all(
          color: Colors.black.withAlpha(20),
        ),
      ),
      padding: const EdgeInsets.all(Spacing.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: textColor),
          ),
          const SizedBox(height: Spacing.s1),
          Text(
            '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor.withAlpha(204)),
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
          activeThumbColor: AppColors.primary,
          activeTrackColor: AppColors.primary.withAlpha(80),
          inactiveThumbColor: AppColors.secondary,
          inactiveTrackColor: AppColors.secondary.withAlpha(80),
        ),
        const Icon(Icons.dark_mode, size: 18),
      ],
    );
  }
}

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
        description: 'Use AppTheme and ThemeExtension values across onepage and the package.',
        color: colors.primary,
      ),
      _FeatureCard(
        title: 'Typography',
        description: 'Centralized text styles with AppTypography and AppText helpers.',
        color: colors.secondary,
      ),
      _FeatureCard(
        title: 'Spacing Scale',
        description: 'Consistent spacing using spacing tokens such as Spacing.s8 and AppBorderRadius.',
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
                  .map((card) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Spacing.s3),
                          child: card,
                        ),
                      ))
                  .toList(),
            ),
    );
  }
}

class _CallToActionSection extends StatelessWidget {
  const _CallToActionSection({
    required this.colors,
    super.key,
  });

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
          const AppText.heading(
            'Ready to launch your next web app?',
          ),
          const SizedBox(height: Spacing.s4),
          const AppText.body(
            'Onepage is styled with shared design tokens and reusable widgets from the design system package.',
            maxLines: 2,
          ),
          const SizedBox(height: Spacing.s6),
          SolidButton(
            onPressed: () {},
            child: const AppText.label('Get started'),
          ),
        ],
      ),
    );
  }
}

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
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: color),
          ),
          const SizedBox(height: Spacing.s3),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
