import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sessions/_providers/common_providers/item_selection_provider.dart';
import 'package:sessions/_providers/common_providers/screen_size_provider.dart';
import 'package:sessions/features/auth/_state/auth_input_provider.dart';
import 'package:sessions/features/pomodoro/_state/pomodoro_provider.dart';
import 'package:sessions/features/tts/_state/tts_provider.dart';

import '../features/_lists/_state/board_input_provider.dart';
import '../features/_lists/_state/list_item_input_provider.dart';
import '../features/_sessions/_state/session_input_provider.dart';
import '../features/_sessions/_state/session_provider.dart';
import '../features/_tables/_state/table_input_provider.dart';
import '../features/flags/_state/flag_input_provider.dart';
import '../features/labels/_state/labels_provider.dart';
import '../features/notes/_state/task_input_provider.dart';
import '../features/reminders/_state/reminders_provider.dart';
import 'common_providers/activity_provider.dart';
import 'common_providers/datetime_provider.dart';
import 'common_providers/global_provider.dart';
import 'common_providers/layout_provider.dart';
import 'common_providers/theme_provider.dart';
import 'common_providers/views_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => SessionProvider()),
  ChangeNotifierProvider(create: (context) => GlobalProvider()),
  ChangeNotifierProvider(create: (context) => AuthInputProvider()),
  ChangeNotifierProvider(create: (context) => SessionInputProvider()),
  ChangeNotifierProvider(create: (context) => TableInputProvider()),
  ChangeNotifierProvider(create: (context) => TaskInputProvider()),
  ChangeNotifierProvider(create: (context) => FlagInputProvider()),
  ChangeNotifierProvider(create: (context) => LabelsProvider()),
  ChangeNotifierProvider(create: (context) => LayoutProvider()),
  ChangeNotifierProvider(create: (context) => ListInputProvider()),
  ChangeNotifierProvider(create: (context) => ListItemInputProvider()),
  ChangeNotifierProvider(create: (context) => DateTimeProvider()),
  ChangeNotifierProvider(create: (context) => ThemeProvider()),
  ChangeNotifierProvider(create: (context) => ActivityProvider()),
  ChangeNotifierProvider(create: (context) => ViewsProvider()),
  ChangeNotifierProvider(create: (context) => ReminderProvider()),
  ChangeNotifierProvider(create: (context) => ItemSelectionProvider()),
  ChangeNotifierProvider(create: (context) => ScreenSizeProvider()),
  ChangeNotifierProvider(create: (context) => TTSProvider()),
  ChangeNotifierProvider(create: (context) => PomodoroProvider()),
];

class ProvideMe {}

late BuildContext globalProviderContext;

late ThemeProvider themeProviderX;
late GlobalProvider globalProviderX;
late AuthInputProvider authProviderX;
late TableInputProvider tableInputProviderX;
late ListInputProvider listInputProviderX;
late TaskInputProvider taskInputProviderX;
late FlagInputProvider flagInputProviderX;
late SessionInputProvider sessionInputProviderX;
late ListItemInputProvider listItemInputProviderX;
late SessionProvider sessionProviderX;
late DateTimeProvider dateTimeProviderX;
late ActivityProvider activityProviderX;
late ViewsProvider viewsProviderX;
late LabelsProvider labelsProviderX;
late ItemSelectionProvider itemSelectionProviderX;
late ScreenSizeProvider screenSizeProviderX;
late ReminderProvider reminderProviderX;
late TTSProvider ttsProviderX;
late PomodoroProvider pomodoroProviderX;

void setGlobalProviderX(BuildContext context) {
  globalProviderContext = context;
  themeProviderX = globalProviderContext.read<ThemeProvider>();
  globalProviderX = globalProviderContext.read<GlobalProvider>();
  activityProviderX = globalProviderContext.read<ActivityProvider>();
  authProviderX = globalProviderContext.read<AuthInputProvider>();
  tableInputProviderX = globalProviderContext.read<TableInputProvider>();
  listInputProviderX = globalProviderContext.read<ListInputProvider>();
  taskInputProviderX = globalProviderContext.read<TaskInputProvider>();
  flagInputProviderX = globalProviderContext.read<FlagInputProvider>();
  sessionInputProviderX = globalProviderContext.read<SessionInputProvider>();
  listItemInputProviderX = globalProviderContext.read<ListItemInputProvider>();
  sessionProviderX = globalProviderContext.read<SessionProvider>();
  dateTimeProviderX = globalProviderContext.read<DateTimeProvider>();
  viewsProviderX = globalProviderContext.read<ViewsProvider>();
  labelsProviderX = globalProviderContext.read<LabelsProvider>();
  itemSelectionProviderX = globalProviderContext.read<ItemSelectionProvider>();
  screenSizeProviderX = globalProviderContext.read<ScreenSizeProvider>();
  reminderProviderX = globalProviderContext.read<ReminderProvider>();
  ttsProviderX = globalProviderContext.read<TTSProvider>();
  pomodoroProviderX = globalProviderContext.read<PomodoroProvider>();
}
