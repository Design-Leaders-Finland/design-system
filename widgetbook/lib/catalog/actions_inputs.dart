import 'package:design_leaders_system/design_leaders_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'common.dart';

// ── Actions ──────────────────────────────────────────────────────────────────
// Buttons, FABs, menus and chips from the Material library.

/// Buttons, floating action buttons, menus and chips.
WidgetbookCategory get actionsCategory => category('Actions', [
  componentVariants('ElevatedButton', {
    'Default': (context) => ElevatedButton(
      onPressed: () => showDemoSnack(context, 'ElevatedButton pressed'),
      child: const Text('Elevated'),
    ),
    'With icon': (context) => ElevatedButton.icon(
      onPressed: () => showDemoSnack(context, 'ElevatedButton.icon pressed'),
      icon: const Icon(Icons.download),
      label: const Text('Download'),
    ),
    'Disabled': (context) =>
        const ElevatedButton(onPressed: null, child: Text('Disabled')),
  }),
  componentVariants('FilledButton', {
    'Default': (context) => FilledButton(
      onPressed: () => showDemoSnack(context, 'FilledButton pressed'),
      child: const Text('Filled'),
    ),
    'Tonal': (context) => FilledButton.tonal(
      onPressed: () => showDemoSnack(context, 'FilledButton.tonal pressed'),
      child: const Text('Tonal'),
    ),
  }),
  component(
    'OutlinedButton',
    (context) => OutlinedButton(
      onPressed: () => showDemoSnack(context, 'OutlinedButton pressed'),
      child: const Text('Outlined'),
    ),
  ),
  component(
    'TextButton',
    (context) => TextButton(
      onPressed: () => showDemoSnack(context, 'TextButton pressed'),
      child: const Text('Text button'),
    ),
  ),
  componentVariants('IconButton', {
    'Default': (context) => IconButton(
      tooltip: 'Favorite',
      onPressed: () => showDemoSnack(context, 'IconButton pressed'),
      icon: const Icon(Icons.favorite_border),
    ),
    'Filled': (context) => IconButton.filled(
      onPressed: () => showDemoSnack(context, 'IconButton.filled pressed'),
      icon: const Icon(Icons.add),
    ),
    'Filled tonal': (context) => IconButton.filledTonal(
      onPressed: () => showDemoSnack(context, 'IconButton.filledTonal pressed'),
      icon: const Icon(Icons.settings),
    ),
    'Outlined': (context) => IconButton.outlined(
      onPressed: () => showDemoSnack(context, 'IconButton.outlined pressed'),
      icon: const Icon(Icons.share),
    ),
    'Toggle': (context) => DemoState<bool>(
      initial: false,
      builder: (context, selected, setSelected) => IconButton.filled(
        isSelected: selected,
        onPressed: () => setSelected(!selected),
        icon: const Icon(Icons.volume_off),
        selectedIcon: const Icon(Icons.volume_up),
      ),
    ),
  }),
  componentVariants('FloatingActionButton', {
    'Default': (context) => FloatingActionButton(
      onPressed: () => showDemoSnack(context, 'FAB pressed'),
      child: const Icon(Icons.add),
    ),
    'Extended': (context) => FloatingActionButton.extended(
      onPressed: () => showDemoSnack(context, 'FAB.extended pressed'),
      icon: const Icon(Icons.edit),
      label: const Text('Compose'),
    ),
    'Small': (context) => FloatingActionButton.small(
      onPressed: () => showDemoSnack(context, 'FAB.small pressed'),
      child: const Icon(Icons.arrow_upward),
    ),
  }),
  component(
    'PopupMenuButton',
    (context) => PopupMenuButton<String>(
      onSelected: (value) => showDemoSnack(context, 'Selected "$value"'),
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'Cut', child: Text('Cut')),
        PopupMenuItem(value: 'Copy', child: Text('Copy')),
        PopupMenuItem(value: 'Paste', child: Text('Paste')),
      ],
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.s3,
          vertical: Spacing.s2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Open menu'), Icon(Icons.arrow_drop_down)],
        ),
      ),
    ),
  ),
  component(
    'MenuAnchor',
    (context) => MenuAnchor(
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
    ),
  ),
  component(
    'SegmentedButton',
    (context) => DemoState<String>(
      initial: 'day',
      builder: (context, value, setValue) => SegmentedButton<String>(
        segments: const [
          ButtonSegment(
            value: 'day',
            label: Text('Day'),
            icon: Icon(Icons.calendar_view_day),
          ),
          ButtonSegment(
            value: 'week',
            label: Text('Week'),
            icon: Icon(Icons.calendar_view_week),
          ),
          ButtonSegment(
            value: 'month',
            label: Text('Month'),
            icon: Icon(Icons.calendar_view_month),
          ),
        ],
        selected: {value},
        onSelectionChanged: (selection) => setValue(selection.first),
      ),
    ),
  ),
  component(
    'Chip',
    (context) => const Chip(
      avatar: CircleAvatar(child: Icon(Icons.face, size: Spacing.s4)),
      label: Text('Chip'),
    ),
  ),
  component(
    'ActionChip',
    (context) => ActionChip(
      avatar: const Icon(Icons.settings),
      label: const Text('Action'),
      onPressed: () => showDemoSnack(context, 'ActionChip pressed'),
    ),
  ),
  component(
    'FilterChip',
    (context) => DemoState<bool>(
      initial: true,
      builder: (context, selected, setSelected) => FilterChip(
        label: const Text('Filter'),
        selected: selected,
        onSelected: setSelected,
      ),
    ),
  ),
  component(
    'InputChip',
    (context) => InputChip(
      label: const Text('Input'),
      onSelected: (_) => showDemoSnack(context, 'InputChip selected'),
      onDeleted: () => showDemoSnack(context, 'InputChip deleted'),
    ),
  ),
  component(
    'ChoiceChip',
    (context) => DemoState<bool>(
      initial: false,
      builder: (context, selected, setSelected) => ChoiceChip(
        label: const Text('Choice'),
        selected: selected,
        onSelected: setSelected,
      ),
    ),
  ),
]);

