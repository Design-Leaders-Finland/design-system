import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'common.dart';

// ── Feedback & overlays ──────────────────────────────────────────────────────
// Snackbars, dialogs, sheets, banners and pickers. Overlays are launched from a
// trigger button; the knobs configure what that button opens, so every property
// stays reachable. Binary props and two-option enums render as switches.

String _fmtDate(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

/// Snackbars, dialogs, sheets, banners and pickers.
WidgetbookCategory get feedbackCategory => category('Feedback & Overlays', [
  component('SnackBar', (context) {
    final k = context.knobs;
    final message = k.string(
      label: 'Message',
      initialValue: 'Hello from a SnackBar',
    );
    final behavior = optionKnob<SnackBarBehavior>(
      context,
      label: 'Behavior',
      options: SnackBarBehavior.values,
      initial: SnackBarBehavior.floating,
    );
    final duration = k.duration(
      label: 'Duration',
      initialValue: const Duration(seconds: 4),
    );
    final width = k.doubleOrNull.slider(
      label: 'Width (floating only)',
      initialValue: 400,
      min: 200,
      max: 600,
      defaultToNull: true,
    );
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 6,
      min: 0,
      max: 24,
      defaultToNull: true,
    );
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    final dismissDirection = optionKnob<DismissDirection>(
      context,
      label: 'Dismiss direction',
      options: DismissDirection.values,
      initial: DismissDirection.down,
    );
    final radius = k.double.slider(
      label: 'Corner radius',
      initialValue: 8,
      min: 0,
      max: 24,
      divisions: 24,
    );
    final hasAction = k.boolean(label: 'Action', initialValue: true);
    return FilledButton(
      onPressed: () {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
              behavior: behavior,
              duration: duration,
              width: behavior == SnackBarBehavior.floating ? width : null,
              elevation: elevation,
              backgroundColor: backgroundColor,
              dismissDirection: dismissDirection,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
              action: hasAction
                  ? SnackBarAction(
                      label: 'Undo',
                      onPressed: () => showDemoSnack(context, 'Undo pressed'),
                    )
                  : null,
            ),
          );
      },
      child: const Text('Show SnackBar'),
    );
  }),
  component('AlertDialog', (context) {
    final k = context.knobs;
    final title = k.string(label: 'Title', initialValue: 'Discard draft?');
    final content = k.string(
      label: 'Content',
      initialValue: 'This action cannot be undone.',
    );
    final hasIcon = k.boolean(label: 'Icon', initialValue: false);
    final scrollable = k.boolean(label: 'Scrollable', initialValue: false);
    final actionsAlignment = optionKnob<MainAxisAlignment>(
      context,
      label: 'Actions alignment',
      options: MainAxisAlignment.values,
      initial: MainAxisAlignment.end,
    );
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 6,
      min: 0,
      max: 24,
      defaultToNull: true,
    );
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    final shadowColor = k.colorOrNull(
      label: 'Shadow color',
      defaultToNull: true,
    );
    final surfaceTintColor = k.colorOrNull(
      label: 'Surface tint color',
      defaultToNull: true,
    );
    final insetPadding = k.double.slider(
      label: 'Inset padding',
      initialValue: 40,
      min: 0,
      max: 80,
      divisions: 40,
    );
    final radius = k.double.slider(
      label: 'Corner radius',
      initialValue: 28,
      min: 0,
      max: 40,
      divisions: 40,
    );
    final clip = optionKnob<Clip>(
      context,
      label: 'Clip behavior',
      options: Clip.values,
      initial: Clip.none,
    );
    return FilledButton(
      onPressed: () => showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          icon: hasIcon ? const Icon(Icons.warning_amber) : null,
          title: Text(title),
          content: Text(content),
          scrollable: scrollable,
          elevation: elevation,
          backgroundColor: backgroundColor,
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          insetPadding: EdgeInsets.all(insetPadding),
          clipBehavior: clip,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          actionsAlignment: actionsAlignment,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Discard'),
            ),
          ],
        ),
      ),
      child: const Text('Show AlertDialog'),
    );
  }),
  component('SimpleDialog', (context) {
    final k = context.knobs;
    final title = k.string(label: 'Title', initialValue: 'Choose an option');
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 6,
      min: 0,
      max: 24,
      defaultToNull: true,
    );
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    final shadowColor = k.colorOrNull(
      label: 'Shadow color',
      defaultToNull: true,
    );
    final surfaceTintColor = k.colorOrNull(
      label: 'Surface tint color',
      defaultToNull: true,
    );
    final insetPadding = k.double.slider(
      label: 'Inset padding',
      initialValue: 40,
      min: 0,
      max: 80,
      divisions: 40,
    );
    final radius = k.double.slider(
      label: 'Corner radius',
      initialValue: 28,
      min: 0,
      max: 40,
      divisions: 40,
    );
    final clip = optionKnob<Clip>(
      context,
      label: 'Clip behavior',
      options: Clip.values,
      initial: Clip.none,
    );
    return FilledButton(
      onPressed: () => showDialog<void>(
        context: context,
        builder: (dialogContext) => SimpleDialog(
          title: Text(title),
          elevation: elevation,
          backgroundColor: backgroundColor,
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          insetPadding: EdgeInsets.all(insetPadding),
          clipBehavior: clip,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Option A'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Option B'),
            ),
          ],
        ),
      ),
      child: const Text('Show SimpleDialog'),
    );
  }),
  component('Dialog', (context) {
    final k = context.knobs;
    final title = k.string(label: 'Title', initialValue: 'Dialog');
    final body = k.string(
      label: 'Body',
      initialValue: 'A generic Material dialog surface.',
    );
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 6,
      min: 0,
      max: 24,
      defaultToNull: true,
    );
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    final shadowColor = k.colorOrNull(
      label: 'Shadow color',
      defaultToNull: true,
    );
    final surfaceTintColor = k.colorOrNull(
      label: 'Surface tint color',
      defaultToNull: true,
    );
    final insetPadding = k.double.slider(
      label: 'Inset padding',
      initialValue: 40,
      min: 0,
      max: 80,
      divisions: 40,
    );
    final radius = k.double.slider(
      label: 'Corner radius',
      initialValue: 28,
      min: 0,
      max: 40,
      divisions: 40,
    );
    final clip = optionKnob<Clip>(
      context,
      label: 'Clip behavior',
      options: Clip.values,
      initial: Clip.none,
    );
    return FilledButton(
      onPressed: () => showDialog<void>(
        context: context,
        builder: (dialogContext) => Dialog(
          elevation: elevation,
          backgroundColor: backgroundColor,
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          insetPadding: EdgeInsets.all(insetPadding),
          clipBehavior: clip,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(dialogContext).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(body),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }),
  component('BottomSheet', (context) {
    final k = context.knobs;
    final title = k.string(label: 'Title', initialValue: 'Bottom sheet');
    final isScrollControlled = k.boolean(
      label: 'Scroll controlled',
      initialValue: false,
    );
    final isDismissible = k.boolean(label: 'Dismissible', initialValue: true);
    final enableDrag = k.boolean(label: 'Enable drag', initialValue: true);
    final showDragHandle = k.boolean(
      label: 'Show drag handle',
      initialValue: true,
    );
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    final barrierColor = k.colorOrNull(
      label: 'Barrier color',
      defaultToNull: true,
    );
    final clip = optionKnob<Clip>(
      context,
      label: 'Clip behavior',
      options: Clip.values,
      initial: Clip.none,
    );
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 1,
      min: 0,
      max: 24,
      defaultToNull: true,
    );
    final radius = k.double.slider(
      label: 'Corner radius',
      initialValue: 28,
      min: 0,
      max: 40,
      divisions: 40,
    );
    return FilledButton(
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: isScrollControlled,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        showDragHandle: showDragHandle,
        backgroundColor: backgroundColor,
        barrierColor: barrierColor,
        clipBehavior: clip,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
        ),
        builder: (sheetContext) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  title,
                  style: Theme.of(sheetContext).textTheme.titleLarge,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share'),
                onTap: () => Navigator.pop(sheetContext),
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () => Navigator.pop(sheetContext),
              ),
            ],
          ),
        ),
      ),
      child: const Text('Show BottomSheet'),
    );
  }),
  component('MaterialBanner', (context) {
    final k = context.knobs;
    final content = k.string(
      label: 'Content',
      initialValue: 'You have 3 unread messages',
    );
    final hasLeading = k.boolean(label: 'Leading', initialValue: true);
    final leadingIcon = iconKnob(
      context,
      label: 'Leading icon',
      initial: Icons.mail,
    );
    final forceActionsBelow = k.boolean(
      label: 'Force actions below',
      initialValue: false,
    );
    final overflowAlignment = optionKnob<OverflowBarAlignment>(
      context,
      label: 'Action alignment',
      options: OverflowBarAlignment.values,
      initial: OverflowBarAlignment.end,
    );
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 0,
      min: 0,
      max: 16,
      defaultToNull: true,
    );
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    final surfaceTintColor = k.colorOrNull(
      label: 'Surface tint color',
      defaultToNull: true,
    );
    final dividerColor = k.colorOrNull(
      label: 'Divider color',
      defaultToNull: true,
    );
    final shadowColor = k.colorOrNull(
      label: 'Shadow color',
      defaultToNull: true,
    );
    final padding = k.double.slider(
      label: 'Padding',
      initialValue: 16,
      min: 0,
      max: 32,
      divisions: 32,
    );
    return SizedBox(
      width: 340,
      child: MaterialBanner(
        leading: hasLeading ? Icon(leadingIcon) : null,
        content: Text(content),
        forceActionsBelow: forceActionsBelow,
        overflowAlignment: overflowAlignment,
        elevation: elevation,
        backgroundColor: backgroundColor,
        surfaceTintColor: surfaceTintColor,
        dividerColor: dividerColor,
        shadowColor: shadowColor,
        padding: EdgeInsets.all(padding),
        actions: [
          TextButton(
            onPressed: () => showDemoSnack(context, 'Dismissed'),
            child: const Text('Dismiss'),
          ),
          TextButton(
            onPressed: () => showDemoSnack(context, 'Opened'),
            child: const Text('Open'),
          ),
        ],
      ),
    );
  }),
  component('DatePicker', (context) {
    final k = context.knobs;
    final initialDate = k.dateTime(
      label: 'Initial date',
      initialValue: DateTime.now(),
      start: DateTime(2000),
      end: DateTime(2100),
    );
    final entryMode = optionKnob<DatePickerEntryMode>(
      context,
      label: 'Entry mode',
      options: DatePickerEntryMode.values,
      initial: DatePickerEntryMode.calendar,
    );
    final pickerMode = optionKnob<DatePickerMode>(
      context,
      label: 'Picker mode',
      options: DatePickerMode.values,
      initial: DatePickerMode.day,
    );
    final helpText = k.stringOrNull(label: 'Help text', defaultToNull: true);
    final cancelText = k.stringOrNull(
      label: 'Cancel text',
      defaultToNull: true,
    );
    final confirmText = k.stringOrNull(
      label: 'Confirm text',
      defaultToNull: true,
    );
    return FilledButton(
      onPressed: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          initialEntryMode: entryMode,
          initialDatePickerMode: pickerMode,
          helpText: helpText,
          cancelText: cancelText,
          confirmText: confirmText,
        );
        if (date != null && context.mounted) {
          showDemoSnack(context, 'Picked ${_fmtDate(date)}');
        }
      },
      child: const Text('Pick date'),
    );
  }),
  component('TimePicker', (context) {
    final k = context.knobs;
    final hour = k.int.slider(
      label: 'Initial hour',
      initialValue: 12,
      min: 0,
      max: 23,
    );
    final minute = k.int.slider(
      label: 'Initial minute',
      initialValue: 30,
      min: 0,
      max: 59,
    );
    final entryMode = optionKnob<TimePickerEntryMode>(
      context,
      label: 'Entry mode',
      options: TimePickerEntryMode.values,
      initial: TimePickerEntryMode.dial,
    );
    final helpText = k.stringOrNull(label: 'Help text', defaultToNull: true);
    return FilledButton(
      onPressed: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: hour, minute: minute),
          initialEntryMode: entryMode,
          helpText: helpText,
        );
        if (time != null && context.mounted) {
          showDemoSnack(context, 'Picked ${time.format(context)}');
        }
      },
      child: const Text('Pick time'),
    );
  }),
  component('CalendarDatePicker', (context) {
    final k = context.knobs;
    final initialDate = k.dateTime(
      label: 'Initial date',
      initialValue: DateTime.now(),
      start: DateTime(2000),
      end: DateTime(2100),
    );
    final initialCalendarMode = optionKnob<DatePickerMode>(
      context,
      label: 'Calendar mode',
      options: DatePickerMode.values,
      initial: DatePickerMode.day,
    );
    return SizedBox(
      width: 328,
      child: CalendarDatePicker(
        key: ValueKey('${_fmtDate(initialDate)}-$initialCalendarMode'),
        initialDate: initialDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialCalendarMode: initialCalendarMode,
        onDateChanged: (date) =>
            showDemoSnack(context, 'Changed to ${_fmtDate(date)}'),
      ),
    );
  }),
]);
