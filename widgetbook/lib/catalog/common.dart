import 'package:design_leaders_system/design_leaders_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

// ── Catalog helpers ──────────────────────────────────────────────────────────
//
// Small convenience wrappers around Widgetbook's navigation nodes so the
// Material catalog reads as a flat, declarative list of widgets.

/// A [WidgetbookComponent] with a single "Default" use case.
WidgetbookComponent component(String name, WidgetBuilder builder) {
  return WidgetbookComponent(
    name: name,
    useCases: [WidgetbookUseCase(name: 'Default', builder: builder)],
  );
}

/// A [WidgetbookComponent] with several named use cases (variants/states).
///
/// The map iteration order is preserved, so the first entry becomes the
/// component's landing use case.
WidgetbookComponent componentVariants(
  String name,
  Map<String, WidgetBuilder> useCases,
) {
  return WidgetbookComponent(
    name: name,
    useCases: [
      for (final entry in useCases.entries)
        WidgetbookUseCase(name: entry.key, builder: entry.value),
    ],
  );
}

/// A [WidgetbookCategory] grouping related components under [name].
WidgetbookCategory category(String name, List<WidgetbookNode> children) {
  return WidgetbookCategory(name: name, children: children);
}

// ── State host ───────────────────────────────────────────────────────────────

/// A tiny stateful host that lets an otherwise-stateless use case own a
/// mutable value.
///
/// Interactive Material widgets (checkboxes, sliders, radios, navigation bars,
/// …) need somewhere to keep their state. Declaring that state inside a
/// `StatefulBuilder` closure resets it on every rebuild (the same trap the
/// `onepage` gallery documents), so each demo holds its value in this real
/// [StatefulWidget] instead.
class DemoState<T> extends StatefulWidget {
  const DemoState({super.key, required this.initial, required this.builder});

  /// The value the demo starts with.
  final T initial;

  /// Builds the widget for the current [value]; call [setValue] to update it.
  final Widget Function(BuildContext context, T value, ValueChanged<T> setValue)
  builder;

  @override
  State<DemoState<T>> createState() => _DemoStateState<T>();
}

class _DemoStateState<T> extends State<DemoState<T>> {
  late T _value = widget.initial;

  void _setValue(T next) => setState(() => _value = next);

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _value, _setValue);
  }
}

// ── Shared bits ──────────────────────────────────────────────────────────────

/// Shows a floating [SnackBar] using the design system's colors.
///
/// Used by the interactive demos so taps give visible feedback.
void showDemoSnack(BuildContext context, String message) {
  final colors = context.colors;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.surface,
        content: Text(message, style: TextStyle(color: colors.text)),
      ),
    );
}

/// Centers [child] with a little breathing room so small widgets are not
/// flush against the workbench edges.
Widget demoBox(Widget child) {
  return Padding(padding: const EdgeInsets.all(Spacing.s6), child: child);
}