// ── Selection & input ────────────────────────────────────────────────────────
// Toggles, sliders, dropdowns and text entry.

/// Checkboxes, switches, radios, sliders, dropdowns and text fields.
WidgetbookCategory get inputsCategory => category('Selection & Input', [
  component(
    'Checkbox',
    (context) => DemoState<bool>(
      initial: false,
      builder: (context, value, setValue) =>
          Checkbox(value: value, onChanged: (next) => setValue(next ?? false)),
    ),
  ),
  component(
    'CheckboxListTile',
    (context) => DemoState<bool>(
      initial: true,
      builder: (context, value, setValue) => SizedBox(
        width: 280,
        child: CheckboxListTile(
          value: value,
          onChanged: (next) => setValue(next ?? false),
          title: const Text('Accept terms'),
          subtitle: const Text('You must accept to continue'),
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    ),
  ),
  component(
    'Switch',
    (context) => DemoState<bool>(
      initial: true,
      builder: (context, value, setValue) =>
          Switch(value: value, onChanged: setValue),
    ),
  ),
  component(
    'SwitchListTile',
    (context) => DemoState<bool>(
      initial: false,
      builder: (context, value, setValue) => SizedBox(
        width: 280,
        child: SwitchListTile(
          value: value,
          onChanged: setValue,
          title: const Text('Enable notifications'),
          secondary: const Icon(Icons.notifications),
        ),
      ),
    ),
  ),
  component(
    'Radio',
    (context) => DemoState<String?>(
      initial: 'a',
      builder: (context, value, setValue) => RadioGroup<String>(
        groupValue: value,
        onChanged: setValue,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(value: 'a'),
            Radio<String>(value: 'b'),
            Radio<String>(value: 'c'),
          ],
        ),
      ),
    ),
  ),
  component(
    'RadioListTile',
    (context) => DemoState<String?>(
      initial: 'medium',
      builder: (context, value, setValue) => SizedBox(
        width: 280,
        child: RadioGroup<String>(
          groupValue: value,
          onChanged: setValue,
          child: const Column(
            children: [
              RadioListTile<String>(value: 'small', title: Text('Small')),
              RadioListTile<String>(value: 'medium', title: Text('Medium')),
              RadioListTile<String>(value: 'large', title: Text('Large')),
            ],
          ),
        ),
      ),
    ),
  ),
  component(
    'Slider',
    (context) => DemoState<double>(
      initial: 0.4,
      builder: (context, value, setValue) => SizedBox(
        width: 240,
        child: Slider(
          value: value,
          divisions: 5,
          label: value.toStringAsFixed(1),
          onChanged: setValue,
        ),
      ),
    ),
  ),
  component(
    'RangeSlider',
    (context) => DemoState<RangeValues>(
      initial: const RangeValues(0.2, 0.7),
      builder: (context, values, setValues) => SizedBox(
        width: 260,
        child: RangeSlider(values: values, onChanged: setValues),
      ),
    ),
  ),
  component(
    'DropdownButton',
    (context) => DemoState<String?>(
      initial: 'One',
      builder: (context, value, setValue) => DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: setValue,
          items: const [
            DropdownMenuItem(value: 'One', child: Text('One')),
            DropdownMenuItem(value: 'Two', child: Text('Two')),
            DropdownMenuItem(value: 'Three', child: Text('Three')),
          ],
        ),
      ),
    ),
  ),
  component(
    'DropdownMenu',
    (context) => DemoState<String?>(
      initial: 'green',
      builder: (context, value, setValue) => DropdownMenu<String>(
        initialSelection: value,
        onSelected: setValue,
        label: const Text('Color'),
        dropdownMenuEntries: const [
          DropdownMenuEntry(value: 'red', label: 'Red'),
          DropdownMenuEntry(value: 'green', label: 'Green'),
          DropdownMenuEntry(value: 'blue', label: 'Blue'),
        ],
      ),
    ),
  ),
  component(
    'TextField',
    (context) => const SizedBox(
      width: 260,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Label',
          hintText: 'Enter text',
          helperText: 'Helper text',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    ),
  ),
  component(
    'TextFormField',
    (context) => SizedBox(
      width: 260,
      child: TextFormField(
        initialValue: 'jukka@designleaders.fi',
        decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
        validator: (value) => (value == null || !value.contains('@'))
            ? 'Enter a valid email'
            : null,
      ),
    ),
  ),
  component(
    'Autocomplete',
    (context) => SizedBox(
      width: 260,
      child: Autocomplete<String>(
        optionsBuilder: (filter) =>
            const ['Apple', 'Apricot', 'Banana', 'Cherry', 'Date'].where(
              (option) =>
                  option.toLowerCase().contains(filter.text.toLowerCase()),
            ),
      ),
    ),
  ),
]);
