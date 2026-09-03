import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'common.dart';

// ── Layout & navigation ──────────────────────────────────────────────────────
// App bars, tabs, navigation bars/rails/drawers and scaffolding. Every property
// is exposed as a knob: binary props and two-option enums render as switches,
// larger enums as dropdowns.

/// The [FloatingActionButtonLocation]s offered by the Scaffold/BottomAppBar
/// demos, keyed by a readable name for the dropdown.
const Map<String, FloatingActionButtonLocation> _fabLocations = {
  'endFloat': FloatingActionButtonLocation.endFloat,
  'endDocked': FloatingActionButtonLocation.endDocked,
  'centerFloat': FloatingActionButtonLocation.centerFloat,
  'centerDocked': FloatingActionButtonLocation.centerDocked,
  'startFloat': FloatingActionButtonLocation.startFloat,
};

FloatingActionButtonLocation _fabLocationKnob(
  BuildContext context, {
  String label = 'FAB location',
}) {
  return context.knobs.object.dropdown<FloatingActionButtonLocation>(
    label: label,
    options: _fabLocations.values.toList(),
    initialOption: FloatingActionButtonLocation.endFloat,
    labelBuilder: (value) =>
        _fabLocations.entries.firstWhere((entry) => entry.value == value).key,
  );
}

