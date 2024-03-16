import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/breakpoints.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';
import 'manager.dart';

class TableManagementDrawer extends StatelessWidget {
  const TableManagementDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: webDrawerWidth(),
      backgroundColor: styler.primaryColor(),
      elevation: 0,
      shape: isNotPhone()
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
              topRight: Radius.circular(borderRadiusMedium),
              bottomRight: Radius.circular(borderRadiusMedium),
            ))
          : null,
      child: TableManager(),
    );
  }
}
