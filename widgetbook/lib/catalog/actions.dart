import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'common.dart';

// ── Actions ──────────────────────────────────────────────────────────────────
// Buttons, FABs, menus and chips. Every constructor property worth tweaking is
// exposed as a knob. Binary properties and two-option enums render as switches
// (see `optionKnob` in common.dart); larger enums render as dropdowns.

enum _FilledVariant { filled, tonal }

enum _IconButtonVariant { standard, filled, filledTonal, outlined }

enum _FabType { normal, small, large, extended }

/// ButtonStyle knobs shared by the plain Material buttons. `null` colors fall
/// back to the design system theme defaults.
ButtonStyle _buttonStyleKnobs(
  BuildContext context, {
  bool withElevation = true,
}) {
  final k = context.knobs;
  final background = k.colorOrNull(label: 'Background', defaultToNull: true);
  final foreground = k.colorOrNull(label: 'Foreground', defaultToNull: true);
  final overlay = k.colorOrNull(label: 'Overlay color', defaultToNull: true);
  final radius = k.double.slider(
    label: 'Corner radius',
    initialValue: 20,
    min: 0,
    max: 40,
    divisions: 40,
  );
  return ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(background),
    foregroundColor: WidgetStatePropertyAll(foreground),
    overlayColor: WidgetStatePropertyAll(overlay),
    elevation: withElevation
        ? WidgetStatePropertyAll(
            k.doubleOrNull.slider(
              label: 'Elevation',
              initialValue: 1,
              min: 0,
              max: 12,
              defaultToNull: true,
            ),
          )
        : null,
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    ),
  );
}

