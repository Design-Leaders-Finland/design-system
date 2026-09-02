import 'package:flutter/material.dart';
import 'package:design_leaders_system/design_leaders_system.dart';

import '../widgets/app_header.dart';

class WidgetsPage extends StatelessWidget {
  const WidgetsPage({super.key, required this.onThemeChanged});

  final ValueChanged<bool> onThemeChanged;

  static final _widgetItems =
      <WidgetCardItem>[
          WidgetCardItem(
            title: 'ElevatedButton',
            description: 'A button with a filled background.',
            builder: (context) => ElevatedButton(
              onPressed: () => _showSnack(context, 'ElevatedButton tapped'),
              child: const Text('Button'),
            ),
          ),
          WidgetCardItem(
            title: 'TextButton',
            description: 'A button with no background or border.',
            builder: (context) => TextButton(
              onPressed: () => _showSnack(context, 'TextButton tapped'),
              child: const Text('Button'),
            ),
          ),
          WidgetCardItem(
            title: 'OutlinedButton',
            description: 'A button with a border and no fill.',
            builder: (context) => OutlinedButton(
              onPressed: () => _showSnack(context, 'OutlinedButton tapped'),
              child: const Text('Button'),
            ),
          ),
          WidgetCardItem(
            title: 'FilledButton',
            description:
                'A button with a filled background and elevated style.',
            builder: (context) => FilledButton(
              onPressed: () => _showSnack(context, 'FilledButton tapped'),
              child: const Text('Button'),
            ),
          ),
          WidgetCardItem(
            title: 'IconButton',
            description: 'A clickable icon button.',
            builder: (context) => IconButton(
              onPressed: () => _showSnack(context, 'IconButton tapped'),
              icon: const Icon(Icons.favorite),
            ),
          ),
          WidgetCardItem(
            title: 'TextField',
            description: 'A text input field.',
            builder: (context) => const SizedBox(
              width: 160,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter text',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          WidgetCardItem(
            title: 'Checkbox',
            description: 'A toggleable checkbox.',
            builder: (context) => const _CheckboxExample(),
          ),
          WidgetCardItem(
            title: 'Switch',
            description: 'A toggle switch.',
            builder: (context) => const _SwitchExample(),
          ),
          WidgetCardItem(
            title: 'Slider',
            description: 'A draggable slider.',
            builder: (context) => const _SliderExample(),
          ),
          WidgetCardItem(
            title: 'Radio',
            description: 'A set of radio buttons.',
            builder: (context) => const _RadioGroupExample(),
          ),
          WidgetCardItem(
            title: 'CircularProgressIndicator',
            description: 'A circular progress indicator.',
            builder: (context) => GestureDetector(
              onTap: () =>
                  _showSnack(context, 'CircularProgressIndicator tapped'),
              child: const CircularProgressIndicator(),
            ),
          ),
          WidgetCardItem(
            title: 'LinearProgressIndicator',
            description: 'A linear progress indicator.',
            builder: (context) => GestureDetector(
              onTap: () =>
                  _showSnack(context, 'LinearProgressIndicator tapped'),
              child: const LinearProgressIndicator(value: 0.7),
            ),
          ),
          WidgetCardItem(
            title: 'Card',
            description: 'A material card with content.',
            builder: (context) => InkWell(
              onTap: () => _showSnack(context, 'Card tapped'),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(Spacing.s3),
                  child: Text(
                    'Card content',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          ),
          WidgetCardItem(
            title: 'Chip',
            description: 'A compact chip element.',
            builder: (context) => Chip(
              label: const Text('Chip'),
              onDeleted: () => _showSnack(context, 'Chip deleted'),
            ),
          ),
          WidgetCardItem(
            title: 'ListTile',
            description:
                'A fixed-height row with leading, title, and trailing.',
            builder: (context) => ListTile(
              title: Text(
                'Title',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              subtitle: Text(
                'Subtitle',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              leading: const Icon(Icons.list),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _showSnack(context, 'ListTile tapped'),
            ),
          ),
          WidgetCardItem(
            title: 'Divider',
            description: 'A thin horizontal divider.',
            builder: (context) => GestureDetector(
              onTap: () => _showSnack(context, 'Divider tapped'),
              child: const Divider(),
            ),
          ),
          WidgetCardItem(
            title: 'Icon',
            description: 'A graphic icon.',
            builder: (context) => GestureDetector(
              onTap: () => _showSnack(context, 'Icon tapped'),
              child: const Icon(Icons.star, size: 32),
            ),
          ),
          WidgetCardItem(
            title: 'CircleAvatar',
            description: 'A circular avatar widget.',
            builder: (context) => InkWell(
              onTap: () => _showSnack(context, 'CircleAvatar tapped'),
              child: const CircleAvatar(radius: 20, child: Icon(Icons.person)),
            ),
          ),
          WidgetCardItem(
            title: 'Badge',
            description: 'A badge with a notification count.',
            builder: (context) => InkWell(
              onTap: () => _showSnack(context, 'Badge tapped'),
              child: Badge(
                label: const Text('3'),
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
          WidgetCardItem(
            title: 'Tooltip',
            description: 'A tooltip that shows on hover or long press.',
            builder: (context) => const Tooltip(
              message: 'This is a tooltip',
              child: Text('Hover me'),
            ),
          ),
          WidgetCardItem(
            title: 'PopupMenuButton',
            description: 'A button that shows a popup menu.',
            builder: (context) => PopupMenuButton<String>(
              onSelected: (value) =>
                  _showSnack(context, 'Popup selected: $value'),
              itemBuilder: (context) => const [
                PopupMenuItem(value: '1', child: Text('Item 1')),
                PopupMenuItem(value: '2', child: Text('Item 2')),
              ],
            ),
          ),
          WidgetCardItem(
            title: 'BottomNavigationBar',
            description: 'A bar with navigation destinations.',
            builder: (context) => const _BottomNavigationBarExample(),
          ),
          WidgetCardItem(
            title: 'TabBar',
            description: 'A row of tabs.',
            builder: (context) => DefaultTabController(
              length: 2,
              child: GestureDetector(
                onTap: () => _showSnack(context, 'TabBar tapped'),
                child: const TabBar(
                  tabs: [
                    Tab(text: 'Tab 1'),
                    Tab(text: 'Tab 2'),
                  ],
                ),
              ),
            ),
          ),
          WidgetCardItem(
            title: 'AppBar',
            description: 'A material app bar.',
            builder: (context) => Material(
              color: Theme.of(context).colorScheme.surface,
              child: InkWell(
                onTap: () => _showSnack(context, 'AppBar tapped'),
                child: AppBar(
                  title: Text(
                    'AppBar',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ),
          WidgetCardItem(
            title: 'Drawer',
            description: 'A side panel with navigation items.',
            builder: (context) => SizedBox(
              width: 160,
              child: Drawer(
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        'Header',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Item',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      leading: const Icon(Icons.inbox),
                      onTap: () => _showSnack(context, 'Drawer item tapped'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          WidgetCardItem(
            title: 'SnackBar',
            description: 'A brief message at the bottom of the screen.',
            builder: (context) => ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'SnackBar',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {},
                      textColor: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                );
              },
              child: const Text('Show SnackBar'),
            ),
          ),
          WidgetCardItem(
            title: 'AlertDialog',
            description: 'A dialog that requires user interaction.',
            builder: (context) => ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'Alert',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    content: Text(
                      'Content',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Show Dialog'),
            ),
          ),
          WidgetCardItem(
            title: 'BottomSheet',
            description: 'A panel that slides up from the bottom.',
            builder: (context) => ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    padding: const EdgeInsets.all(Spacing.s4),
                    child: Text(
                      'Bottom Sheet',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                );
              },
              child: const Text('Show BottomSheet'),
            ),
          ),
          WidgetCardItem(
            title: 'Stepper',
            description:
                'A widget that displays progress through a sequence of steps.',
            builder: (context) => const _StepperExample(),
          ),
          WidgetCardItem(
            title: 'ExpansionTile',
            description: 'A tile that can expand to reveal more content.',
            builder: (context) => ExpansionTile(
              title: Text(
                'Expandable',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              children: [
                Text(
                  'Expanded content',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          WidgetCardItem(
            title: 'FloatingActionButton',
            description: 'A circular button that floats above content.',
            builder: (context) => FloatingActionButton(
              onPressed: () => _showSnack(context, 'FAB tapped'),
              child: const Icon(Icons.add),
            ),
          ),
          WidgetCardItem(
            title: 'DatePicker',
            description: 'A dialog to select a date.',
            builder: (context) => ElevatedButton(
              onPressed: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
              },
              child: const Text('Select Date'),
            ),
          ),
          WidgetCardItem(
            title: 'TimePicker',
            description: 'A dialog to select a time.',
            builder: (context) => ElevatedButton(
              onPressed: () async {
                await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
              },
              child: const Text('Select Time'),
            ),
          ),
          WidgetCardItem(
            title: 'ColorPicker',
            description: 'A dialog to select a color.',
            builder: (context) => const _ColorPickerExample(),
          ),
          WidgetCardItem(
            title: 'CalendarDatePicker',
            description: 'A calendar grid for picking dates.',
            builder: (context) => CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              onDateChanged: (date) =>
                  _showSnack(context, 'Date selected: $date'),
            ),
          ),
          WidgetCardItem(
            title: 'SegmentedButton',
            description: 'A button group with multiple segments.',
            builder: (context) => const _SegmentedButtonExample(),
          ),
          WidgetCardItem(
            title: 'NavigationRail',
            description: 'A vertical navigation bar.',
            builder: (context) => const _NavigationRailExample(),
          ),
          WidgetCardItem(
            title: 'DataTable',
            description: 'A material data table.',
            builder: (context) => GestureDetector(
              onTap: () => _showSnack(context, 'DataTable tapped'),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Col 1')),
                  DataColumn(label: Text('Col 2')),
                ],
                rows: const [
                  DataRow(cells: [DataCell(Text('A')), DataCell(Text('B'))]),
                  DataRow(cells: [DataCell(Text('C')), DataCell(Text('D'))]),
                ],
              ),
            ),
          ),
          WidgetCardItem(
            title: 'Image',
            description: 'A network image.',
            builder: (context) => GestureDetector(
              onTap: () => _showSnack(context, 'Image tapped'),
              child: Image.network(
                'https://picsum.photos/seed/flutter/120/80',
                width: 120,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 120,
                  height: 80,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.broken_image),
                ),
              ),
            ),
          ),
          WidgetCardItem(
            title: 'IconButton.filled',
            description: 'A filled toggle icon button.',
            builder: (context) => const _IconButtonToggleExample(),
          ),
          WidgetCardItem(
            title: 'FilterChip',
            description: 'A chip used for filters.',
            builder: (context) => FilterChip(
              label: const Text('Filter'),
              onSelected: (value) =>
                  _showSnack(context, 'FilterChip selected: $value'),
            ),
          ),
          WidgetCardItem(
            title: 'InputChip',
            description: 'A chip representing a complex input.',
            builder: (context) => InputChip(
              label: const Text('Input'),
              onPressed: () => _showSnack(context, 'InputChip tapped'),
              onDeleted: () => _showSnack(context, 'InputChip deleted'),
            ),
          ),
          WidgetCardItem(
            title: 'ChoiceChip',
            description: 'A chip used for single selection.',
            builder: (context) => const _ChoiceChipExample(),
          ),
          WidgetCardItem(
            title: 'DropdownButton',
            description: 'A basic dropdown selector.',
            builder: (context) => const _DropdownButtonExample(),
          ),
          WidgetCardItem(
            title: 'RangeSlider',
            description: 'A slider that selects a range of values.',
            builder: (context) => const _RangeSliderExample(),
          ),
          WidgetCardItem(
            title: 'NavigationBar',
            description: 'A Material 3 bottom navigation bar.',
            builder: (context) => const _NavigationBarExample(),
          ),
        ]
        // Keep the gallery easy to scan: always render the cards in
        // alphabetical order by widget name.
        ..sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );

  static void _showSnack(BuildContext context, String message) {
    final colors = context.colors;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: colors.surface,
          content: AppText.body(message, color: colors.text),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = width < 900;

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 140 + (isNarrow ? Spacing.s10 : Spacing.s16) * 2,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.s6),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: Spacing.s12),
                          _WidgetGridHeader(colors: colors),
                          const SizedBox(height: Spacing.s16),
                          _WidgetsGrid(items: _widgetItems, colors: colors),
                          const SizedBox(height: Spacing.s16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: AppHeader(onThemeChanged: onThemeChanged),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WidgetGridHeader extends StatelessWidget {
  const _WidgetGridHeader({required this.colors});

  final AppColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.display('Material Widgets', color: colors.textTertiary),
        const SizedBox(height: Spacing.s4),
        AppText.body(
          'A curated grid of common Material widgets, styled with shared design tokens.',
        ),
      ],
    );
  }
}

class _WidgetsGrid extends StatelessWidget {
  const _WidgetsGrid({required this.items, required this.colors});

  final List<WidgetCardItem> items;
  final AppColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        crossAxisSpacing: Spacing.s4,
        mainAxisSpacing: Spacing.s4,
        childAspectRatio: 0.85,
      ),
      children: items.map((item) {
        return _WidgetCard(item: item, colors: colors);
      }).toList(),
    );
  }
}

class _WidgetCard extends StatelessWidget {
  const _WidgetCard({required this.item, required this.colors});

  final WidgetCardItem item;
  final AppColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        border: Border.all(color: colors.border),
        boxShadow: AppShadow.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(Spacing.s4),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppBorderRadius.lg),
                ),
              ),
              child: Center(
                child: Material(
                  type: MaterialType.transparency,
                  child: item.builder(context),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(Spacing.s4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.title(item.title, color: colors.text),
                  const SizedBox(height: Spacing.s1),
                  AppText.body(
                    item.description,
                    color: colors.textTertiary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetCardItem {
  const WidgetCardItem({
    required this.title,
    required this.builder,
    this.description = '',
  });

  final String title;
  final Widget Function(BuildContext) builder;
  final String description;
}
// ── Interactive example widgets ────────────────────────────────────────────────
//
// These are small self-contained [StatefulWidget]s so that each example in the
// grid keeps its own state and reacts to user input. (Plain `StatefulBuilder`
// wrappers that declared state inside their build closure were resetting that
// state on every rebuild, which made the toggles, sliders, and selections in the
// grid appear inert.)

class _CheckboxExample extends StatefulWidget {
  const _CheckboxExample();

  @override
  State<_CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<_CheckboxExample> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _checked,
      onChanged: (value) => setState(() => _checked = value ?? false),
    );
  }
}

class _SwitchExample extends StatefulWidget {
  const _SwitchExample();

  @override
  State<_SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<_SwitchExample> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _enabled,
      onChanged: (value) => setState(() => _enabled = value),
    );
  }
}

class _SliderExample extends StatefulWidget {
  const _SliderExample();

  @override
  State<_SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<_SliderExample> {
  double _value = 0.5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Slider(
        value: _value,
        onChanged: (value) => setState(() => _value = value),
      ),
    );
  }
}

class _RadioGroupExample extends StatefulWidget {
  const _RadioGroupExample();

