import 'package:design_leaders_system/design_leaders_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'common.dart';

// ── Display & data ───────────────────────────────────────────────────────────

/// Cards, lists, tables, avatars, badges and other content widgets.
WidgetbookCategory get displayCategory => category('Display & Data', [
  componentVariants('Card', {
    'Default': (context) => SizedBox(
      width: 240,
      child: Card(
        child: ListTile(
          title: const Text('Card title'),
          subtitle: const Text('Supporting text'),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    ),
    'Outlined': (context) => SizedBox(
      width: 240,
      child: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.s4),
          child: AppText.body('Outlined card content'),
        ),
      ),
    ),
    'Filled': (context) => SizedBox(
      width: 240,
      child: Card.filled(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.s4),
          child: AppText.body('Filled card content'),
        ),
      ),
    ),
  }),
  componentVariants('ListTile', {
    'Default': (context) => SizedBox(
      width: 300,
      child: ListTile(
        title: const Text('Title'),
        subtitle: const Text('Subtitle'),
      ),
    ),
    'With icons': (context) => SizedBox(
      width: 300,
      child: ListTile(
        leading: const Icon(Icons.album),
        title: const Text('Title'),
        subtitle: const Text('Subtitle'),
        trailing: const Icon(Icons.more_vert),
        onTap: () => showDemoSnack(context, 'ListTile tapped'),
      ),
    ),
    'Selected': (context) => SizedBox(
      width: 300,
      child: ListTile(
        selected: true,
        leading: const Icon(Icons.inbox),
        title: const Text('Inbox'),
        trailing: const Text('24'),
      ),
    ),
  }),
  component(
    'ExpansionTile',
    (context) => SizedBox(
      width: 300,
      child: ExpansionTile(
        title: const Text('Expansion tile'),
        subtitle: const Text('Tap to expand'),
        children: const [
          ListTile(title: Text('Child one')),
          ListTile(title: Text('Child two')),
        ],
      ),
    ),
  ),
  component(
    'Divider',
    (context) => SizedBox(
      width: 240,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [Text('Above'), Divider(), Text('Below')],
      ),
    ),
  ),
  component(
    'VerticalDivider',
    (context) => SizedBox(
      width: 200,
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text('Left'), VerticalDivider(), Text('Right')],
      ),
    ),
  ),
  componentVariants('Icon', {
    'Default': (context) => const Icon(Icons.star, size: 32),
    'Primary': (context) => Icon(
      Icons.favorite,
      size: 32,
      color: Theme.of(context).colorScheme.primary,
    ),
    'Secondary': (context) => Icon(
      Icons.bolt,
      size: 32,
      color: Theme.of(context).colorScheme.secondary,
    ),
  }),
  componentVariants('CircleAvatar', {
    'With icon': (context) => const CircleAvatar(child: Icon(Icons.person)),
    'With text': (context) => const CircleAvatar(child: Text('DL')),
    'With image': (context) => const CircleAvatar(
      radius: 28,
      backgroundImage: NetworkImage('https://picsum.photos/seed/avatar/80'),
    ),
  }),
  componentVariants('Badge', {
    'Count': (context) =>
        Badge.count(count: 3, child: const Icon(Icons.notifications, size: 32)),
    'Dot': (context) => Badge(child: const Icon(Icons.mail, size: 32)),
    'Label': (context) => Badge(
      label: const Text('99+'),
      child: const Icon(Icons.shopping_cart, size: 32),
    ),
  }),
  component(
    'Tooltip',
    (context) => const Tooltip(
      message: 'I am a tooltip',
      child: Text('Hover or long-press me'),
    ),
  ),
  component(
    'Image',
    (context) => Image.network(
      'https://picsum.photos/seed/material/200/120',
      width: 200,
      height: 120,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: 200,
        height: 120,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: const Icon(Icons.broken_image),
      ),
    ),
  ),
  component(
    'DataTable',
    (context) => DataTable(
      columns: const [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Role')),
        DataColumn(label: Text('Active')),
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
    ),
  ),
  component(
    'Material',
    (context) => Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(AppBorderRadius.md),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.s6),
        child: AppText.body('Material surface'),
      ),
    ),
  ),
  component(
    'InkWell',
    (context) => Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
        onTap: () => showDemoSnack(context, 'InkWell tapped'),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.s4),
          child: AppText.body('Tap me (ripple)'),
        ),
      ),
    ),
  ),
  component('GridView', (context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 240,
      height: 168,
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: Spacing.s2,
        crossAxisSpacing: Spacing.s2,
        children: List.generate(9, (index) {
          return Container(
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(30 + index * 24),
              borderRadius: BorderRadius.circular(AppBorderRadius.sm),
            ),
            child: Center(child: Text('$index')),
          );
        }),
      ),
    );
  }),
]);