/// Buttons, floating action buttons, menus and chips.
WidgetbookCategory get actionsCategory => category('Actions', [
  component('ElevatedButton', (context) {
    final k = context.knobs;
    final enabled = k.boolean(label: 'Enabled (onPressed)', initialValue: true);
    final hasIcon = k.boolean(label: 'Has icon', initialValue: false);
    final label = k.string(label: 'Label', initialValue: 'Elevated');
    final icon = iconKnob(context, initial: Icons.download);
    final autofocus = k.boolean(label: 'Autofocus', initialValue: false);
    final clip = optionKnob<Clip>(
      context,
      label: 'Clip behavior',
      options: Clip.values,
      initial: Clip.none,
    );
    final style = _buttonStyleKnobs(context);
    final onPressed = enabled
        ? () => showDemoSnack(context, 'ElevatedButton pressed')
        : null;
    return hasIcon
        ? ElevatedButton.icon(
            onPressed: onPressed,
            autofocus: autofocus,
            clipBehavior: clip,
            style: style,
            icon: Icon(icon),
            label: Text(label),
          )
        : ElevatedButton(
            onPressed: onPressed,
            autofocus: autofocus,
            clipBehavior: clip,
            style: style,
            child: Text(label),
          );
  }),
  component('FilledButton', (context) {
    final k = context.knobs;
    final variant = optionKnob<_FilledVariant>(
      context,
      label: 'Variant',
      options: _FilledVariant.values,
      initial: _FilledVariant.filled,
    );
    final enabled = k.boolean(label: 'Enabled (onPressed)', initialValue: true);
    final label = k.string(label: 'Label', initialValue: 'Filled');
    final autofocus = k.boolean(label: 'Autofocus', initialValue: false);
    final style = _buttonStyleKnobs(context);
    final onPressed = enabled
        ? () => showDemoSnack(context, 'FilledButton pressed')
        : null;
    return switch (variant) {
      _FilledVariant.filled => FilledButton(
        onPressed: onPressed,
        autofocus: autofocus,
        style: style,
        child: Text(label),
      ),
      _FilledVariant.tonal => FilledButton.tonal(
        onPressed: onPressed,
        autofocus: autofocus,
        style: style,
        child: Text(label),
      ),
    };
  }),
  component('OutlinedButton', (context) {
    final k = context.knobs;
    final enabled = k.boolean(label: 'Enabled (onPressed)', initialValue: true);
    final hasIcon = k.boolean(label: 'Has icon', initialValue: false);
    final label = k.string(label: 'Label', initialValue: 'Outlined');
    final icon = iconKnob(context, initial: Icons.share);
    final autofocus = k.boolean(label: 'Autofocus', initialValue: false);
    final style = _buttonStyleKnobs(context, withElevation: false);
    final onPressed = enabled
        ? () => showDemoSnack(context, 'OutlinedButton pressed')
        : null;
    return hasIcon
        ? OutlinedButton.icon(
            onPressed: onPressed,
            autofocus: autofocus,
            style: style,
            icon: Icon(icon),
            label: Text(label),
          )
        : OutlinedButton(
            onPressed: onPressed,
            autofocus: autofocus,
            style: style,
            child: Text(label),
          );
  }),
  component('TextButton', (context) {
    final k = context.knobs;
    final enabled = k.boolean(label: 'Enabled (onPressed)', initialValue: true);
    final hasIcon = k.boolean(label: 'Has icon', initialValue: false);
    final label = k.string(label: 'Label', initialValue: 'Text button');
    final icon = iconKnob(context, initial: Icons.favorite);
    final autofocus = k.boolean(label: 'Autofocus', initialValue: false);
    final style = _buttonStyleKnobs(context, withElevation: false);
    final onPressed = enabled
        ? () => showDemoSnack(context, 'TextButton pressed')
        : null;
    return hasIcon
        ? TextButton.icon(
            onPressed: onPressed,
            autofocus: autofocus,
            style: style,
            icon: Icon(icon),
            label: Text(label),
          )
        : TextButton(
            onPressed: onPressed,
            autofocus: autofocus,
            style: style,
            child: Text(label),
          );
  }),
  component('IconButton', (context) {
    final k = context.knobs;
    final variant = optionKnob<_IconButtonVariant>(
      context,
      label: 'Variant',
      options: _IconButtonVariant.values,
      initial: _IconButtonVariant.standard,
    );
    final enabled = k.boolean(label: 'Enabled (onPressed)', initialValue: true);
    final toggleable = k.boolean(label: 'Toggleable', initialValue: false);
    final isSelected = k.boolean(label: 'Selected', initialValue: false);
    final icon = iconKnob(context, label: 'Icon', initial: Icons.favorite);
    final selectedIcon = iconKnob(
      context,
      label: 'Selected icon',
      initial: Icons.check,
    );
    final iconSize = k.double.slider(
      label: 'Icon size',
      initialValue: 24,
      min: 12,
      max: 48,
      divisions: 36,
    );
    final color = k.colorOrNull(label: 'Color', defaultToNull: true);
    final tooltip = k.stringOrNull(label: 'Tooltip', defaultToNull: true);
    final autofocus = k.boolean(label: 'Autofocus', initialValue: false);

    final onPressed = enabled
        ? () => showDemoSnack(context, 'IconButton pressed')
        : null;
    return switch (variant) {
      _IconButtonVariant.standard => IconButton(
        onPressed: onPressed,
        iconSize: iconSize,
        color: color,
        tooltip: tooltip,
        autofocus: autofocus,
        isSelected: toggleable ? isSelected : null,
        selectedIcon: toggleable ? Icon(selectedIcon) : null,
        icon: Icon(icon),
      ),
      _IconButtonVariant.filled => IconButton.filled(
        onPressed: onPressed,
        iconSize: iconSize,
        color: color,
        tooltip: tooltip,
        autofocus: autofocus,
        isSelected: toggleable ? isSelected : null,
        selectedIcon: toggleable ? Icon(selectedIcon) : null,
        icon: Icon(icon),
      ),
      _IconButtonVariant.filledTonal => IconButton.filledTonal(
        onPressed: onPressed,
        iconSize: iconSize,
        color: color,
        tooltip: tooltip,
        autofocus: autofocus,
        isSelected: toggleable ? isSelected : null,
        selectedIcon: toggleable ? Icon(selectedIcon) : null,
        icon: Icon(icon),
      ),
      _IconButtonVariant.outlined => IconButton.outlined(
        onPressed: onPressed,
        iconSize: iconSize,
        color: color,
        tooltip: tooltip,
        autofocus: autofocus,
        isSelected: toggleable ? isSelected : null,
        selectedIcon: toggleable ? Icon(selectedIcon) : null,
        icon: Icon(icon),
      ),
    };
  }),
  component('FloatingActionButton', (context) {
    final k = context.knobs;
    final type = optionKnob<_FabType>(
      context,
      label: 'Type',
      options: _FabType.values,
      initial: _FabType.normal,
    );
    final enabled = k.boolean(label: 'Enabled (onPressed)', initialValue: true);
    final icon = iconKnob(context, initial: Icons.add);
    final label = k.string(label: 'Extended label', initialValue: 'Compose');
    final tooltip = k.stringOrNull(label: 'Tooltip', defaultToNull: true);
    final background = k.colorOrNull(label: 'Background', defaultToNull: true);
    final foreground = k.colorOrNull(label: 'Foreground', defaultToNull: true);
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 6,
      min: 0,
      max: 16,
      defaultToNull: true,
    );
    final autofocus = k.boolean(label: 'Autofocus', initialValue: false);
    final onPressed = enabled
        ? () => showDemoSnack(context, 'FAB pressed')
        : null;

    return switch (type) {
      _FabType.normal => FloatingActionButton(
        onPressed: onPressed,
        tooltip: tooltip,
        backgroundColor: background,
        foregroundColor: foreground,
        elevation: elevation,
        autofocus: autofocus,
        child: Icon(icon),
      ),
      _FabType.small => FloatingActionButton.small(
        onPressed: onPressed,
        tooltip: tooltip,
        backgroundColor: background,
        foregroundColor: foreground,
        elevation: elevation,
        autofocus: autofocus,
        child: Icon(icon),
      ),
      _FabType.large => FloatingActionButton.large(
        onPressed: onPressed,
        tooltip: tooltip,
        backgroundColor: background,
        foregroundColor: foreground,
        elevation: elevation,
        autofocus: autofocus,
        child: Icon(icon),
      ),
      _FabType.extended => FloatingActionButton.extended(
        onPressed: onPressed,
        tooltip: tooltip,
        backgroundColor: background,
        foregroundColor: foreground,
        elevation: elevation,
        autofocus: autofocus,
        icon: Icon(icon),
        label: Text(label),
      ),
    };
  }),
  component('PopupMenuButton', (context) {
    final k = context.knobs;
    final enabled = k.boolean(label: 'Enabled', initialValue: true);
    final tooltip = k.string(label: 'Tooltip', initialValue: 'Open menu');
    final icon = iconKnob(context, initial: Icons.more_vert);
    final useIcon = k.boolean(
      label: 'Use icon (vs. text child)',
      initialValue: false,
    );
    final position = optionKnob<PopupMenuPosition>(
      context,
      label: 'Position',
      options: PopupMenuPosition.values,
      initial: PopupMenuPosition.over,
    );
    final elevation = k.double.slider(
      label: 'Elevation',
      initialValue: 8,
      min: 0,
      max: 24,
      divisions: 24,
    );
    final color = k.colorOrNull(label: 'Menu color', defaultToNull: true);
    return PopupMenuButton<String>(
      enabled: enabled,
      tooltip: tooltip,
      position: position,
      elevation: elevation,
      color: color,
      icon: Icon(icon),
      onSelected: (value) => showDemoSnack(context, 'Selected "$value"'),
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'Cut', child: Text('Cut')),
        PopupMenuItem(value: 'Copy', child: Text('Copy')),
        PopupMenuItem(value: 'Paste', child: Text('Paste')),
      ],
      child: useIcon
          ? null
          : const Row(
              mainAxisSize: MainAxisSize.min,
              children: [Text('Open menu'), Icon(Icons.arrow_drop_down)],
            ),
    );
  }),
  component('MenuAnchor', (context) {
    final k = context.knobs;
    final consumeOutsideTap = k.boolean(
      label: 'Consume outside tap',
      initialValue: true,
    );
    final crossAxisUnconstrained = k.boolean(
      label: 'Cross axis unconstrained',
      initialValue: true,
    );
    final offsetX = k.double.slider(
      label: 'Alignment offset X',
      initialValue: 0,
      min: -40,
      max: 40,
      divisions: 40,
    );
    final offsetY = k.double.slider(
      label: 'Alignment offset Y',
      initialValue: 0,
      min: -40,
      max: 40,
      divisions: 40,
    );
    final clip = optionKnob<Clip>(
      context,
      label: 'Clip behavior',
      options: Clip.values,
      initial: Clip.hardEdge,
    );
    return MenuAnchor(
      consumeOutsideTap: consumeOutsideTap,
      crossAxisUnconstrained: crossAxisUnconstrained,
      alignmentOffset: Offset(offsetX, offsetY),
      clipBehavior: clip,
      builder: (context, controller, child) => FilledButton(
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
        child: const Text('Show menu'),
      ),
      menuChildren: [
        MenuItemButton(
          onPressed: () => showDemoSnack(context, 'Profile'),
          child: const Text('Profile'),
        ),
        MenuItemButton(
          onPressed: () => showDemoSnack(context, 'Settings'),
          child: const Text('Settings'),
        ),
        MenuItemButton(
          onPressed: () => showDemoSnack(context, 'Sign out'),
          child: const Text('Sign out'),
        ),
      ],
    );
  }),
  component('SegmentedButton', (context) {
    final k = context.knobs;
    final multiSelection = k.boolean(
      label: 'Multi-selection enabled',
      initialValue: false,
    );
    final emptyAllowed = k.boolean(
      label: 'Empty selection allowed',
      initialValue: false,
    );
    final showSelectedIcon = k.boolean(
      label: 'Show selected icon',
      initialValue: true,
    );
    final direction = optionKnob<Axis>(
      context,
      label: 'Direction',
      options: Axis.values,
      initial: Axis.horizontal,
    );
    final dayLabel = k.string(label: 'Segment 1 label', initialValue: 'Day');
    final weekLabel = k.string(label: 'Segment 2 label', initialValue: 'Week');
    final monthLabel = k.string(
      label: 'Segment 3 label',
      initialValue: 'Month',
    );
    final style = _buttonStyleKnobs(context, withElevation: false);

    return DemoState<Set<String>>(
      initial: const {'day'},
      builder: (context, selected, setSelected) => SegmentedButton<String>(
        multiSelectionEnabled: multiSelection,
        emptySelectionAllowed: emptyAllowed,
        showSelectedIcon: showSelectedIcon,
        direction: direction,
        style: style,
        segments: [
          ButtonSegment(
            value: 'day',
            label: Text(dayLabel),
            icon: const Icon(Icons.calendar_view_day),
          ),
          ButtonSegment(
            value: 'week',
            label: Text(weekLabel),
            icon: const Icon(Icons.calendar_view_week),
          ),
          ButtonSegment(
            value: 'month',
            label: Text(monthLabel),
            icon: const Icon(Icons.calendar_view_month),
          ),
        ],
        selected: selected,
        onSelectionChanged: setSelected,
      ),
    );
  }),
  component('Chip', (context) {
    final k = context.knobs;
    final label = k.string(label: 'Label', initialValue: 'Chip');
    final hasAvatar = k.boolean(label: 'Has avatar', initialValue: true);
    final icon = iconKnob(context, initial: Icons.person);
    final background = k.colorOrNull(label: 'Background', defaultToNull: true);
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 0,
      min: 0,
      max: 12,
      defaultToNull: true,
    );
    return Chip(
      label: Text(label),
      avatar: hasAvatar ? CircleAvatar(child: Icon(icon, size: 18)) : null,
      backgroundColor: background,
      elevation: elevation,
    );
  }),
  component('ActionChip', (context) {
    final k = context.knobs;
    final label = k.string(label: 'Label', initialValue: 'Action');
    final enabled = k.boolean(label: 'Enabled (onPressed)', initialValue: true);
    final hasAvatar = k.boolean(label: 'Has avatar', initialValue: true);
    final icon = iconKnob(context, initial: Icons.settings);
    final background = k.colorOrNull(label: 'Background', defaultToNull: true);
    return ActionChip(
      label: Text(label),
      avatar: hasAvatar ? Icon(icon, size: 18) : null,
      backgroundColor: background,
      onPressed: enabled
          ? () => showDemoSnack(context, 'ActionChip pressed')
          : null,
    );
  }),
  component('FilterChip', (context) {
    final k = context.knobs;
    final label = k.string(label: 'Label', initialValue: 'Filter');
    final selected = k.boolean(label: 'Selected', initialValue: true);
    final showCheckmark = k.boolean(
      label: 'Show checkmark',
      initialValue: true,
    );
    final disabled = k.boolean(
      label: 'Disabled (onSelected: null)',
      initialValue: false,
    );
    final hasAvatar = k.boolean(label: 'Has avatar', initialValue: false);
    final icon = iconKnob(context, initial: Icons.filter_alt);
    final selectedColor = k.colorOrNull(
      label: 'Selected color',
      defaultToNull: true,
    );
    return FilterChip(
      label: Text(label),
      selected: selected,
      showCheckmark: showCheckmark,
      avatar: hasAvatar ? Icon(icon, size: 18) : null,
      selectedColor: selectedColor,
      // A FilterChip is disabled when `onSelected` is null.
      onSelected: disabled
          ? null
          : (value) => showDemoSnack(context, 'FilterChip → $value'),
    );
  }),
  component('InputChip', (context) {
    final k = context.knobs;
    final label = k.string(label: 'Label', initialValue: 'Input');
    final selected = k.boolean(label: 'Selected', initialValue: false);
    final deletable = k.boolean(
      label: 'Deletable (onDeleted)',
      initialValue: true,
    );
    final enabled = k.boolean(label: 'Enabled', initialValue: true);
    final hasAvatar = k.boolean(label: 'Has avatar', initialValue: false);
    final icon = iconKnob(context, initial: Icons.person);
    return InputChip(
      label: Text(label),
      selected: selected,
      isEnabled: enabled,
      avatar: hasAvatar ? Icon(icon, size: 18) : null,
      onSelected: (value) => showDemoSnack(context, 'InputChip → $value'),
      onDeleted: deletable
          ? () => showDemoSnack(context, 'InputChip deleted')
          : null,
    );
  }),
  component('ChoiceChip', (context) {
    final k = context.knobs;
    final label = k.string(label: 'Label', initialValue: 'Choice');
    final selected = k.boolean(label: 'Selected', initialValue: false);
    final hasAvatar = k.boolean(label: 'Has avatar', initialValue: false);
    final icon = iconKnob(context, initial: Icons.check);
    final selectedColor = k.colorOrNull(
      label: 'Selected color',
      defaultToNull: true,
    );
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      avatar: hasAvatar ? Icon(icon, size: 18) : null,
      selectedColor: selectedColor,
      onSelected: (value) => showDemoSnack(context, 'ChoiceChip → $value'),
    );
  }),
]);
