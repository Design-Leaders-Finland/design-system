import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'common.dart';

// ── Selection & input ────────────────────────────────────────────────────────
// Toggles, sliders, dropdowns and text entry. Values are driven by knobs (the
// panel is the source of truth); `onChanged` reports the interaction via a
// snack bar. Binary props and two-option enums render as switches.

enum _FieldBorder { outline, underline, none }

InputBorder? _borderFor(_FieldBorder value) => switch (value) {
  _FieldBorder.outline => const OutlineInputBorder(),
  _FieldBorder.underline => const UnderlineInputBorder(),
  _FieldBorder.none => InputBorder.none,
};

const Map<String, TextInputType> _keyboardTypes = {
  'text': TextInputType.text,
  'email': TextInputType.emailAddress,
  'number': TextInputType.number,
  'phone': TextInputType.phone,
  'url': TextInputType.url,
  'multiline': TextInputType.multiline,
};

/// Checkboxes, switches, radios, sliders, dropdowns and text fields.
WidgetbookCategory get inputsCategory => category('Selection & Input', [
  component('Checkbox', (context) {
    final k = context.knobs;
    final tristate = k.boolean(label: 'Tristate', initialValue: false);
    final rawValue = k.booleanOrNull(
      label: 'Value',
      initialValue: false,
      defaultToNull: false,
    );
    final isError = k.boolean(label: 'Is error', initialValue: false);
    final autofocus = k.boolean(label: 'Autofocus', initialValue: false);
    final checkColor = k.colorOrNull(label: 'Check color', defaultToNull: true);
    final fillColor = k.colorOrNull(label: 'Fill color', defaultToNull: true);
    return Checkbox(
      value: tristate ? rawValue : (rawValue ?? false),
      tristate: tristate,
      isError: isError,
      autofocus: autofocus,
      checkColor: checkColor,
      fillColor: WidgetStatePropertyAll(fillColor),
      onChanged: (next) => showDemoSnack(context, 'Checkbox → $next'),
    );
  }),
  component('CheckboxListTile', (context) {
    final k = context.knobs;
    final value = k.boolean(label: 'Value', initialValue: true);
    final title = k.string(label: 'Title', initialValue: 'Accept terms');
    final subtitle = k.stringOrNull(label: 'Subtitle', defaultToNull: true);
    final hasSecondary = k.boolean(label: 'Has secondary', initialValue: false);
    final icon = iconKnob(context, initial: Icons.notifications);
    final isThreeLine = k.boolean(label: 'Three line', initialValue: false);
    final dense = k.boolean(label: 'Dense', initialValue: false);
    final selected = k.boolean(label: 'Selected', initialValue: false);
    final controlAffinity = optionKnob<ListTileControlAffinity>(
      context,
      label: 'Control affinity',
      options: ListTileControlAffinity.values,
      initial: ListTileControlAffinity.leading,
    );
    return SizedBox(
      width: 320,
      child: CheckboxListTile(
        value: value,
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle),
        secondary: hasSecondary ? Icon(icon) : null,
        isThreeLine: isThreeLine,
        dense: dense,
        selected: selected,
        controlAffinity: controlAffinity,
        onChanged: (next) => showDemoSnack(context, 'CheckboxListTile → $next'),
      ),
    );
  }),
  component('Switch', (context) {
    final k = context.knobs;
    final value = k.boolean(label: 'Value', initialValue: true);
    final autofocus = k.boolean(label: 'Autofocus', initialValue: false);
    final thumbColor = k.colorOrNull(label: 'Thumb color', defaultToNull: true);
    final trackColor = k.colorOrNull(label: 'Track color', defaultToNull: true);
    return Switch(
      value: value,
      autofocus: autofocus,
      thumbColor: WidgetStatePropertyAll(thumbColor),
      trackColor: WidgetStatePropertyAll(trackColor),
      onChanged: (next) => showDemoSnack(context, 'Switch → $next'),
    );
  }),
  component('SwitchListTile', (context) {
    final k = context.knobs;
    final value = k.boolean(label: 'Value', initialValue: false);
    final title = k.string(
      label: 'Title',
      initialValue: 'Enable notifications',
    );
    final subtitle = k.stringOrNull(label: 'Subtitle', defaultToNull: true);
    final hasSecondary = k.boolean(label: 'Has secondary', initialValue: true);
    final icon = iconKnob(context, initial: Icons.notifications);
    final isThreeLine = k.boolean(label: 'Three line', initialValue: false);
    final dense = k.boolean(label: 'Dense', initialValue: false);
    final selected = k.boolean(label: 'Selected', initialValue: false);
    final controlAffinity = optionKnob<ListTileControlAffinity>(
      context,
      label: 'Control affinity',
      options: ListTileControlAffinity.values,
      initial: ListTileControlAffinity.platform,
    );
    return SizedBox(
      width: 320,
      child: SwitchListTile(
        value: value,
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle),
        secondary: hasSecondary ? Icon(icon) : null,
        isThreeLine: isThreeLine,
        dense: dense,
        selected: selected,
        controlAffinity: controlAffinity,
        onChanged: (next) => showDemoSnack(context, 'SwitchListTile → $next'),
      ),
    );
  }),
  component('Radio', (context) {
    final k = context.knobs;
    final selected = optionKnob<String>(
      context,
      label: 'Selected',
      options: const ['a', 'b', 'c'],
      initial: 'a',
    );
    final toggleable = k.boolean(label: 'Toggleable', initialValue: false);
    final autofocus = k.boolean(label: 'Autofocus', initialValue: false);
    final fillColor = k.colorOrNull(label: 'Fill color', defaultToNull: true);
    Widget radio(String value) => Radio<String>(
      value: value,
      toggleable: toggleable,
      autofocus: autofocus,
      fillColor: WidgetStatePropertyAll(fillColor),
    );
    return RadioGroup<String>(
      groupValue: selected,
      onChanged: (value) => showDemoSnack(context, 'Radio → $value'),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [radio('a'), radio('b'), radio('c')],
      ),
    );
  }),
  component('RadioListTile', (context) {
    final k = context.knobs;
    final selected = optionKnob<String>(
      context,
      label: 'Selected',
      options: const ['small', 'medium', 'large'],
      initial: 'medium',
    );
    final dense = k.boolean(label: 'Dense', initialValue: false);
    final highlightSelected = k.boolean(label: 'Selected', initialValue: false);
    final controlAffinity = optionKnob<ListTileControlAffinity>(
      context,
      label: 'Control affinity',
      options: ListTileControlAffinity.values,
      initial: ListTileControlAffinity.platform,
    );
    Widget tile(String value, String label) => RadioListTile<String>(
      value: value,
      title: Text(label),
      dense: dense,
      selected: highlightSelected,
      controlAffinity: controlAffinity,
    );
    return SizedBox(
      width: 300,
      child: RadioGroup<String>(
        groupValue: selected,
        onChanged: (value) => showDemoSnack(context, 'RadioListTile → $value'),
        child: Column(
          children: [
            tile('small', 'Small'),
            tile('medium', 'Medium'),
            tile('large', 'Large'),
          ],
        ),
      ),
    );
  }),
  component('Slider', (context) {
    final k = context.knobs;
    final min = k.double.input(label: 'Min', initialValue: 0);
    final max = k.double.input(label: 'Max', initialValue: 1);
    final lo = math.min(min, max);
    final hi = math.max(min, max);
    final raw = k.double.slider(
      label: 'Value',
      initialValue: 0.4,
      min: 0,
      max: 1,
      divisions: 100,
      precision: 2,
    );
    final value = raw.clamp(lo, hi).toDouble();
    final divisions = k.int.input(
      label: 'Divisions (0 = none)',
      initialValue: 5,
    );
    final showLabel = k.boolean(label: 'Show label', initialValue: true);
    final activeColor = k.colorOrNull(
      label: 'Active color',
      defaultToNull: true,
    );
    final inactiveColor = k.colorOrNull(
      label: 'Inactive color',
      defaultToNull: true,
    );
    return SizedBox(
      width: 260,
      child: Slider(
        value: value,
        min: lo,
        max: hi,
        divisions: divisions > 0 ? divisions : null,
        label: showLabel ? value.toStringAsFixed(2) : null,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        onChanged: (next) =>
            showDemoSnack(context, 'Slider → ${next.toStringAsFixed(2)}'),
      ),
    );
  }),
  component('RangeSlider', (context) {
    final k = context.knobs;
    final startRaw = k.double.slider(
      label: 'Start',
      initialValue: 0.2,
      min: 0,
      max: 1,
      divisions: 100,
      precision: 2,
    );
    final endRaw = k.double.slider(
      label: 'End',
      initialValue: 0.7,
      min: 0,
      max: 1,
      divisions: 100,
      precision: 2,
    );
    final start = math.min(startRaw, endRaw);
    final end = math.max(startRaw, endRaw);
    final divisions = k.int.input(
      label: 'Divisions (0 = none)',
      initialValue: 0,
    );
    final showLabels = k.boolean(label: 'Show labels', initialValue: false);
    final activeColor = k.colorOrNull(
      label: 'Active color',
      defaultToNull: true,
    );
    return SizedBox(
      width: 280,
      child: RangeSlider(
        values: RangeValues(start, end),
        divisions: divisions > 0 ? divisions : null,
        labels: showLabels
            ? RangeLabels(start.toStringAsFixed(2), end.toStringAsFixed(2))
            : null,
        activeColor: activeColor,
        onChanged: (values) => showDemoSnack(
          context,
          'Range → ${values.start.toStringAsFixed(2)}..${values.end.toStringAsFixed(2)}',
        ),
      ),
    );
  }),
  component('DropdownButton', (context) {
    final k = context.knobs;
    final value = optionKnob<String>(
      context,
      label: 'Value',
      options: const ['One', 'Two', 'Three'],
      initial: 'One',
    );
    final isDense = k.boolean(label: 'Dense', initialValue: false);
    final isExpanded = k.boolean(label: 'Expanded', initialValue: false);
    final autofocus = k.boolean(label: 'Autofocus', initialValue: false);
    final iconSize = k.double.slider(
      label: 'Icon size',
      initialValue: 24,
      min: 12,
      max: 48,
      divisions: 36,
    );
    final elevation = k.int.slider(
      label: 'Elevation',
      initialValue: 8,
      min: 0,
      max: 24,
    );
    final dropdownColor = k.colorOrNull(
      label: 'Dropdown color',
      defaultToNull: true,
    );
    final radius = k.double.slider(
      label: 'Border radius',
      initialValue: 4,
      min: 0,
      max: 24,
      divisions: 24,
    );
    return DropdownButton<String>(
      value: value,
      isDense: isDense,
      isExpanded: isExpanded,
      autofocus: autofocus,
      iconSize: iconSize,
      elevation: elevation,
      dropdownColor: dropdownColor,
      borderRadius: BorderRadius.circular(radius),
      onChanged: (next) => showDemoSnack(context, 'DropdownButton → $next'),
      items: const [
        DropdownMenuItem(value: 'One', child: Text('One')),
        DropdownMenuItem(value: 'Two', child: Text('Two')),
        DropdownMenuItem(value: 'Three', child: Text('Three')),
      ],
    );
  }),
  component('DropdownMenu', (context) {
    final k = context.knobs;
    final initial = optionKnob<String>(
      context,
      label: 'Initial selection',
      options: const ['red', 'green', 'blue'],
      initial: 'green',
    );
    final label = k.stringOrNull(label: 'Label', initialValue: 'Color');
    final hintText = k.stringOrNull(label: 'Hint text', defaultToNull: true);
    final helperText = k.stringOrNull(
      label: 'Helper text',
      defaultToNull: true,
    );
    final enableFilter = k.boolean(label: 'Enable filter', initialValue: false);
    final enableSearch = k.boolean(label: 'Enable search', initialValue: true);
    final hasLeadingIcon = k.boolean(
      label: 'Leading icon',
      initialValue: false,
    );
    final hasTrailingIcon = k.boolean(
      label: 'Trailing icon',
      initialValue: true,
    );
    final width = k.double.slider(
      label: 'Width',
      initialValue: 200,
      min: 120,
      max: 320,
      divisions: 40,
    );
    return DropdownMenu<String>(
      key: ValueKey(initial),
      initialSelection: initial,
      label: label == null ? null : Text(label),
      hintText: hintText,
      helperText: helperText,
      enableFilter: enableFilter,
      enableSearch: enableSearch,
      leadingIcon: hasLeadingIcon ? const Icon(Icons.palette) : null,
      trailingIcon: hasTrailingIcon ? const Icon(Icons.arrow_drop_down) : null,
      width: width,
      onSelected: (value) => showDemoSnack(context, 'DropdownMenu → $value'),
      dropdownMenuEntries: const [
        DropdownMenuEntry(value: 'red', label: 'Red'),
        DropdownMenuEntry(value: 'green', label: 'Green'),
        DropdownMenuEntry(value: 'blue', label: 'Blue'),
      ],
    );
  }),
  component('TextField', (context) {
    final k = context.knobs;
    final labelText = k.stringOrNull(label: 'Label', initialValue: 'Label');
    final hintText = k.stringOrNull(label: 'Hint', initialValue: 'Enter text');
    final helperText = k.stringOrNull(label: 'Helper', initialValue: 'Helper');
    final errorText = k.stringOrNull(label: 'Error', defaultToNull: true);
    final enabled = k.boolean(label: 'Enabled', initialValue: true);
    final readOnly = k.boolean(label: 'Read only', initialValue: false);
    final obscureText = k.boolean(label: 'Obscure text', initialValue: false);
    final autofocus = k.boolean(label: 'Autofocus', initialValue: false);
    final filled = k.boolean(label: 'Filled', initialValue: false);
    final fillColor = k.colorOrNull(label: 'Fill color', defaultToNull: true);
    final hasPrefix = k.boolean(label: 'Prefix icon', initialValue: true);
    final prefixIcon = iconKnob(
      context,
      label: 'Prefix icon data',
      initial: Icons.search,
    );
    final hasSuffix = k.boolean(label: 'Suffix icon', initialValue: false);
    final suffixIcon = iconKnob(
      context,
      label: 'Suffix icon data',
      initial: Icons.close,
    );
    final border = optionKnob<_FieldBorder>(
      context,
      label: 'Border',
      options: _FieldBorder.values,
      initial: _FieldBorder.outline,
    );
    final textAlign = optionKnob<TextAlign>(
      context,
      label: 'Text align',
      options: TextAlign.values,
      initial: TextAlign.start,
    );
    final maxLength = k.intOrNull.input(
      label: 'Max length (null = none)',
      defaultToNull: true,
    );
    final maxLines = k.int.input(label: 'Max lines', initialValue: 1);
    return SizedBox(
      width: 280,
      child: TextField(
        enabled: enabled,
        readOnly: readOnly,
        obscureText: obscureText,
        autofocus: autofocus,
        textAlign: textAlign,
        maxLength: maxLength,
        maxLines: obscureText ? 1 : maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
          errorText: errorText,
          filled: filled,
          fillColor: fillColor,
          border: _borderFor(border),
          prefixIcon: hasPrefix ? Icon(prefixIcon) : null,
          suffixIcon: hasSuffix ? Icon(suffixIcon) : null,
        ),
        onChanged: (value) => showDemoSnack(context, 'TextField → "$value"'),
      ),
    );
  }),
  component('TextFormField', (context) {
    final k = context.knobs;
    final initialValue = k.string(
      label: 'Initial value',
      initialValue: 'jukka@designleaders.fi',
    );
    final labelText = k.stringOrNull(label: 'Label', initialValue: 'Email');
    final helperText = k.stringOrNull(label: 'Helper', defaultToNull: true);
    final enabled = k.boolean(label: 'Enabled', initialValue: true);
    final readOnly = k.boolean(label: 'Read only', initialValue: false);
    final obscureText = k.boolean(label: 'Obscure text', initialValue: false);
    final autofocus = k.boolean(label: 'Autofocus', initialValue: false);
    final validate = k.boolean(
      label: 'Validate (requires @)',
      initialValue: true,
    );
    final keyboardType = k.object.dropdown<TextInputType>(
      label: 'Keyboard type',
      options: _keyboardTypes.values.toList(),
      initialOption: TextInputType.emailAddress,
      labelBuilder: (type) =>
          _keyboardTypes.entries.firstWhere((e) => e.value == type).key,
    );
    final border = optionKnob<_FieldBorder>(
      context,
      label: 'Border',
      options: _FieldBorder.values,
      initial: _FieldBorder.outline,
    );
    final maxLength = k.intOrNull.input(
      label: 'Max length (null = none)',
      defaultToNull: true,
    );
    return SizedBox(
      width: 280,
      child: TextFormField(
        key: ValueKey(initialValue),
        initialValue: initialValue,
        enabled: enabled,
        readOnly: readOnly,
        obscureText: obscureText,
        autofocus: autofocus,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLines: obscureText ? 1 : null,
        decoration: InputDecoration(
          labelText: labelText,
          helperText: helperText,
          border: _borderFor(border),
        ),
        validator: validate
            ? (value) => (value == null || !value.contains('@'))
                  ? 'Enter a valid email'
                  : null
            : null,
      ),
    );
  }),
  component('Autocomplete', (context) {
    final k = context.knobs;
    final openDirection = optionKnob<OptionsViewOpenDirection>(
      context,
      label: 'Open direction',
      options: OptionsViewOpenDirection.values,
      initial: OptionsViewOpenDirection.down,
    );
    final options = k.iterable.segmented<String>(
      label: 'Options',
      options: const ['Apple', 'Apricot', 'Banana', 'Cherry', 'Date'],
      initialOption: const ['Apple', 'Apricot', 'Banana', 'Cherry', 'Date'],
      emptySelectionAllowed: false,
    );
    return SizedBox(
      width: 280,
      child: Autocomplete<String>(
        optionsViewOpenDirection: openDirection,
        optionsBuilder: (filter) => options.where(
          (option) => option.toLowerCase().contains(filter.text.toLowerCase()),
        ),
        onSelected: (value) => showDemoSnack(context, 'Autocomplete → $value'),
      ),
    );
  }),
]);
