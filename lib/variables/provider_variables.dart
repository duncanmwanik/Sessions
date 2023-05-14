import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../providers/darkmode_provider.dart';
import '../providers/datetime_provider.dart';
import '../providers/global_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => GlobalProvider()),
  ChangeNotifierProvider(create: (context) => DateTimeProvider()),
  ChangeNotifierProvider(create: (context) => DarkThemeProvider()),
];

// Provider refs
var globalWatch;
var dateTimeWatch;
var themeWatch;
