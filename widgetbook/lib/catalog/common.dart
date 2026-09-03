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

// ── Knob helpers ─────────────────────────────────────────────────────────────

/// Renders a value with a fixed set of [options] using the gallery's control
/// convention:
///
/// * **two options** (a binary choice, or an enum with exactly two values) are
///   shown as a [Switch] via Widgetbook's boolean knob — the switch's
///   `description` spells out which value each side maps to;
/// * **more than two options** are shown as a dropdown.
///
/// [labelBuilder] customises how a value reads in the dropdown/description;
/// enum values default to their `.name`, everything else to `toString()`.
T optionKnob<T>(
  BuildContext context, {
  required String label,
  required List<T> options,
  required T initial,
  String Function(T value)? labelBuilder,
  String? description,
}) {
  if (options.length < 2) return options.first;
  final describe = labelBuilder ?? _defaultLabel<T>;

  if (options.length == 2) {
    final isOn = context.knobs.boolean(
      label: label,
      description:
          description ??
          'off: ${describe(options[0])} · on: ${describe(options[1])}',
      initialValue: initial == options[1],
    );
    return isOn ? options[1] : options[0];
  }

  return context.knobs.object.dropdown<T>(
    label: label,
    description: description,
    options: options,
    initialOption: initial,
    labelBuilder: describe,
  );
}

String _defaultLabel<T>(T value) => value is Enum ? value.name : '$value';

/// A curated set of Material icons offered by [iconKnob], keyed by a readable
/// name so the dropdown shows `star` rather than an opaque [IconData].
const Map<String, IconData> iconChoices = {
  'add': Icons.add,
  'edit': Icons.edit,
  'delete': Icons.delete,
  'favorite': Icons.favorite,
  'star': Icons.star,
  'settings': Icons.settings,
  'share': Icons.share,
  'download': Icons.download,
  'search': Icons.search,
  'home': Icons.home,
  'person': Icons.person,
  'mail': Icons.mail,
  'notifications': Icons.notifications,
  'check': Icons.check,
  'close': Icons.close,
  'menu': Icons.menu,
};

/// A dropdown knob that picks one [IconData] from [iconChoices].
IconData iconKnob(
  BuildContext context, {
  String label = 'Icon',
  IconData initial = Icons.star,
}) {
  return context.knobs.object.dropdown<IconData>(
    label: label,
    options: iconChoices.values.toList(),
    initialOption: initial,
    labelBuilder: (icon) =>
        iconChoices.entries.firstWhere((entry) => entry.value == icon).key,
  );
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
