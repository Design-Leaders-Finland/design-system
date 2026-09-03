import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'common.dart';

// ── Display & data ───────────────────────────────────────────────────────────
// Cards, lists, tables, avatars, badges and other content widgets, each with
// its properties exposed as knobs.

enum _CardVariant { standard, filled, outlined }

enum _BadgeType { dot, count, label }

enum _AvatarContent { icon, text, image }

enum _SplashFactory { ripple, splash, sparkle, none }

InteractiveInkFeatureFactory _splashFactoryFor(_SplashFactory value) =>
    switch (value) {
      _SplashFactory.ripple => InkRipple.splashFactory,
      _SplashFactory.splash => InkSplash.splashFactory,
      _SplashFactory.sparkle => InkSparkle.splashFactory,
      _SplashFactory.none => NoSplash.splashFactory,
    };

/// Cards, lists, tables, avatars, badges and other content widgets.
WidgetbookCategory get displayCategory => category('Display & Data', [
  component('Card', (context) {
    final k = context.knobs;
    final variant = optionKnob<_CardVariant>(
      context,
      label: 'Variant',
      options: _CardVariant.values,
      initial: _CardVariant.standard,
    );
    final title = k.string(label: 'Title', initialValue: 'Card title');
    final subtitle = k.stringOrNull(
      label: 'Subtitle',
      initialValue: 'Supporting text',
    );
    final hasTrailing = k.boolean(label: 'Trailing icon', initialValue: true);
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 1,
      min: 0,
      max: 16,
      defaultToNull: true,
    );
    final color = k.colorOrNull(label: 'Color', defaultToNull: true);
    final shadowColor = k.colorOrNull(
      label: 'Shadow color',
      defaultToNull: true,
    );
    final surfaceTintColor = k.colorOrNull(
      label: 'Surface tint color',
      defaultToNull: true,
    );
    final margin = k.double.slider(
      label: 'Margin',
      initialValue: 4,
      min: 0,
      max: 24,
      divisions: 24,
    );
    final radius = k.double.slider(
      label: 'Corner radius',
      initialValue: 12,
      min: 0,
      max: 32,
      divisions: 32,
    );
    final clip = optionKnob<Clip>(
      context,
      label: 'Clip behavior',
      options: Clip.values,
      initial: Clip.none,
    );
    final borderOnForeground = k.boolean(
      label: 'Border on foreground',
      initialValue: true,
    );

    final child = ListTile(
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
      trailing: hasTrailing ? const Icon(Icons.chevron_right) : null,
    );
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
    Widget card(Widget? child) => switch (variant) {
      _CardVariant.standard => Card(
        elevation: elevation,
        color: color,
        shadowColor: shadowColor,
        surfaceTintColor: surfaceTintColor,
        margin: EdgeInsets.all(margin),
        clipBehavior: clip,
        shape: shape,
        borderOnForeground: borderOnForeground,
        child: child,
      ),
      _CardVariant.filled => Card.filled(
        elevation: elevation,
        color: color,
        shadowColor: shadowColor,
        surfaceTintColor: surfaceTintColor,
        margin: EdgeInsets.all(margin),
        clipBehavior: clip,
        shape: shape,
        borderOnForeground: borderOnForeground,
        child: child,
      ),
      _CardVariant.outlined => Card.outlined(
        elevation: elevation,
        color: color,
        shadowColor: shadowColor,
        surfaceTintColor: surfaceTintColor,
        margin: EdgeInsets.all(margin),
        clipBehavior: clip,
        shape: shape,
        borderOnForeground: borderOnForeground,
        child: child,
      ),
    };
    return SizedBox(width: 260, child: card(child));
  }),
  component('ListTile', (context) {
    final k = context.knobs;
    final title = k.string(label: 'Title', initialValue: 'Title');
    final subtitle = k.stringOrNull(
      label: 'Subtitle',
      initialValue: 'Subtitle',
    );
    final hasLeading = k.boolean(label: 'Leading', initialValue: true);
    final leadingIcon = iconKnob(
      context,
      label: 'Leading icon',
      initial: Icons.album,
    );
    final hasTrailing = k.boolean(label: 'Trailing', initialValue: true);
    final trailingIcon = iconKnob(
      context,
      label: 'Trailing icon',
      initial: Icons.more_vert,
    );
    final isThreeLine = k.boolean(label: 'Three line', initialValue: false);
    final dense = k.booleanOrNull(label: 'Dense', defaultToNull: true);
    final selected = k.boolean(label: 'Selected', initialValue: false);
    final enabled = k.boolean(label: 'Enabled', initialValue: true);
    final style = optionKnob<ListTileStyle>(
      context,
      label: 'Style',
      options: ListTileStyle.values,
      initial: ListTileStyle.list,
    );
    final titleAlignment = optionKnob<ListTileTitleAlignment>(
      context,
      label: 'Title alignment',
      options: ListTileTitleAlignment.values,
      initial: ListTileTitleAlignment.threeLine,
    );
    final tileColor = k.colorOrNull(label: 'Tile color', defaultToNull: true);
    final selectedTileColor = k.colorOrNull(
      label: 'Selected tile color',
      defaultToNull: true,
    );
    final contentPadding = k.double.slider(
      label: 'Content padding',
      initialValue: 16,
      min: 0,
      max: 40,
      divisions: 40,
    );
    return SizedBox(
      width: 320,
      child: ListTile(
        leading: hasLeading ? Icon(leadingIcon) : null,
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle),
        trailing: hasTrailing ? Icon(trailingIcon) : null,
        isThreeLine: isThreeLine,
        dense: dense,
        selected: selected,
        enabled: enabled,
        style: style,
        titleAlignment: titleAlignment,
        tileColor: tileColor,
        selectedTileColor: selectedTileColor,
        contentPadding: EdgeInsets.symmetric(horizontal: contentPadding),
        onTap: enabled ? () => showDemoSnack(context, 'ListTile tapped') : null,
      ),
    );
  }),
  component('ExpansionTile', (context) {
    final k = context.knobs;
    final title = k.string(label: 'Title', initialValue: 'Expansion tile');
    final subtitle = k.stringOrNull(
      label: 'Subtitle',
      initialValue: 'Tap to expand',
    );
    final hasLeading = k.boolean(label: 'Leading', initialValue: false);
    final leadingIcon = iconKnob(
      context,
      label: 'Leading icon',
      initial: Icons.expand,
    );
    final initiallyExpanded = k.boolean(
      label: 'Initially expanded',
      initialValue: false,
    );
    final maintainState = k.boolean(
      label: 'Maintain state',
      initialValue: false,
    );
    final showTrailingIcon = k.boolean(
      label: 'Show trailing icon',
      initialValue: true,
    );
    final dense = k.booleanOrNull(label: 'Dense', defaultToNull: true);
    final enableFeedback = k.boolean(
      label: 'Enable feedback',
      initialValue: true,
    );
    final tilePadding = k.double.slider(
      label: 'Tile padding',
      initialValue: 8,
      min: 0,
      max: 32,
      divisions: 32,
    );
    final childrenPadding = k.double.slider(
      label: 'Children padding',
      initialValue: 8,
      min: 0,
      max: 32,
      divisions: 32,
    );
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    final collapsedBackgroundColor = k.colorOrNull(
      label: 'Collapsed background',
      defaultToNull: true,
    );
    final clip = optionKnob<Clip>(
      context,
      label: 'Clip behavior',
      options: Clip.values,
      initial: Clip.none,
    );
    return SizedBox(
      width: 320,
      child: ExpansionTile(
        key: ValueKey('exp-$initiallyExpanded'),
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle),
        leading: hasLeading ? Icon(leadingIcon) : null,
        initiallyExpanded: initiallyExpanded,
        maintainState: maintainState,
        showTrailingIcon: showTrailingIcon,
        dense: dense,
        enableFeedback: enableFeedback,
        tilePadding: EdgeInsets.symmetric(horizontal: tilePadding),
        childrenPadding: EdgeInsets.all(childrenPadding),
        backgroundColor: backgroundColor,
        collapsedBackgroundColor: collapsedBackgroundColor,
        clipBehavior: clip,
        onExpansionChanged: (value) =>
            showDemoSnack(context, 'Expanded → $value'),
        children: const [
          ListTile(title: Text('Child one')),
          ListTile(title: Text('Child two')),
        ],
      ),
    );
  }),
  component('Divider', (context) {
    final k = context.knobs;
    final height = k.double.slider(
      label: 'Height',
      initialValue: 16,
      min: 0,
      max: 48,
      divisions: 48,
    );
    final thickness = k.double.slider(
      label: 'Thickness',
      initialValue: 1,
      min: 0,
      max: 8,
      divisions: 16,
      precision: 1,
    );
    final color = k.colorOrNull(label: 'Color', defaultToNull: true);
    final indent = k.double.slider(
      label: 'Indent',
      initialValue: 0,
      min: 0,
      max: 48,
      divisions: 48,
    );
    final endIndent = k.double.slider(
      label: 'End indent',
      initialValue: 0,
      min: 0,
      max: 48,
      divisions: 48,
    );
    return SizedBox(
      width: 260,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Above'),
          Divider(
            height: height,
            thickness: thickness,
            color: color,
            indent: indent,
            endIndent: endIndent,
          ),
          const Text('Below'),
        ],
      ),
    );
  }),
  component('VerticalDivider', (context) {
    final k = context.knobs;
    final width = k.double.slider(
      label: 'Width',
      initialValue: 20,
      min: 0,
      max: 48,
      divisions: 48,
    );
    final thickness = k.double.slider(
      label: 'Thickness',
      initialValue: 1,
      min: 0,
      max: 8,
      divisions: 16,
      precision: 1,
    );
    final color = k.colorOrNull(label: 'Color', defaultToNull: true);
    final indent = k.double.slider(
      label: 'Indent',
      initialValue: 0,
      min: 0,
      max: 32,
      divisions: 32,
    );
    final endIndent = k.double.slider(
      label: 'End indent',
      initialValue: 0,
      min: 0,
      max: 32,
      divisions: 32,
    );
    return SizedBox(
      width: 220,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Left'),
          VerticalDivider(
            width: width,
            thickness: thickness,
            color: color,
            indent: indent,
            endIndent: endIndent,
          ),
          const Text('Right'),
        ],
      ),
    );
  }),
  component('Icon', (context) {
    final k = context.knobs;
    final icon = iconKnob(context, initial: Icons.star);
    final size = k.double.slider(
      label: 'Size',
      initialValue: 32,
      min: 8,
      max: 96,
      divisions: 88,
    );
    final color = k.colorOrNull(label: 'Color', defaultToNull: true);
    final fill = k.double.slider(
      label: 'Fill',
      initialValue: 0,
      min: 0,
      max: 1,
      divisions: 10,
      precision: 1,
    );
    final weight = k.double.slider(
      label: 'Weight',
      initialValue: 400,
      min: 100,
      max: 900,
      divisions: 16,
    );
    final grade = k.double.slider(
      label: 'Grade',
      initialValue: 0,
      min: -50,
      max: 200,
      divisions: 25,
    );
    final opticalSize = k.double.slider(
      label: 'Optical size',
      initialValue: 24,
      min: 8,
      max: 64,
      divisions: 56,
    );
    final applyTextScaling = k.boolean(
      label: 'Apply text scaling',
      initialValue: false,
    );
    final semanticLabel = k.stringOrNull(
      label: 'Semantic label',
      defaultToNull: true,
    );
    return Icon(
      icon,
      size: size,
      color: color,
      fill: fill,
      weight: weight,
      grade: grade,
      opticalSize: opticalSize,
      applyTextScaling: applyTextScaling,
      semanticLabel: semanticLabel,
    );
  }),
  component('CircleAvatar', (context) {
    final k = context.knobs;
    final content = optionKnob<_AvatarContent>(
      context,
      label: 'Content',
      options: _AvatarContent.values,
      initial: _AvatarContent.icon,
    );
    final icon = iconKnob(context, initial: Icons.person);
    final text = k.string(label: 'Text', initialValue: 'DL');
    final radius = k.doubleOrNull.slider(
      label: 'Radius',
      initialValue: 24,
      min: 8,
      max: 64,
      defaultToNull: true,
    );
    final minRadius = k.doubleOrNull.slider(
      label: 'Min radius',
      initialValue: 16,
      min: 0,
      max: 64,
      defaultToNull: true,
    );
    final maxRadius = k.doubleOrNull.slider(
      label: 'Max radius',
      initialValue: 48,
      min: 0,
      max: 96,
      defaultToNull: true,
    );
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    final foregroundColor = k.colorOrNull(
      label: 'Foreground color',
      defaultToNull: true,
    );
    final child = switch (content) {
      _AvatarContent.icon => Icon(icon),
      _AvatarContent.text => Text(text),
      _AvatarContent.image => null,
    };
    return CircleAvatar(
      radius: radius,
      minRadius: minRadius,
      maxRadius: maxRadius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      backgroundImage: content == _AvatarContent.image
          ? const NetworkImage('https://picsum.photos/seed/avatar/96')
          : null,
      child: child,
    );
  }),
  component('Badge', (context) {
    final k = context.knobs;
    final type = optionKnob<_BadgeType>(
      context,
      label: 'Type',
      options: _BadgeType.values,
      initial: _BadgeType.count,
    );
    final count = k.int.slider(
      label: 'Count',
      initialValue: 3,
      min: 0,
      max: 999,
    );
    final label = k.string(label: 'Label', initialValue: '99+');
    final isLabelVisible = k.boolean(
      label: 'Label visible',
      initialValue: true,
    );
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    final textColor = k.colorOrNull(label: 'Text color', defaultToNull: true);
    final offsetX = k.double.slider(
      label: 'Offset X',
      initialValue: 0,
      min: -20,
      max: 20,
      divisions: 40,
    );
    final offsetY = k.double.slider(
      label: 'Offset Y',
      initialValue: 0,
      min: -20,
      max: 20,
      divisions: 40,
    );
    final icon = iconKnob(
      context,
      label: 'Child icon',
      initial: Icons.notifications,
    );
    final child = Icon(icon, size: 32);
    return switch (type) {
      _BadgeType.dot => Badge(
        isLabelVisible: isLabelVisible,
        backgroundColor: backgroundColor,
        textColor: textColor,
        offset: Offset(offsetX, offsetY),
        child: child,
      ),
      _BadgeType.count => Badge.count(
        count: count,
        isLabelVisible: isLabelVisible,
        backgroundColor: backgroundColor,
        textColor: textColor,
        offset: Offset(offsetX, offsetY),
        child: child,
      ),
      _BadgeType.label => Badge(
        label: Text(label),
        isLabelVisible: isLabelVisible,
        backgroundColor: backgroundColor,
        textColor: textColor,
        offset: Offset(offsetX, offsetY),
        child: child,
      ),
    };
  }),
  component('Tooltip', (context) {
    final k = context.knobs;
    final message = k.string(label: 'Message', initialValue: 'I am a tooltip');
    final triggerMode = optionKnob<TooltipTriggerMode>(
      context,
      label: 'Trigger mode',
      options: TooltipTriggerMode.values,
      initial: TooltipTriggerMode.longPress,
    );
    final preferBelow = k.boolean(label: 'Prefer below', initialValue: true);
    final enableFeedback = k.boolean(
      label: 'Enable feedback',
      initialValue: true,
    );
    final verticalOffset = k.double.slider(
      label: 'Vertical offset',
      initialValue: 24,
      min: 0,
      max: 64,
      divisions: 64,
    );
    final waitMs = k.int.slider(
      label: 'Wait (ms)',
      initialValue: 0,
      min: 0,
      max: 2000,
      divisions: 20,
    );
    final showMs = k.int.slider(
      label: 'Show duration (ms)',
      initialValue: 1500,
      min: 0,
      max: 5000,
      divisions: 25,
    );
    final decorationColor = k.colorOrNull(
      label: 'Decoration color',
      defaultToNull: true,
    );
    return Tooltip(
      message: message,
      triggerMode: triggerMode,
      preferBelow: preferBelow,
      enableFeedback: enableFeedback,
      verticalOffset: verticalOffset,
      waitDuration: Duration(milliseconds: waitMs),
      showDuration: Duration(milliseconds: showMs),
      decoration: decorationColor == null
          ? null
          : BoxDecoration(
              color: decorationColor,
              borderRadius: BorderRadius.circular(4),
            ),
      child: const Text('Hover or long-press me'),
    );
  }),
  component('Image', (context) {
    final k = context.knobs;
    final url = k.string(
      label: 'URL',
      initialValue: 'https://picsum.photos/seed/material/240/140',
    );
    final width = k.double.slider(
      label: 'Width',
      initialValue: 240,
      min: 40,
      max: 360,
      divisions: 64,
    );
    final height = k.double.slider(
      label: 'Height',
      initialValue: 140,
      min: 40,
      max: 280,
      divisions: 48,
    );
    final fit = optionKnob<BoxFit>(
      context,
      label: 'Fit',
      options: BoxFit.values,
      initial: BoxFit.cover,
    );
    final repeat = optionKnob<ImageRepeat>(
      context,
      label: 'Repeat',
      options: ImageRepeat.values,
      initial: ImageRepeat.noRepeat,
    );
    final filterQuality = optionKnob<FilterQuality>(
      context,
      label: 'Filter quality',
      options: FilterQuality.values,
      initial: FilterQuality.medium,
    );
    final color = k.colorOrNull(label: 'Blend color', defaultToNull: true);
    final blendMode = optionKnob<BlendMode>(
      context,
      label: 'Blend mode',
      options: BlendMode.values,
      initial: BlendMode.srcIn,
    );
    final gaplessPlayback = k.boolean(
      label: 'Gapless playback',
      initialValue: false,
    );
    final isAntiAlias = k.boolean(label: 'Anti-alias', initialValue: false);
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      repeat: repeat,
      filterQuality: filterQuality,
      color: color,
      colorBlendMode: color == null ? null : blendMode,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      errorBuilder: (context, error, stackTrace) => Container(
        width: width,
        height: height,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: const Icon(Icons.broken_image),
      ),
    );
  }),
  component('DataTable', (context) {
    final k = context.knobs;
    final columnSpacing = k.double.slider(
      label: 'Column spacing',
      initialValue: 56,
      min: 0,
      max: 96,
      divisions: 48,
    );
    final horizontalMargin = k.double.slider(
      label: 'Horizontal margin',
      initialValue: 24,
      min: 0,
      max: 48,
      divisions: 24,
    );
    final headingRowHeight = k.double.slider(
      label: 'Heading row height',
      initialValue: 56,
      min: 24,
      max: 96,
      divisions: 36,
    );
    final dataRowHeight = k.double.slider(
      label: 'Data row height',
      initialValue: 52,
      min: 24,
      max: 96,
      divisions: 36,
    );
    final dividerThickness = k.double.slider(
      label: 'Divider thickness',
      initialValue: 1,
      min: 0,
      max: 4,
      divisions: 8,
      precision: 1,
    );
    final showBottomBorder = k.boolean(
      label: 'Show bottom border',
      initialValue: false,
    );
    final sortColumnIndex = k.intOrNull.input(
      label: 'Sort column (null = none)',
      initialValue: null,
      defaultToNull: true,
    );
    final sortAscending = k.boolean(
      label: 'Sort ascending',
      initialValue: true,
    );
    final clip = optionKnob<Clip>(
      context,
      label: 'Clip behavior',
      options: Clip.values,
      initial: Clip.none,
    );
    return DataTable(
      columnSpacing: columnSpacing,
      horizontalMargin: horizontalMargin,
      headingRowHeight: headingRowHeight,
      dataRowMinHeight: dataRowHeight,
      dataRowMaxHeight: dataRowHeight,
      dividerThickness: dividerThickness,
      showBottomBorder: showBottomBorder,
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending,
      clipBehavior: clip,
      columns: [
        DataColumn(
          label: const Text('Name'),
          onSort: (i, asc) => showDemoSnack(context, 'Sort $i asc=$asc'),
        ),
        DataColumn(
          label: const Text('Role'),
          onSort: (i, asc) => showDemoSnack(context, 'Sort $i asc=$asc'),
        ),
        DataColumn(
          label: const Text('Active'),
          numeric: true,
          onSort: (i, asc) => showDemoSnack(context, 'Sort $i asc=$asc'),
        ),
      ],
      rows: const [
        DataRow(
          cells: [
            DataCell(Text('Ada')),
            DataCell(Text('Engineer')),
            DataCell(Icon(Icons.check_circle, color: Colors.green)),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('Linus')),
            DataCell(Text('Designer')),
            DataCell(Icon(Icons.remove_circle, color: Colors.orange)),
          ],
        ),
      ],
    );
  }),
  component('Material', (context) {
    final k = context.knobs;
    final type = optionKnob<MaterialType>(
      context,
      label: 'Type',
      options: MaterialType.values,
      initial: MaterialType.canvas,
    );
    final elevation = k.double.slider(
      label: 'Elevation',
      initialValue: 2,
      min: 0,
      max: 24,
      divisions: 24,
    );
    final color = k.colorOrNull(label: 'Color', defaultToNull: true);
    final shadowColor = k.colorOrNull(
      label: 'Shadow color',
      defaultToNull: true,
    );
    final surfaceTintColor = k.colorOrNull(
      label: 'Surface tint color',
      defaultToNull: true,
    );
    final radius = k.double.slider(
      label: 'Border radius',
      initialValue: 12,
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
    final animationMs = k.int.slider(
      label: 'Animation (ms)',
      initialValue: 200,
      min: 0,
      max: 1000,
      divisions: 20,
    );
    final borderOnForeground = k.boolean(
      label: 'Border on foreground',
      initialValue: true,
    );
    return Material(
      type: type,
      elevation: elevation,
      color: color,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: clip,
      animationDuration: Duration(milliseconds: animationMs),
      borderOnForeground: borderOnForeground,
      child: const Padding(
        padding: EdgeInsets.all(24),
        child: Text('Material surface'),
      ),
    );
  }),
  component('InkWell', (context) {
    final k = context.knobs;
    final enabled = k.boolean(label: 'Enabled (onTap)', initialValue: true);
    final splashFactory = optionKnob<_SplashFactory>(
      context,
      label: 'Splash factory',
      options: _SplashFactory.values,
      initial: _SplashFactory.ripple,
    );
    final splashColor = k.colorOrNull(
      label: 'Splash color',
      defaultToNull: true,
    );
    final highlightColor = k.colorOrNull(
      label: 'Highlight color',
      defaultToNull: true,
    );
    final hoverColor = k.colorOrNull(label: 'Hover color', defaultToNull: true);
    final focusColor = k.colorOrNull(label: 'Focus color', defaultToNull: true);
    final radius = k.double.slider(
      label: 'Radius',
      initialValue: 0,
      min: 0,
      max: 64,
      divisions: 64,
    );
    final borderRadius = k.double.slider(
      label: 'Border radius',
      initialValue: 8,
      min: 0,
      max: 32,
      divisions: 32,
    );
    final enableFeedback = k.boolean(
      label: 'Enable feedback',
      initialValue: true,
    );
    final excludeFromSemantics = k.boolean(
      label: 'Exclude from semantics',
      initialValue: false,
    );
    final autofocus = k.boolean(label: 'Autofocus', initialValue: false);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? () => showDemoSnack(context, 'InkWell tapped') : null,
        onLongPress: () => showDemoSnack(context, 'InkWell long-press'),
        splashFactory: _splashFactoryFor(splashFactory),
        splashColor: splashColor,
        highlightColor: highlightColor,
        hoverColor: hoverColor,
        focusColor: focusColor,
        radius: radius,
        borderRadius: BorderRadius.circular(borderRadius),
        enableFeedback: enableFeedback,
        excludeFromSemantics: excludeFromSemantics,
        autofocus: autofocus,
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Tap me (ripple)'),
        ),
      ),
    );
  }),
  component('GridView', (context) {
    final k = context.knobs;
    final colorScheme = Theme.of(context).colorScheme;
    final crossAxisCount = k.int.slider(
      label: 'Cross axis count',
      initialValue: 3,
      min: 1,
      max: 6,
    );
    final itemCount = k.int.slider(
      label: 'Item count',
      initialValue: 9,
      min: 1,
      max: 24,
    );
    final mainAxisSpacing = k.double.slider(
      label: 'Main axis spacing',
      initialValue: 8,
      min: 0,
      max: 32,
      divisions: 32,
    );
    final crossAxisSpacing = k.double.slider(
      label: 'Cross axis spacing',
      initialValue: 8,
      min: 0,
      max: 32,
      divisions: 32,
    );
    final childAspectRatio = k.double.slider(
      label: 'Child aspect ratio',
      initialValue: 1,
      min: 0.4,
      max: 3,
      divisions: 26,
      precision: 2,
    );
    final scrollDirection = optionKnob<Axis>(
      context,
      label: 'Scroll direction',
      options: Axis.values,
      initial: Axis.vertical,
    );
    final reverse = k.boolean(label: 'Reverse', initialValue: false);
    final clip = optionKnob<Clip>(
      context,
      label: 'Clip behavior',
      options: Clip.values,
      initial: Clip.hardEdge,
    );
    return SizedBox(
      width: 280,
      height: 200,
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
        scrollDirection: scrollDirection,
        reverse: reverse,
        clipBehavior: clip,
        children: List.generate(itemCount, (index) {
          return Container(
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(30 + index * 12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(child: Text('$index')),
          );
        }),
      ),
    );
  }),
]);
