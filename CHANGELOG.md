# Changelog for the Design Leaders System

## 0.1.0 (2026-08-22)

Initial release of the Design Leaders Finland design system, a Flutter package for building consistent in-house apps. It bundles design tokens, a Material 3 based theme, a set of shared widgets, and a reference web app that can be browsed live on Netlify.

### Design tokens

- Colors: a full palette (`AppColors`) with cardinal, semantic (attention, warning, danger, success), inscriptive, and layout tones, including dark-mode variants.
- Typography: font sizes, weights, line heights, and letter spacing built on a 4px base unit, plus ready-made text styles (`AppTypography`) backed by the bundled custom fonts Figtree and Asap Condensed.
- Spacing and sizing: a consistent spacing scale (`Spacing`), border radii, shadows, and component sizing tokens for controls, icons, and touch targets.

### Theme

- `AppTheme` with pre-configured light and dark themes using Material 3.
- `AppColorScheme` and `AppTextScheme` theme extensions for accessing custom colors and text styles.
- `BuildContext` extensions for convenient access to colors, text styles, and density.
- Shared page transition helper (`AppPageTransition`) so all pages animate consistently with a fade and slide.

### Widgets

- `AppText` with predefined display, heading, label, and body variants, including rich text support.
- Buttons: `SolidButton`, `AppOutlinedButton`, and `GhostButton` with loading state support.
- `Gap` spacing widget for consistent layout gaps.

### Demo application

- A `onepage` web app showcasing the design system: color palette, typography, spacing and sizing tokens, and a curated gallery of Material widgets.
- Light and dark theme switching with the choice persisted in the browser (localStorage), built for both WebAssembly (WASM) and regular web targets.
- Separate "About" and "Widgets" pages with routing and consistent page transitions.
- Proper favicon and web app icons.
- Available at https://design-leaders-design-system.netlify.app/

### Release engineering

- Published as the `design_leaders_system` Dart/Flutter package with usage instructions for consuming it as a Git dependency internally.
- Automated deployment of the demo app to Netlify on every push to `main`.
- CI using a pinned, shared Flutter setup with consistent versioning across the repo.
- Binary assets tracked with Git LFS.
- Formatting normalized with oxfmt.