  @override
  State<_RadioGroupExample> createState() => _RadioGroupExampleState();
}

class _RadioGroupExampleState extends State<_RadioGroupExample> {
  String? _groupValue;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<String>(
      groupValue: _groupValue,
      onChanged: (value) => setState(() => _groupValue = value),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(value: 'A'),
          Radio<String>(value: 'B'),
        ],
      ),
    );
  }
}

class _ChoiceChipExample extends StatefulWidget {
  const _ChoiceChipExample();

  @override
  State<_ChoiceChipExample> createState() => _ChoiceChipExampleState();
}

class _ChoiceChipExampleState extends State<_ChoiceChipExample> {
  bool _selected = true;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: const Text('Choice'),
      selected: _selected,
      onSelected: (value) => setState(() => _selected = value),
    );
  }
}

class _IconButtonToggleExample extends StatefulWidget {
  const _IconButtonToggleExample();

  @override
  State<_IconButtonToggleExample> createState() =>
      _IconButtonToggleExampleState();
}

class _IconButtonToggleExampleState extends State<_IconButtonToggleExample> {
  bool _selected = true;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      isSelected: _selected,
      onPressed: () {
        setState(() => _selected = !_selected);
        WidgetsPage._showSnack(
          context,
          'IconButton.filled ${_selected ? 'enabled' : 'muted'}',
        );
      },
      selectedIcon: const Icon(Icons.volume_up),
      icon: const Icon(Icons.volume_off),
    );
  }
}

