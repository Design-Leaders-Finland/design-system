# design_leaders_system

The Design System of Design Leaders Finland in-house provided apps.

## Features

### Design Tokens

- **Colors**: Pre-defined color palette (`AppColors`) with semantic color definitions
- **Typography**: Font sizing (`FontSize`), weights (`AppFontWeight`), line heights (`AppLineHeight`), letter spacing (`AppLetterSpacing`), and text styles (`AppTypography`, `FontFamily`)
- **Spacing**: Consistent spacing scale (`Spacing`), border radius (`AppBorderRadius`), and shadows (`AppShadow`)

### Theme

- **AppTheme**: Pre-configured light and dark themes with Material 3
- **AppColorScheme**: Theme extension for accessing custom colors
- **AppTextScheme**: Theme extension for accessing custom text styles
- **BuildContext extensions**: Convenient accessors for colors, text styles, and density

### Widgets

- **AppText**: Text widget with predefined styles (display, heading, label, body variants)
- **Buttons**: `SolidButton`, `AppOutlinedButton`, `GhostButton` with loading state support
- **Gap**: Spacing widget for consistent layout gaps

## Usage

### As a Git Dependency

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  design_leaders_system:
    git:
      url: ssh://git@github.com/Design-Leaders-Finland/design-system.git
      ref: main # or specify a tag/commit for stability
```

### Example

```dart
import 'package:flutter/material.dart';
import 'package:design_leaders_system/design_leaders_system.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access colors via context extension
    final colors = context.colors;
    
    return Scaffold(
      backgroundColor: colors.background,
      body: Column(
        children: [
          AppText.heading('Hello World'),
          const Gap.md(),
          SolidButton(
            onPressed: () {},
            child: const AppText.label('Click me'),
          ),
        ],
      ),
    );
  }
}
```

## Demo App

The `onepage/` folder contains a demo application showcasing the design system components. It demonstrates:

- Light and dark theme switching
- Typography usage
- Color palette display
- Spacing and layout with tokens
- Button variants

The demo app is not included in the package itself but serves as a reference implementation.

## Development

```bash
# Get dependencies
flutter pub get

# Run static analysis
flutter analyze

# Run tests
flutter test
```

## License

Apache 2