/// App bars, tabs, navigation bars/rails/drawers and scaffolding.
WidgetbookCategory get layoutCategory => category('Layout & Navigation', [
  component('Scaffold', (context) {
    final k = context.knobs;
    final resizeToAvoidBottomInset = k.boolean(
      label: 'Resize to avoid bottom inset',
      initialValue: true,
    );
    final extendBody = k.boolean(label: 'Extend body', initialValue: false);
    final extendBodyBehindAppBar = k.boolean(
      label: 'Extend body behind app bar',
      initialValue: false,
    );
    final primary = k.boolean(label: 'Primary', initialValue: true);
    final hasAppBar = k.boolean(label: 'App bar', initialValue: true);
    final hasFab = k.boolean(
      label: 'Floating action button',
      initialValue: true,
    );
    final fabLocation = _fabLocationKnob(context);
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    final bodyText = k.string(label: 'Body text', initialValue: 'Body content');
    return SizedBox(
      width: 320,
      height: 240,
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        primary: primary,
        backgroundColor: backgroundColor,
        floatingActionButtonLocation: fabLocation,
        appBar: hasAppBar ? AppBar(title: const Text('Scaffold')) : null,
        floatingActionButton: hasFab
            ? FloatingActionButton(
                onPressed: () => showDemoSnack(context, 'FAB pressed'),
                child: const Icon(Icons.add),
              )
            : null,
        body: Center(child: Text(bodyText)),
      ),
    );
  }),
  component('AppBar', (context) {
    final k = context.knobs;
    final title = k.string(label: 'Title', initialValue: 'AppBar');
    final centerTitle = k.booleanOrNull(
      label: 'Center title',
      defaultToNull: true,
    );
    final automaticallyImplyLeading = k.boolean(
      label: 'Automatically imply leading',
      initialValue: true,
    );
    final hasLeading = k.boolean(label: 'Leading', initialValue: true);
    final hasActions = k.boolean(label: 'Actions', initialValue: true);
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 0,
      min: 0,
      max: 12,
      defaultToNull: true,
    );
    final scrolledUnderElevation = k.doubleOrNull.slider(
      label: 'Scrolled under elevation',
      initialValue: 3,
      min: 0,
      max: 12,
      defaultToNull: true,
    );
    final toolbarHeight = k.double.slider(
      label: 'Toolbar height',
      initialValue: 56,
      min: 32,
      max: 96,
      divisions: 32,
    );
    final titleSpacing = k.double.slider(
      label: 'Title spacing',
      initialValue: 16,
      min: 0,
      max: 32,
      divisions: 32,
    );
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    final foregroundColor = k.colorOrNull(
      label: 'Foreground color',
      defaultToNull: true,
    );
    final forceMaterialTransparency = k.boolean(
      label: 'Force material transparency',
      initialValue: false,
    );
    return SizedBox(
      width: 360,
      height: 120,
      child: Scaffold(
        body: const SizedBox.shrink(),
        appBar: AppBar(
          title: Text(title),
          centerTitle: centerTitle,
          automaticallyImplyLeading: automaticallyImplyLeading,
          elevation: elevation,
          scrolledUnderElevation: scrolledUnderElevation,
          toolbarHeight: toolbarHeight,
          titleSpacing: titleSpacing,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          forceMaterialTransparency: forceMaterialTransparency,
          leading: hasLeading
              ? IconButton(icon: const Icon(Icons.menu), onPressed: () {})
              : null,
          actions: hasActions
              ? [
                  IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ]
              : null,
        ),
      ),
    );
  }),
  component('BottomAppBar', (context) {
    final k = context.knobs;
    final hasFab = k.boolean(label: 'Docked FAB', initialValue: true);
    final fabLocation = _fabLocationKnob(context);
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 3,
      min: 0,
      max: 16,
      defaultToNull: true,
    );
    final height = k.doubleOrNull.slider(
      label: 'Height',
      initialValue: 80,
      min: 48,
      max: 120,
      defaultToNull: true,
    );
    final color = k.colorOrNull(label: 'Color', defaultToNull: true);
    final surfaceTintColor = k.colorOrNull(
      label: 'Surface tint color',
      defaultToNull: true,
    );
    final shadowColor = k.colorOrNull(
      label: 'Shadow color',
      defaultToNull: true,
    );
    final notched = k.boolean(
      label: 'Notch shape',
      description: 'off: circular rectangle · on: automatic (rounded rect)',
      initialValue: false,
    );
    final padding = k.double.slider(
      label: 'Padding',
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
    return SizedBox(
      width: 320,
      height: 160,
      child: Scaffold(
        body: const SizedBox.shrink(),
        floatingActionButtonLocation: fabLocation,
        floatingActionButton: hasFab
            ? FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              )
            : null,
        bottomNavigationBar: BottomAppBar(
          elevation: elevation,
          height: height,
          color: color,
          surfaceTintColor: surfaceTintColor,
          shadowColor: shadowColor,
          shape: notched
              ? const AutomaticNotchedShape(RoundedRectangleBorder())
              : const CircularNotchedRectangle(),
          padding: EdgeInsets.all(padding),
          clipBehavior: clip,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }),
  component('TabBar', (context) {
    final k = context.knobs;
    final isScrollable = k.boolean(label: 'Scrollable', initialValue: false);
    final rawAlignment = optionKnob<TabAlignment>(
      context,
      label: 'Tab alignment',
      options: TabAlignment.values,
      initial: TabAlignment.fill,
    );
    // Guard against the TabBar alignment/scrollable assertion: `fill` needs a
    // non-scrollable bar, `start`/`startOffset` need a scrollable one.
    final tabAlignment = isScrollable
        ? (rawAlignment == TabAlignment.fill
              ? TabAlignment.start
              : rawAlignment)
        : (rawAlignment == TabAlignment.start ||
                  rawAlignment == TabAlignment.startOffset
              ? TabAlignment.fill
              : rawAlignment);
    final indicatorSize = optionKnob<TabBarIndicatorSize>(
      context,
      label: 'Indicator size',
      options: TabBarIndicatorSize.values,
      initial: TabBarIndicatorSize.tab,
    );
    final dividerHeight = k.double.slider(
      label: 'Divider height',
      initialValue: 1,
      min: 0,
      max: 4,
      divisions: 8,
      precision: 1,
    );
    final indicatorWeight = k.double.slider(
      label: 'Indicator weight',
      initialValue: 3,
      min: 0,
      max: 8,
      divisions: 16,
      precision: 1,
    );
    final indicatorColor = k.colorOrNull(
      label: 'Indicator color',
      defaultToNull: true,
    );
    final dividerColor = k.colorOrNull(
      label: 'Divider color',
      defaultToNull: true,
    );
    final labelColor = k.colorOrNull(label: 'Label color', defaultToNull: true);
    final unselectedLabelColor = k.colorOrNull(
      label: 'Unselected label color',
      defaultToNull: true,
    );
    final overlayColor = k.colorOrNull(
      label: 'Overlay color',
      defaultToNull: true,
    );
    final showIcons = k.boolean(label: 'Tab icons', initialValue: true);
    return DefaultTabController(
      length: 3,
      child: SizedBox(
        width: 360,
        height: 180,
        child: Column(
          children: [
            TabBar(
              isScrollable: isScrollable,
              tabAlignment: tabAlignment,
              indicatorSize: indicatorSize,
              dividerHeight: dividerHeight,
              dividerColor: dividerColor,
              indicatorColor: indicatorColor,
              indicatorWeight: indicatorWeight,
              labelColor: labelColor,
              unselectedLabelColor: unselectedLabelColor,
              overlayColor: WidgetStatePropertyAll(overlayColor),
              tabs: [
                Tab(
                  text: 'One',
                  icon: showIcons ? const Icon(Icons.looks_one) : null,
                ),
                Tab(
                  text: 'Two',
                  icon: showIcons ? const Icon(Icons.looks_two) : null,
                ),
                Tab(
                  text: 'Three',
                  icon: showIcons ? const Icon(Icons.looks_3) : null,
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('Tab one')),
                  Center(child: Text('Tab two')),
                  Center(child: Text('Tab three')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }),
  component('NavigationBar', (context) {
    final k = context.knobs;
    final labelBehavior = optionKnob<NavigationDestinationLabelBehavior>(
      context,
      label: 'Label behavior',
      options: NavigationDestinationLabelBehavior.values,
      initial: NavigationDestinationLabelBehavior.alwaysShow,
    );
    final height = k.doubleOrNull.slider(
      label: 'Height',
      initialValue: 80,
      min: 56,
      max: 120,
      defaultToNull: true,
    );
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 3,
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
    final shadowColor = k.colorOrNull(
      label: 'Shadow color',
      defaultToNull: true,
    );
    final indicatorColor = k.colorOrNull(
      label: 'Indicator color',
      defaultToNull: true,
    );
    return DemoState<int>(
      initial: 0,
      builder: (context, index, setIndex) => SizedBox(
        width: 360,
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: setIndex,
          height: height,
          elevation: elevation,
          backgroundColor: backgroundColor,
          surfaceTintColor: surfaceTintColor,
          shadowColor: shadowColor,
          indicatorColor: indicatorColor,
          labelBehavior: labelBehavior,
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
    );
  }),
  component('NavigationRail', (context) {
    final k = context.knobs;
    final extended = k.boolean(label: 'Extended', initialValue: false);
    final rawLabelType = optionKnob<NavigationRailLabelType>(
      context,
      label: 'Label type',
      options: NavigationRailLabelType.values,
      initial: NavigationRailLabelType.all,
    );
    // `extended` may only be combined with a `none` label type.
    final labelType = extended ? NavigationRailLabelType.none : rawLabelType;
    final useIndicator = k.boolean(label: 'Use indicator', initialValue: true);
    final groupAlignment = k.double.slider(
      label: 'Group alignment',
      initialValue: -1,
      min: -1,
      max: 1,
      divisions: 20,
      precision: 2,
    );
    final minWidth = k.doubleOrNull.slider(
      label: 'Min width',
      initialValue: 72,
      min: 48,
      max: 160,
      defaultToNull: true,
    );
    final minExtendedWidth = k.doubleOrNull.slider(
      label: 'Min extended width',
      initialValue: 200,
      min: 120,
      max: 320,
      defaultToNull: true,
    );
    final indicatorColor = k.colorOrNull(
      label: 'Indicator color',
      defaultToNull: true,
    );
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    // NavigationRail asserts elevation > 0 when non-null.
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 3,
      min: 1,
      max: 16,
      defaultToNull: true,
    );
    return DemoState<int>(
      initial: 0,
      builder: (context, index, setIndex) => SizedBox(
        width: 320,
        height: 280,
        child: NavigationRail(
          selectedIndex: index,
          onDestinationSelected: setIndex,
          extended: extended,
          labelType: labelType,
          useIndicator: useIndicator,
          groupAlignment: groupAlignment,
          minWidth: minWidth,
          minExtendedWidth: minExtendedWidth,
          indicatorColor: indicatorColor,
          backgroundColor: backgroundColor,
          elevation: elevation,
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
    );
  }),
  component('NavigationDrawer', (context) {
    final k = context.knobs;
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 1,
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
    final shadowColor = k.colorOrNull(
      label: 'Shadow color',
      defaultToNull: true,
    );
    final showHeader = k.boolean(label: 'Header', initialValue: true);
    final headerTitle = k.string(label: 'Header title', initialValue: 'Drawer');
    return DemoState<int>(
      initial: 0,
      builder: (context, index, setIndex) => SizedBox(
        width: 260,
        height: 300,
        child: NavigationDrawer(
          selectedIndex: index,
          onDestinationSelected: setIndex,
          elevation: elevation,
          backgroundColor: backgroundColor,
          surfaceTintColor: surfaceTintColor,
          shadowColor: shadowColor,
          children: [
            if (showHeader)
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
                child: Text(
                  headerTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
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
    );
  }),
  component('BottomNavigationBar', (context) {
    final k = context.knobs;
    final type = optionKnob<BottomNavigationBarType>(
      context,
      label: 'Type',
      options: BottomNavigationBarType.values,
      initial: BottomNavigationBarType.fixed,
    );
    final showSelectedLabels = k.boolean(
      label: 'Show selected labels',
      initialValue: true,
    );
    final showUnselectedLabels = k.boolean(
      label: 'Show unselected labels',
      initialValue: true,
    );
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 8,
      min: 0,
      max: 24,
      defaultToNull: true,
    );
    final iconSize = k.double.slider(
      label: 'Icon size',
      initialValue: 24,
      min: 16,
      max: 40,
      divisions: 24,
    );
    final selectedFontSize = k.double.slider(
      label: 'Selected font size',
      initialValue: 14,
      min: 8,
      max: 24,
      divisions: 16,
      precision: 1,
    );
    final unselectedFontSize = k.double.slider(
      label: 'Unselected font size',
      initialValue: 12,
      min: 8,
      max: 24,
      divisions: 16,
      precision: 1,
    );
    final fixedColor = k.colorOrNull(label: 'Fixed color', defaultToNull: true);
    final backgroundColor = k.colorOrNull(
      label: 'Background color',
      defaultToNull: true,
    );
    final selectedItemColor = k.colorOrNull(
      label: 'Selected item color',
      defaultToNull: true,
    );
    final unselectedItemColor = k.colorOrNull(
      label: 'Unselected item color',
      defaultToNull: true,
    );
    return DemoState<int>(
      initial: 0,
      builder: (context, index, setIndex) => SizedBox(
        width: 360,
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: setIndex,
          type: type,
          showSelectedLabels: showSelectedLabels,
          showUnselectedLabels: showUnselectedLabels,
          elevation: elevation,
          iconSize: iconSize,
          selectedFontSize: selectedFontSize,
          unselectedFontSize: unselectedFontSize,
          fixedColor: fixedColor,
          backgroundColor: backgroundColor,
          selectedItemColor: selectedItemColor,
          unselectedItemColor: unselectedItemColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }),
  component('Drawer', (context) {
    final k = context.knobs;
    final hasHeader = k.boolean(label: 'Header', initialValue: true);
    final headerTitle = k.string(label: 'Header title', initialValue: 'Drawer');
    final elevation = k.doubleOrNull.slider(
      label: 'Elevation',
      initialValue: 16,
      min: 0,
      max: 32,
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
    final width = k.doubleOrNull.slider(
      label: 'Width',
      initialValue: 220,
      min: 160,
      max: 320,
      defaultToNull: true,
    );
    final clip = optionKnob<Clip>(
      context,
      label: 'Clip behavior',
      options: Clip.values,
      initial: Clip.none,
    );
    return SizedBox(
      width: 240,
      height: 300,
      child: Drawer(
        elevation: elevation,
        backgroundColor: backgroundColor,
        shadowColor: shadowColor,
        surfaceTintColor: surfaceTintColor,
        width: width,
        clipBehavior: clip,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            if (hasHeader)
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    headerTitle,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20,
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
    );
  }),
]);
