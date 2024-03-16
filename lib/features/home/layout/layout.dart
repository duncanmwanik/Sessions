import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sessions/features/home/layout/web.dart';

import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/navigation_variables.dart';
import 'mobile.dart';

class Homelayout extends StatefulWidget {
  const Homelayout({Key? key}) : super(key: key);

  @override
  State<Homelayout> createState() => _HomelayoutState();
}

class _HomelayoutState extends State<Homelayout> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<Homelayout> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    homeTabController = TabController(initialIndex: globalBox.get('lastHomeView', defaultValue: 0), length: 5, vsync: this);
    homeTabController.addListener(() => globalBox.put('lastHomeView', homeTabController.index));
    super.initState();
  }

  @override
  void dispose() {
    homeTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Align(
      alignment: Alignment.topCenter,
      child: kIsWeb ? HomeWeblayout() : HomeMobilelayout(),
    );
  }
}