class _BottomNavigationBarExample extends StatefulWidget {
  const _BottomNavigationBarExample();

  @override
  State<_BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<_BottomNavigationBarExample> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      ],
    );
  }
}

class _StepperExample extends StatefulWidget {
  const _StepperExample();

  @override
  State<_StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<_StepperExample> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        width: 360,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: _currentStep < 1
              ? () => setState(() => _currentStep++)
              : null,
          onStepCancel: _currentStep > 0
              ? () => setState(() => _currentStep--)
              : null,
          steps: [
            Step(
              title: AppText.body('Step 1', color: colors.text),
              content: AppText.body('Content', color: colors.text),
              isActive: true,
            ),
            Step(
              title: AppText.body('Step 2', color: colors.text),
              content: AppText.body('Content', color: colors.text),
              isActive: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentedButtonExample extends StatefulWidget {
  const _SegmentedButtonExample();

  @override
  State<_SegmentedButtonExample> createState() =>
      _SegmentedButtonExampleState();
}

class _SegmentedButtonExampleState extends State<_SegmentedButtonExample> {
  String _selected = 'A';

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(value: 'A', label: Text('A')),
        ButtonSegment(value: 'B', label: Text('B')),
      ],
      selected: {_selected},
      onSelectionChanged: (selection) =>
          setState(() => _selected = selection.first),
    );
  }
}

