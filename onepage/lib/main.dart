import 'package:flutter/material.dart';
import 'package:design_leaders_system/design_leaders_system.dart';
import 'package:go_router/go_router.dart';
import 'theme_mode_store.dart';
import 'widgets/app_header.dart';
import 'pages/widgets_page.dart';
import 'pages/about_page.dart';

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

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final saved = loadThemeMode();
    if (!mounted) return;
    setState(() {
      themeMode = saved == 'dark' ? ThemeMode.dark : ThemeMode.light;
    });
  }

  Future<void> _handleThemeChanged(bool isDark) async {
    saveThemeMode(isDark ? 'dark' : 'light');
    if (!mounted) return;
    setState(() {
      themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            OnePageHome(onThemeChanged: _handleThemeChanged),
      ),
      GoRoute(
        path: '/widgets',
        builder: (context, state) =>
            WidgetsPage(onThemeChanged: _handleThemeChanged),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => AboutPage(
          data: AboutData.load(),
          onThemeChanged: _handleThemeChanged,
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Design System Overview',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class OnePageHome extends StatelessWidget {
  const OnePageHome({super.key, required this.onThemeChanged});

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
                child: AppHeader(
                  isNarrow: isNarrow,
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

class _ColorPaletteSection extends StatelessWidget {
  const _ColorPaletteSection({required this.colors});

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
          AppText.body('Cardinal tones ...'),
          const SizedBox(height: Spacing.s4),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 800 ? 6 : 3;
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
          AppText.body('Semantic tones ...'),
          const SizedBox(height: Spacing.s6),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 800 ? 6 : 3;
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
          AppText.body('Inscriptive tones ...'),
          const SizedBox(height: Spacing.s6),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 800 ? 6 : 3;
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
          AppText.body('Layout tones ...'),
          const SizedBox(height: Spacing.s6),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 800 ? 6 : 3;
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
  const _ColorSwatch({required this.label, required this.color});

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

class _TypographySection extends StatelessWidget {
  const _TypographySection({required this.colors});

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
          AppText.display(
            'Typography (Context aware)',
            color: colors.textTertiary,
          ),
          const SizedBox(height: Spacing.s6),
          AppText.body(
            'The design system provides a set of shared text styles and typography tokens for consistent text styling across the app.',
          ),
          AppText.body('Operating system aware font selection.'),
          const SizedBox(height: Spacing.s4),
          AppText.heading(
            '<h1> Figtree Light 300 / 32px - Default',
            style: AppTypography.headlineLg,
            maxLines: 1,
          ),
          const SizedBox(height: Spacing.s4),
          AppText.heading(
            '<h2> Figtree Light 300 / 28px - Alternate',
            style: AppTypography.headlineMd,
            color: context.colors.textAlternate,
            maxLines: 1,
          ),
          const SizedBox(height: Spacing.s4),
          AppText.heading(
            '<h3> Figtree SemiBold 600 / 24px - Tertiary',
            style: AppTypography.headlineSm,
            color: context.colors.textTertiary,
            maxLines: 1,
          ),
          const SizedBox(height: Spacing.s4),
          AppText.body(
            '<p> Asap Condensed Regular 400 / 16px - Default',
            style: AppTypography.bodyLg,
            maxLines: 1,
          ),
          const SizedBox(height: Spacing.s4),
          AppText.rich(
            '<a> Asap Condensed SemiBold 600 / 16px - Hyperlink',
            style: AppTypography.bodyStrong,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
