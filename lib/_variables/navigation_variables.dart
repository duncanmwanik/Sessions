import 'dart:async';

import 'package:flutter/material.dart';

final FocusNode listEntryFocusNode = FocusNode();
FocusNode newEntryFocusNode = FocusNode();

PageController dayViewPageController = PageController(initialPage: 366);
PageController weeklyViewPageController = PageController(initialPage: 366);

late TabController ntTabController;
late TabController homeTabController;

final GlobalKey<ScaffoldState> homeX = GlobalKey();
final GlobalKey<ScaffoldState> welcomeX = GlobalKey();

late AnimationController animateController;

late PersistentBottomSheetController bottomSheetController;

late StreamSubscription<bool> keyboardSubscription;
