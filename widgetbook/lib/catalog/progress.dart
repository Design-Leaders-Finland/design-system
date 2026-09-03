import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'common.dart';

// ── Progress ─────────────────────────────────────────────────────────────────
// Indicators, steppers and refresh affordances, each with its properties
// exposed as knobs. Binary props and two-option enums render as switches.

/// Indicators, steppers and refresh affordances.
WidgetbookCategory get progressCategory => category('Progress', [
  component('CircularProgressIndicator', (context) {
    final k = context.knobs;
    final determinate = k.boolean(label: 'Determinate', initialValue: false);
    final value = k.double.slider(
      label: 'Value',
      initialValue: 0.65,
      min: 0,
      max: 1,
      divisions: 100,
      precision: 2,
    );
    final size = k.double.slider(
      label: 'Size',
      initialValue: 36,
      min: 12,
      max: 96,
      divisions: 42,
    );
    final strokeWidth = k.doubleOrNull.slider(
      label: 'Stroke width',
      initialValue: 4,
      min: 1,
      max: 16,
      defaultToNull: true,
    );
    final strokeAlign = k.doubleOrNull.slider(
      label: 'Stroke align',
      initialValue: 4,
      min: 0,
      max: 16,
      defaultToNull: true,
    );
    final strokeCap = optionKnob<StrokeCap>(
      context,
      label: 'Stroke cap',
      options: StrokeCap.values,
      initial: StrokeCap.round,
    );
    final trackGap = k.doubleOrNull.slider(
      label: 'Track gap',
      initialValue: 4,
      min: 0,
      max: 12,
      defaultToNull: true,
    );
    final color = k.colorOrNull(label: 'Color', defaultToNull: true);
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        value: determinate ? value : null,
        strokeWidth: strokeWidth,
        strokeAlign: strokeAlign,
        strokeCap: strokeCap,
        trackGap: trackGap,
        color: color,
        backgroundColor: backgroundColor,
      ),
    );
  }),
  component('LinearProgressIndicator', (context) {
    final k = context.knobs;
    final determinate = k.boolean(label: 'Determinate', initialValue: false);
    final value = k.double.slider(
      label: 'Value',
      initialValue: 0.4,
      min: 0,
      max: 1,
      divisions: 100,
      precision: 2,
    );
    final width = k.double.slider(
      label: 'Width',
      initialValue: 240,
      min: 120,
      max: 360,
      divisions: 48,
    );
    final minHeight = k.doubleOrNull.slider(
      label: 'Min height',
      initialValue: 8,
      min: 1,
      max: 24,
      defaultToNull: true,
    );
    final borderRadius = k.double.slider(
      label: 'Border radius',
      initialValue: 4,
      min: 0,
      max: 16,
      divisions: 16,
    );
    final trackGap = k.doubleOrNull.slider(
      label: 'Track gap',
      initialValue: 4,
      min: 0,
      max: 12,
      defaultToNull: true,
    );
    final color = k.colorOrNull(label: 'Color', defaultToNull: true);
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    final stopIndicatorColor = k.colorOrNull(
      label: 'Stop indicator color',
      defaultToNull: true,
    );
    return SizedBox(
      width: width,
      child: LinearProgressIndicator(
        value: determinate ? value : null,
        minHeight: minHeight,
        borderRadius: BorderRadius.circular(borderRadius),
        trackGap: trackGap,
        color: color,
        backgroundColor: backgroundColor,
        stopIndicatorColor: stopIndicatorColor,
      ),
    );
  }),
  component('Stepper', (context) {
    final k = context.knobs;
    final type = optionKnob<StepperType>(
      context,
      label: 'Type',
      options: StepperType.values,
      initial: StepperType.vertical,
    );
    // stepIconHeight/Width must both be null, or both set and equal, within
    // [24, 80]. One knob feeds both.
    final iconSize = k.doubleOrNull.slider(
      label: 'Step icon size',
      initialValue: 24,
      min: 24,
      max: 80,
      defaultToNull: true,
    );
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 2,
      min: 0,
      max: 16,
      defaultToNull: true,
    );
    final connectorColor = k.colorOrNull(
      label: 'Connector color',
      defaultToNull: true,
    );
    final connectorThickness = k.doubleOrNull.slider(
      label: 'Connector thickness',
      initialValue: 2,
      min: 1,
      max: 8,
      defaultToNull: true,
    );
    final margin = k.doubleOrNull.slider(
      label: 'Step margin',
      initialValue: 0,
      min: 0,
      max: 24,
      defaultToNull: true,
    );
    final clip = optionKnob<Clip>(
      context,
      label: 'Clip behavior',
      options: Clip.values,
      initial: Clip.none,
    );
    return DemoState<int>(
      initial: 0,
      builder: (context, step, setStep) => SizedBox(
        width: 360,
        child: Stepper(
          type: type,
          currentStep: step,
          onStepTapped: setStep,
          onStepContinue: step < 2 ? () => setStep(step + 1) : null,
          onStepCancel: step > 0 ? () => setStep(step - 1) : null,
          elevation: elevation,
          connectorColor: connectorColor == null
              ? null
              : WidgetStatePropertyAll<Color>(connectorColor),
          connectorThickness: connectorThickness,
          stepIconHeight: iconSize,
          stepIconWidth: iconSize,
          margin: margin == null ? null : EdgeInsets.all(margin),
          clipBehavior: clip,
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
    );
  }),
  component('RefreshIndicator', (context) {
    final k = context.knobs;
    final triggerMode = optionKnob<RefreshIndicatorTriggerMode>(
      context,
      label: 'Trigger mode',
      options: RefreshIndicatorTriggerMode.values,
      initial: RefreshIndicatorTriggerMode.onEdge,
    );
    final displacement = k.double.slider(
      label: 'Displacement',
      initialValue: 40,
      min: 0,
      max: 100,
      divisions: 50,
    );
    final edgeOffset = k.double.slider(
      label: 'Edge offset',
      initialValue: 0,
      min: 0,
      max: 100,
      divisions: 50,
    );
    final strokeWidth = k.double.slider(
      label: 'Stroke width',
      initialValue: 2.5,
      min: 1,
      max: 8,
      divisions: 14,
      precision: 1,
    );
    final elevation = k.double.slider(
      label: 'Elevation',
      initialValue: 2,
      min: 0,
      max: 16,
      divisions: 16,
    );
    final delay = k.int.slider(
      label: 'Refresh delay (ms)',
      initialValue: 1000,
      min: 0,
      max: 3000,
      divisions: 6,
    );
    final color = k.colorOrNull(label: 'Color', defaultToNull: true);
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    return SizedBox(
      width: 240,
      height: 180,
      child: RefreshIndicator(
        onRefresh: () => Future<void>.delayed(Duration(milliseconds: delay)),
        triggerMode: triggerMode,
        displacement: displacement,
        edgeOffset: edgeOffset,
        strokeWidth: strokeWidth,
        elevation: elevation,
        color: color,
        backgroundColor: backgroundColor,
        child: ListView(
          children: const [
            ListTile(title: Text('Pull down to refresh')),
            ListTile(title: Text('Item two')),
            ListTile(title: Text('Item three')),
          ],
        ),
      ),
    );
  }),
]);
