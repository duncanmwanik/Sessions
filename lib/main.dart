import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/_helpers/errors/error_handler.dart';

import '_config/routing/routes.dart';
import '_config/styling/styler.dart';
import '_config/styling/theme.dart';
import '_helpers/_common_helpers/theme_helper.dart';
import '_helpers/notifications/init_notifications.dart';
import '_providers/_provider_variables.dart';
import '_providers/common_providers/theme_provider.dart';
import '_services/cloud/firebase_database.dart';
import '_services/hive/load_boxes.dart';
import '_widgets/others/scroll.dart';
import 'features/auth/_helpers/user_details_helper.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeHive();
    await initializeFirebase();
    await isFirstTimeUserOnApp();
    await initializeNotifications();

    runApp(
      MultiProvider(
        providers: providers,
        child: MyApp(),
      ),
    );
  }, (error, stackTrace) => handleUnhandledExceptions(error, stackTrace));

  printThis('Setup Complete! ------------------------------');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      //
      // set theme to light if auth, so texts can be visible on the background images
      //
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isFirstTimeUser()) themeProvider.enableDarkTheme('light');
      });
      //
      // getting theme
      //
      bool isDarkTheme = getThemeAsBoolean(themeProvider.isDarkTheme);
      styler.setTheme(isDarkTheme);
      setGlobalProviderX(context);

      return ResponsiveSizer(
        builder: (_, __, ___) {
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            scrollBehavior: AppScrollBehavior(),
            builder: BotToastInit(),
            title: 'Sayari',
            theme: AppTheme.themeData(isDarkTheme),
          );
        },
      );
    });
  }
}
