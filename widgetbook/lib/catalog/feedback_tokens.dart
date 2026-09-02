import 'package:design_leaders_system/design_leaders_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'common.dart';

// ── Feedback & overlays ──────────────────────────────────────────────────────

/// Snackbars, dialogs, sheets, banners and pickers.

/// Overlays are launched from a trigger button; the routes they open inherit the
/// design system theme from the surrounding `MaterialApp` that Widgetbook builds
/// for every use case.
WidgetbookCategory get feedbackCategory => category('Feedback & Overlays', [
  component(
    'SnackBar',
    (context) => FilledButton(
      onPressed: () => showDemoSnack(context, 'Hello from a SnackBar'),
      child: const Text('Show SnackBar'),
    ),
  ),
  component(
    'AlertDialog',
    (context) => FilledButton(
      onPressed: () => showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Discard draft?'),
          content: const Text('This action cannot be undone.'),
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
    ),
  ),
  component(
    'SimpleDialog',
    (context) => FilledButton(
      onPressed: () => showDialog<void>(
        context: context,
        builder: (dialogContext) => SimpleDialog(
          title: const Text('Choose an option'),
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
    ),
  ),
  component(
    'Dialog',
    (context) => FilledButton(
      onPressed: () => showDialog<void>(
        context: context,
        builder: (dialogContext) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.s6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.title('Dialog'),
                const SizedBox(height: Spacing.s2),
                AppText.body('A generic Material dialog surface.'),
                const SizedBox(height: Spacing.s4),
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
    ),
  ),
  component(
    'BottomSheet',
    (context) => FilledButton(
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        builder: (sheetContext) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: Spacing.s2),
              AppText.title('Bottom sheet'),
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
    ),
  ),
  component(
    'MaterialBanner',
    (context) => SizedBox(
      width: 340,
      child: MaterialBanner(
        leading: const Icon(Icons.info_outline),
        content: const Text('You have 3 unread messages'),
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
    ),
  ),
  component(
    'DatePicker',
    (context) => FilledButton(
      onPressed: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null && context.mounted) {
          showDemoSnack(context, 'Picked ${date.toLocal()}'.split(' ').first);
        }
      },
      child: const Text('Pick date'),
    ),
  ),
  component(
    'TimePicker',
    (context) => FilledButton(
      onPressed: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (time != null && context.mounted) {
          showDemoSnack(context, 'Picked ${time.format(context)}');
        }
      },
      child: const Text('Pick time'),
    ),
  ),
  component(
    'CalendarDatePicker',
    (context) => SizedBox(
      width: 328,
      child: CalendarDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        onDateChanged: (date) => showDemoSnack(context, 'Changed to $date'),
      ),
    ),
  ),
]);

// ── Progress ─────────────────────────────────────────────────────────────────

/// Indicators, steppers and refresh affordances.
WidgetbookCategory get progressCategory => category('Progress', [
  componentVariants('CircularProgressIndicator', {
    'Indeterminate': (context) => const CircularProgressIndicator(),
    'Determinate': (context) => const CircularProgressIndicator(value: 0.65),
  }),
  componentVariants('LinearProgressIndicator', {
    'Indeterminate': (context) =>
        const SizedBox(width: 240, child: LinearProgressIndicator()),
    'Determinate': (context) =>
        const SizedBox(width: 240, child: LinearProgressIndicator(value: 0.4)),
  }),
  component(
    'Stepper',
    (context) => DemoState<int>(
      initial: 0,
      builder: (context, step, setStep) => SizedBox(
        width: 360,
        child: Stepper(
          currentStep: step,
          onStepTapped: setStep,
          onStepContinue: step < 2 ? () => setStep(step + 1) : null,
          onStepCancel: step > 0 ? () => setStep(step - 1) : null,
          steps: [
            Step(
              title: const Text('Account'),
              content: const Text('Create your account'),
              isActive: step >= 0,
            ),
            Step(
              title: const Text('Profile'),
              content: const Text('Fill in your profile'),
              isActive: step >= 1,
            ),
            Step(
              title: const Text('Done'),
              content: const Text('All set'),
              isActive: step >= 2,
            ),
          ],
        ),
      ),
    ),
  ),
  component(
    'RefreshIndicator',
    (context) => SizedBox(
      width: 240,
      height: 180,
      child: RefreshIndicator(
        onRefresh: () => Future<void>.delayed(const Duration(seconds: 1)),
        child: ListView(
          children: const [
            ListTile(title: Text('Pull down to refresh')),
            ListTile(title: Text('Item two')),
            ListTile(title: Text('Item three')),
          ],
        ),
      ),
    ),
  ),
]);

