# Design System Widgetbook

Interactive [Widgetbook](https://www.widgetbook.io/) gallery for the Design
Leaders Finland design system. It showcases every component, token, and layout
in the system with live previews, theme switching (system / light / dark), and
configurable knobs.

## Getting Started

This is a web-only Flutter application that renders the design system catalog.

    # Install dependencies
    flutter pub get

    # Run the gallery in Chrome
    flutter run -d chrome

## Structure

- `lib/main.dart` — app entry point; wires up the Widgetbook, theme addon, and
  theme-mode persistence.
- `lib/home.dart` — the Widgetbook home/landing page.
- `lib/gallery_header.dart` — branded navigation header.
- `lib/catalog/` — component, token, and layout use cases shown in the gallery.

The design system itself lives in the parent package and is consumed as a
dependency; see the root `README.md` for details on the tokens and widgets.