class _NavigationRailExample extends StatefulWidget {
  const _NavigationRailExample();

  @override
  State<_NavigationRailExample> createState() => _NavigationRailExampleState();
}

class _NavigationRailExampleState extends State<_NavigationRailExample> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 150,
      child: NavigationRail(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationRailDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.search),
            label: Text('Search'),
          ),
        ],
      ),
    );
  }
}

class _DropdownButtonExample extends StatefulWidget {
  const _DropdownButtonExample();

  @override
  State<_DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<_DropdownButtonExample> {
  String? _value = 'One';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: _value,
        items: const [
          DropdownMenuItem(value: 'One', child: Text('One')),
          DropdownMenuItem(value: 'Two', child: Text('Two')),
        ],
        onChanged: (value) => setState(() => _value = value),
      ),
    );
  }
}

class _RangeSliderExample extends StatefulWidget {
  const _RangeSliderExample();

  @override
  State<_RangeSliderExample> createState() => _RangeSliderExampleState();
}

class _RangeSliderExampleState extends State<_RangeSliderExample> {
  RangeValues _values = const RangeValues(0.2, 0.7);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: RangeSlider(
        values: _values,
        onChanged: (values) => setState(() => _values = values),
      ),
    );
  }
}

class _NavigationBarExample extends StatefulWidget {
  const _NavigationBarExample();