// ── Design system ────────────────────────────────────────────────────────────

/// The design system's own widgets and tokens, rendered with the same theme the
/// Material catalog uses — handy for checking the DS components side by side
/// with their Material counterparts.
WidgetbookCategory get designSystemCategory => category('Design System', [
  componentVariants('AppText', {
    'Display': (context) => const AppText.display('Display text'),
    'Heading': (context) => const AppText.heading('Heading text'),
    'Title': (context) => const AppText.title('Title text'),
    'Body': (context) => const AppText.body('Body text'),
    'Label': (context) => const AppText.label('Label text'),
    'Rich / link': (context) => const AppText.rich('Hyperlink text'),
  }),
  componentVariants('SolidButton', {
    'Primary': (context) => SolidButton(
      onPressed: () => showDemoSnack(context, 'SolidButton pressed'),
      child: const Text('Solid'),
    ),
    'Secondary': (context) => SolidButton(
      colorScheme: ButtonColorSheme.secondary,
      onPressed: () => showDemoSnack(context, 'Secondary pressed'),
      child: const Text('Secondary'),
    ),
    'With icon': (context) => SolidButton(
      leftIcon: const Icon(Icons.check, size: Sizing.iconSm),
      onPressed: () {},
      child: const Text('Confirm'),
    ),
    'Loading': (context) => SolidButton(
      isLoading: true,
      onPressed: null,
      child: const Text('Loading'),
    ),
  }),
  component(
    'AppOutlinedButton',
    (context) => AppOutlinedButton(
      onPressed: () => showDemoSnack(context, 'AppOutlinedButton pressed'),
      child: const Text('Outlined'),
    ),
  ),
  component(
    'GhostButton',
    (context) => GhostButton(
      onPressed: () => showDemoSnack(context, 'GhostButton pressed'),
      child: const Text('Ghost'),
    ),
  ),
  component('Spacing', (context) {
    const tokens = <(String, double)>[
      ('s2', Spacing.s2),
      ('s4', Spacing.s4),
      ('s6', Spacing.s6),
      ('s8', Spacing.s8),
      ('s12', Spacing.s12),
      ('s16', Spacing.s16),
    ];
    final color = Theme.of(context).colorScheme.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (label, value) in tokens)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Spacing.s1),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 40, child: Text(label)),
                Container(
                  height: Spacing.s3,
                  width: value,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(AppBorderRadius.xs),
                  ),
                ),
                const SizedBox(width: Spacing.s2),
                Text('${value.toInt()}px'),
              ],
            ),
          ),
      ],
    );
  }),
  component('Sizing', (context) {
    const tokens = <(String, double)>[
      ('iconSm', Sizing.iconSm),
      ('iconMd', Sizing.iconMd),
      ('iconLg', Sizing.iconLg),
      ('iconXl', Sizing.iconXl),
    ];
    final color = Theme.of(context).colorScheme.secondary;
    return Wrap(
      spacing: Spacing.s4,
      runSpacing: Spacing.s4,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        for (final (label, value) in tokens)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: value,
                height: value,
                decoration: BoxDecoration(
                  color: color.withAlpha(60),
                  borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                  border: Border.all(color: color),
                ),
              ),
              const SizedBox(height: Spacing.s1),
              Text(label),
            ],
          ),
      ],
    );
  }),
  component('Colors', (context) {
    const swatches = <(String, Color)>[
      ('primary', AppColors.primary),
      ('secondary', AppColors.secondary),
      ('accent', AppColors.accent),
      ('complementary', AppColors.complementary),
      ('attention', AppColors.attention),
      ('warning', AppColors.warning),
      ('danger', AppColors.danger),
      ('success', AppColors.success),
    ];
    return Wrap(
      spacing: Spacing.s3,
      runSpacing: Spacing.s3,
      children: [
        for (final (name, color) in swatches)
          SizedBox(
            width: 104,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                    border: Border.all(color: Colors.black.withAlpha(20)),
                  ),
                ),
                const SizedBox(height: Spacing.s1),
                Text(name, style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ),
      ],
    );
  }),
]);
