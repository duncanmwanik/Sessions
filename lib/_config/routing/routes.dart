import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sessions/features/auth/email_auth_screen.dart';

import '../../features/auth/_helpers/user_details_helper.dart';
import '../../features/error/error_screen.dart';
import '../../features/home/home.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/welcome/welcome_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: isFirstTimeUser() ? '/welcome' : '/',
  observers: [BotToastNavigatorObserver()],
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/welcome', builder: (context, state) => WelcomeScreen()),
    GoRoute(path: '/emailauth', builder: (context, state) => EmailAuthScreen()),
    GoRoute(path: '/settings', builder: (context, state) => SettingsScreen()),
  ],
  errorPageBuilder: (context, state) {
    return MaterialPage(child: ErrorScreen());
  },
);
