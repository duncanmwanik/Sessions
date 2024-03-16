import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import '../../_providers/_provider_variables.dart';
import 'theme_helper.dart';

void onResumedAppState(AppLifecycleState state) {
  if (state == AppLifecycleState.resumed) {
    if (!kIsWeb) {
      themeProviderX.enableDarkTheme(getTheme());
    }
  }
}