  @override
  State<_NavigationBarExample> createState() => _NavigationBarExampleState();
}

class _NavigationBarExampleState extends State<_NavigationBarExample> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) => setState(() => _selectedIndex = index),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
        NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}

class _ColorPickerExample extends StatelessWidget {
  const _ColorPickerExample();

  static const _swatches = <(String, Color)>[
    ('Primary', AppColors.primary),
    ('Secondary', AppColors.secondary),
    ('Accent', AppColors.accent),
    ('Attention', AppColors.attention),
    ('Warning', AppColors.warning),
    ('Danger', AppColors.danger),
    ('Success', AppColors.success),
  ];

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => _pickColor(context),
      child: const Text('Select Color'),
    );
  }

  Future<void> _pickColor(BuildContext context) async {
    final selected = await showDialog<Color>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Pick a color'),
        children: [
          Padding(
            padding: const EdgeInsets.all(Spacing.s4),
            child: Wrap(
              spacing: Spacing.s2,
              runSpacing: Spacing.s2,
              children: [
                for (final (label, color) in _swatches)
                  Tooltip(
                    message: label,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppBorderRadius.full),
                      onTap: () => Navigator.pop(context, color),
                      child: Container(
                        width: Sizing.controlSm,
                        height: Sizing.controlSm,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(color: context.colors.border),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );

    if (selected != null && context.mounted) {
      WidgetsPage._showSnack(context, 'Color selected: $selected');
    }
  }
}
