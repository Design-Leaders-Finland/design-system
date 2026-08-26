# onepage

Design System of the Design Leaders Finland

## Web-only deployment & the loading splash

This app deploys **only** to the web, so it ships a hand-written `web/index.html`
shell. The site is served as a **modular** build: the tiny HTML/CSS/SVG loader
shell is decoupled from the Flutter app, which is compiled to a WebAssembly
module.

### Build & deploy

```sh
flutter build web --wasm --release
```

The output in `build/web/` is what gets deployed (Netlify serves it manually,
see `../netlify.toml`). The build keeps `latest`:

- `main.dart.wasm` – the Dart app compiled to WASM (primary, skwasm renderer).
- `main.dart.js` / `main.dart.mjs` – the dart2js/canvaskit fallback builds.
- `index.html` – the _modular loader shell_.

### How the loader works

`web/index.html` contains:

1. **An instantly-visible ink-drop animation** in pure HTML/CSS/SVG (inspired by
   the `loading_animation_widget` package's `inkDrop`). Because it is plain
   CSS, it paints the moment the HTML arrives — before any Dart or WASM bytes
   are fetched or compiled — so the user always sees feedback immediately.
2. **A custom Flutter Web bootstrap** that replaces the default
   `flutter_bootstrap.js` auto-load. It inlines the small `flutter.js` loader
   (`{{flutter_js}}`) and the build descriptor (`{{flutter_build_config}}`), then
   calls `_flutter.loader.load({ onEntrypointLoaded })`. Once the `onEntrypointLoaded`
   callback fires (the WASM engine is ready), the splash element is removed and
   `appRunner.runApp()` starts the real app.

`flutter build web --wasm --release` replaces the `{{flutter_js}}` /
`{{flutter_build_config}}` placeholders — never edit the built output, only
`web/index.html`. The brand colors used by the splash (`#FAFBFC` background,
`#2F927B` accent) mirror the design-system `AppColors`.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
