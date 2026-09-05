import 'package:widgetbook/widgetbook.dart';

import 'actions.dart';
import 'design_system.dart';
import 'display.dart';
import 'feedback.dart';
import 'inputs.dart';
import 'layout.dart';
import 'progress.dart';

// The full navigation tree handed to `Widgetbook.material`.
//
// Each entry is a [WidgetbookCategory] declared in one of the sibling catalog
// files, grouped roughly the way the Flutter Material library organises its
// widgets: things you tap, things you type into, things that show data, things
// that lay a screen out, things that pop over, things that report progress, and
// finally the design system's own primitives.
final List<WidgetbookNode> materialDirectories = [
  designSystemCategory,
  actionsCategory,
  displayCategory,
  feedbackCategory,
  inputsCategory,
  layoutCategory,
  progressCategory,
];
