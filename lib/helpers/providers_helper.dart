import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/darkmode_provider.dart';
import '../providers/datetime_provider.dart';
import '../providers/global_provider.dart';
import '../variables/provider_variables.dart';

// creating shortcut variables to access/change state
void createGlobalProviderReferences({BuildContext? context}) {
  globalWatch = context?.watch<GlobalProvider>();
  dateTimeWatch = context?.watch<DateTimeProvider>();
  themeWatch = context?.watch<DarkThemeProvider>();
}