// ── Layout & navigation ──────────────────────────────────────────────────────

/// App bars, tabs, navigation bars/rails/drawers and scaffolding.

/// Renders [child] inside a fixed-size [Scaffold] so app-level widgets such as
/// [AppBar] and [BottomAppBar] can be previewed in isolation.
Widget _scaffoldPreview(
  Widget child, {
  double width = 360,
  double height = 140,
}) {
  return SizedBox(width: width, height: height, child: child);
}

WidgetbookCategory get layoutCategory => category('Layout & Navigation', [
  component(
    'Scaffold',
    (context) => _scaffoldPreview(
      Scaffold(
        appBar: AppBar(title: const Text('Scaffold')),
        body: const Center(child: Text('Body content')),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDemoSnack(context, 'FAB pressed'),
          child: const Icon(Icons.add),
        ),
      ),
      width: 320,
      height: 240,
    ),
  ),
  component(
    'AppBar',
    (context) => _scaffoldPreview(
      Scaffold(
        appBar: AppBar(
          title: const Text('AppBar'),
          leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        body: const SizedBox.shrink(),
      ),
      height: 120,
    ),
  ),
  component(
    'BottomAppBar',
    (context) => _scaffoldPreview(
      Scaffold(
        body: const SizedBox.shrink(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
              const SizedBox(width: Spacing.s8),
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
        ),
      ),
      height: 160,
    ),
  ),
  component(
    'TabBar',
    (context) => DefaultTabController(
      length: 3,
      child: SizedBox(
        width: 360,
        height: 180,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'One', icon: Icon(Icons.looks_one)),
                Tab(text: 'Two', icon: Icon(Icons.looks_two)),
                Tab(text: 'Three', icon: Icon(Icons.looks_3)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: const [
                  Center(child: Text('Tab one')),
                  Center(child: Text('Tab two')),
                  Center(child: Text('Tab three')),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  component(
    'NavigationBar',
    (context) => DemoState<int>(
      initial: 0,
      builder: (context, index, setIndex) => SizedBox(
        width: 360,
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: setIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    ),
  ),
  component(
    'NavigationRail',
    (context) => DemoState<int>(
      initial: 0,
      builder: (context, index, setIndex) => SizedBox(
        width: 220,
        height: 240,
        child: NavigationRail(
          selectedIndex: index,
          onDestinationSelected: setIndex,
          labelType: NavigationRailLabelType.all,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.search),
              label: Text('Search'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.person),
              label: Text('Profile'),
            ),
          ],
        ),
      ),
    ),
  ),
  component(
    'NavigationDrawer',
    (context) => DemoState<int>(
      initial: 0,
      builder: (context, index, setIndex) => SizedBox(
        width: 240,
        height: 260,
        child: NavigationDrawer(
          selectedIndex: index,
          onDestinationSelected: setIndex,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
              child: AppText.title('Drawer'),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.home),
              label: Text('Home'),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.inbox),
              label: Text('Inbox'),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
        ),
      ),
    ),
  ),
  component(
    'BottomNavigationBar',
    (context) => DemoState<int>(
      initial: 0,
      builder: (context, index, setIndex) => SizedBox(
        width: 360,
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: setIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    ),
  ),
  component(
    'Drawer',
    (context) => SizedBox(
      width: 220,
      height: 280,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Drawer',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: FontSize.xl,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.inbox),
              title: const Text('Inbox'),
              onTap: () => showDemoSnack(context, 'Inbox'),
            ),
            ListTile(
              leading: const Icon(Icons.send),
              title: const Text('Sent'),
              onTap: () => showDemoSnack(context, 'Sent'),
            ),
          ],
        ),
      ),
    ),
  ),
]);
