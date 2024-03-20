import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/breakpoints.dart';
import 'package:sessions/_helpers/_common_helpers/keyboard.dart';
import 'package:sessions/features/home/layout/layout.dart';

import '../../_helpers/_common_helpers/background_ops.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_helpers/activity/listen_for_updates.dart';
import '../../_helpers/pending/retry_pending_actions.dart';
import '../../_helpers/user/listen_for_change.dart';
import '../../_variables/navigation_variables.dart';
import '../_tables/table_management/manager_drawer.dart';
import '_w/appbar.dart';
import '_w/fab.dart';
import '_w/navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late StreamSubscription<DatabaseEvent>? getTableUpdates;
  late StreamSubscription<DatabaseEvent>? getUserDataUpdates;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) => onResumedAppState(state);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    doSomeFirstTimeWork();
    retryPendingActions();
    getTableUpdates = listenForNewActivity();
    getUserDataUpdates = listenForUserDataChange();
    listenToKeyboardChanges();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    getTableUpdates?.cancel();
    getUserDataUpdates?.cancel();
    disposelListeningToKeyboardChanges();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => confirmExitApp(),
      child: Scaffold(
        appBar: homeAppBar(),
        body: Homelayout(),
        drawer: TableManagementDrawer(),
        bottomNavigationBar: !showWebNavBox() ? HomeNavBar() : null,
        floatingActionButton: HomeFABS(),
        key: homeX,
      ),
    );
  }
}
