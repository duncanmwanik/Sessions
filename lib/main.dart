import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/theme/theme_styles.dart';

import 'helpers/firebase_auth/firebase_user_details_helper.dart';
import 'helpers/providers_helper.dart';
import 'providers/darkmode_provider.dart';
import 'services/local_storage_service.dart';
import 'screens/auth/welcome_screen.dart';
import 'screens/home/home_screen.dart';
import 'variables/provider_variables.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  localStorage = await SharedPreferences.getInstance();

  bool isFirstTime = await getUserStatusFromFirebaseAuth();

  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //     statusBarIconBrightness: Brightness.light,
  //     systemNavigationBarColor: Palette.primaryAccent,
  //     statusBarColor: Palette.transaparent,
  //   ),
  // );

  runApp(
    MultiProvider(
      providers: providers,
      child: MyApp(
        firstTime: isFirstTime,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required this.firstTime, super.key});

  final bool firstTime;

  @override
  Widget build(BuildContext context) {
    createGlobalProviderReferences(context: context);

    return Consumer<DarkThemeProvider>(builder: (context, appTheme, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sessions',
        theme: Styles.themeData(appTheme.isDarkTheme, context),
        home: !firstTime ? const WelcomeScreen() : const HomeScreen(),
      );
    });
  }
}
