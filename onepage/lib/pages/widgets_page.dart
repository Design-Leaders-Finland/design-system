import 'package:flutter/material.dart';
import 'package:design_leaders_system/design_leaders_system.dart';
import '../widgets/app_header.dart';

class WidgetsPage extends StatelessWidget {
  const WidgetsPage({super.key, required this.onThemeChanged});

  final ValueChanged<bool> onThemeChanged;

  static final _widgetItems = <WidgetCardItem>[
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
      description: 'A button with a filled background and elevated style.',
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
      builder: (context) => StatefulBuilder(
        builder: (context, setState) =>
            Checkbox(value: false, onChanged: (value) => setState(() {})),
      ),
    ),
    WidgetCardItem(
      title: 'Switch',
      description: 'A toggle switch.',
      builder: (context) => StatefulBuilder(
        builder: (context, setState) =>
            Switch(value: false, onChanged: (value) => setState(() {})),
      ),
    ),
    WidgetCardItem(
      title: 'Slider',
      description: 'A draggable slider.',
      builder: (context) => StatefulBuilder(
        builder: (context, setState) =>
            Slider(value: 0.5, onChanged: (value) => setState(() {})),
      ),
    ),
    WidgetCardItem(
      title: 'Radio',
      description: 'A set of radio buttons.',
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          String? groupValue;
          return RadioGroup<String>(
            groupValue: groupValue,
            onChanged: (value) => setState(() => groupValue = value),
            child: const Row(
              children: [
                Radio<String>(value: 'A'),
                Radio<String>(value: 'B'),
              ],
            ),
          );
        },
      ),
    ),
    WidgetCardItem(
      title: 'CircularProgressIndicator',
      description: 'A circular progress indicator.',
      builder: (context) => GestureDetector(
        onTap: () => _showSnack(context, 'CircularProgressIndicator tapped'),
        child: const CircularProgressIndicator(),
      ),
    ),
    WidgetCardItem(
      title: 'LinearProgressIndicator',
      description: 'A linear progress indicator.',
      builder: (context) => GestureDetector(
        onTap: () => _showSnack(context, 'LinearProgressIndicator tapped'),
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
      description: 'A fixed-height row with leading, title, and trailing.',
      builder: (context) => ListTile(
        title: Text('Title', style: Theme.of(context).textTheme.bodyMedium),
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
      builder: (context) =>
          const Tooltip(message: 'This is a tooltip', child: Text('Hover me')),
    ),
    WidgetCardItem(
      title: 'PopupMenuButton',
      description: 'A button that shows a popup menu.',
      builder: (context) => PopupMenuButton<String>(
        onSelected: (value) => _showSnack(context, 'Popup selected: $value'),
        itemBuilder: (context) => const [
          PopupMenuItem(value: '1', child: Text('Item 1')),
          PopupMenuItem(value: '2', child: Text('Item 2')),
        ],
      ),
    ),
    WidgetCardItem(
      title: 'BottomNavigationBar',
      description: 'A bar with navigation destinations.',
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          int currentIndex = 0;
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
            ],
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
          );
        },
      ),
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          int currentStep = 0;
          return FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              width: 360,
              child: Stepper(
                currentStep: currentStep,
                onStepContinue: () => setState(() => currentStep++),
                onStepCancel: () => setState(() => currentStep--),
                steps: [
                  Step(
                    title: Text(
                      'Step 1',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    content: Text(
                      'Content',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    isActive: true,
                  ),
                  Step(
                    title: Text(
                      'Step 2',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    content: Text(
                      'Content',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    isActive: false,
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
        },
        child: const Text('Select Time'),
      ),
    ),
    WidgetCardItem(
      title: 'ColorPicker',
      description: 'A dialog to select a color.',
      builder: (context) =>
          ElevatedButton(onPressed: () {}, child: const Text('Select Color')),
    ),
    WidgetCardItem(
      title: 'CalendarDatePicker',
      description: 'A calendar grid for picking dates.',
      builder: (context) => CalendarDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        onDateChanged: (date) => _showSnack(context, 'Date selected: $date'),
      ),
    ),
    WidgetCardItem(
      title: 'SegmentedButton',
      description: 'A button group with multiple segments.',
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          String selected = 'A';
          return SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'A', label: Text('A')),
              ButtonSegment(value: 'B', label: Text('B')),
            ],
            selected: {selected},
            onSelectionChanged: (value) =>
                setState(() => selected = value.first),
          );
        },
      ),
    ),
    WidgetCardItem(
      title: 'NavigationRail',
      description: 'A vertical navigation bar.',
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          int selectedIndex = 0;
          return NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) =>
                setState(() => selectedIndex = index),
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
          );
        },
      ),
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
      builder: (context) => IconButton.filled(
        isSelected: true,
        onPressed: () => _showSnack(context, 'IconButton.filled tapped'),
        selectedIcon: const Icon(Icons.volume_up),
        icon: const Icon(Icons.volume_off),
      ),
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
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          bool selected = true;
          return ChoiceChip(
            label: const Text('Choice'),
            selected: selected,
            onSelected: (value) => setState(() => selected = value),
          );
        },
      ),
    ),
  ];

  static void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
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
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: colors.text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: Spacing.s1),
                  Text(
                    item.description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: colors.textTertiary),
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
